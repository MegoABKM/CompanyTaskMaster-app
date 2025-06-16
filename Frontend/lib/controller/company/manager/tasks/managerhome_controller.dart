import 'package:get/get.dart';
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/core/functions/firebasetopicnotification.dart';
import 'package:tasknotate/core/functions/handlingdatacontroller.dart';
import 'package:tasknotate/core/services/services.dart';
import 'package:tasknotate/data/datasource/remote/company/manager/managerhome_data.dart';
import 'package:tasknotate/data/model/company/companymodel.dart';
import 'package:tasknotate/data/model/company/notifitaskstatusmodel.dart';
import 'package:timeago/timeago.dart' as timeago;

class ManagerhomeController extends GetxController {
  List<CompanyModel> companyData = [];
  List<TaskCheckModel> taskcheck = [];
  MyServices myServices = Get.find();
  String? userid;

  StatusRequest? statusRequest;
  ManagerhomeData managerhomeData = ManagerhomeData(Get.find());

  Future<void> getData() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await managerhomeData.getData(userid);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      try {
        companyData = (response['data']['company'] as List)
            .map((item) => CompanyModel.fromJson(item))
            .toList();
        taskcheck = (response['data']['taskcheck'] as List)
            .map((item) => TaskCheckModel.fromJson(item))
            .toList();

        update();
        print("Fetched Company Data: $companyData");
        print("Fetched TaskCheck Data: $taskcheck");
      } catch (e) {
        print("Error parsing response data to models: $e");
        statusRequest = StatusRequest.failure;
      }
    } else {
      print("Failed to fetch data: $statusRequest");
    }
    update();
  }

  goToDetailsCompany(companydata) {
    Get.toNamed(AppRoute.infocompany, arguments: {"companydata": companydata});
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
    subscribeToTopic(userid!);
    if (userid == null || userid!.isEmpty) {
      print("User ID is null or empty.");
      statusRequest = StatusRequest.failure;
      update();
      return;
    }
    getData();
    super.onInit();
  }
}
