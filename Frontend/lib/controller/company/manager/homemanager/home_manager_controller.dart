import 'package:companymanagment/view/screen/company/manager/company/view_company_details_manager.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/functions/firebasetopicnotification.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/core/services/services.dart';
import 'package:companymanagment/data/datasource/remote/company/manager/managerhome_data.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';
import 'package:companymanagment/data/model/company/notifitaskstatusmodel.dart';
import 'package:companymanagment/data/model/company/project_model.dart'; // IMPORT THE CORRECT PROJECT MODEL
import 'package:timeago/timeago.dart' as timeago;

class ManagerhomeController extends GetxController {
  List<CompanyModel> companyData = [];
  List<TaskCheckModel> taskcheck = [];
  List<ProjectModel> activeProjects = [];
  MyServices myServices = Get.find();
  String? userid;
  int currentIndex = 0;

  StatusRequest? statusRequest;
  ManagerhomeData managerhomeData = ManagerhomeData(Get.find());

  Future<void> getData() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await managerhomeData.getData(userid);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      companyData.clear();
      taskcheck.clear();
      activeProjects.clear();

      if (response['data'] != null && response['data'] is Map) {
        final data = response['data'];

        if (data['company'] != null && data['company'] is List) {
          companyData = (data['company'] as List)
              .map((item) => CompanyModel.fromJson(item))
              .toList();
        }

        if (data['taskcheck'] != null && data['taskcheck'] is List) {
          taskcheck = (data['taskcheck'] as List)
              .map((item) => TaskCheckModel.fromJson(item))
              .toList();
        }

        // THE FIX IS HERE: Parse the data using ProjectModel.fromJson
        if (data['active_projects'] != null &&
            data['active_projects'] is List) {
          activeProjects = (data['active_projects'] as List)
              .map((item) => ProjectModel.fromJson(item))
              .toList();
        }
      } else {
        print("Warning: 'data' field is missing or not a Map in the response.");
      }

      print("Fetched Company Data: ${companyData.length} items");
      print("Fetched TaskCheck Data: ${taskcheck.length} items");
      print("Fetched Active Projects: ${activeProjects.length} items");
    } else {
      print("Failed to fetch data: $statusRequest");
    }
    update();
  }

  goToDetailsCompany(CompanyModel companydata) {
    Get.to(() => const ViewCompanyManager(),
        arguments: {"companydata": companydata});
  }

  formatDate(String? inputDate) {
    String formattedDate = "Unknown"; // Default value
    if (inputDate != null) {
      DateTime? taskDate = DateTime.tryParse(inputDate);
      if (taskDate != null) {
        formattedDate = timeago.format(taskDate);
        return formattedDate;
      }
    }
  }

  @override
  void onInit() {
    userid = myServices.sharedPreferences.getString("id");

    if (userid != null && userid!.isNotEmpty) {
      subscribeToTopic(userid!);
      getData();
    } else {
      print("User ID is null or empty. Cannot fetch manager data.");
      statusRequest = StatusRequest.failure;
      update();
    }
    super.onInit();
  }
}
