import 'package:get/get.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/core/services/services.dart';
import 'package:companymanagment/data/datasource/remote/company/manager/notificationmanager_data.dart';
import 'package:companymanagment/data/model/company/notifitaskstatusmodel.dart';

class NotificationManagerController extends GetxController {
  List<TaskCheckModel> taskStatusModel = [];
  NotificationmanagerData notificationManagerData =
      NotificationmanagerData(Get.find());
  StatusRequest? statusRequest;
  String? userId;
  MyServices myServices = Get.find();

  // Fetch data from the API
  void getData() async {
    // Set the status request to loading
    statusRequest = StatusRequest.loading;
    update();

    // Fetch data from the notification manager service
    Map<String, dynamic> response =
        await notificationManagerData.getData(userId);

    // Handle the response data
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        if (response["data"] is List && response["data"].isNotEmpty) {
          // Parse the task status model list from the response data
          taskStatusModel = (response["data"] as List)
              .map((item) => TaskCheckModel.fromJson(item))
              .toList();
        } else {
          taskStatusModel = [];
          Get.snackbar("Error", "No task data available");
        }
      } else {
        taskStatusModel = [];
        Get.snackbar("Error", "Failed to load task data");
      }
      update();
    } else {
      Get.snackbar("Error", "An error occurred while fetching data");
    }
  }

  @override
  void onInit() {
    userId = myServices.sharedPreferences.getString("id");
    getData();
    super.onInit();
  }
}
