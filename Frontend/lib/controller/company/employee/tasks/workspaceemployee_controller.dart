import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/core/services/services.dart';
import 'package:companymanagment/data/datasource/remote/company/workspace.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';
import 'package:companymanagment/data/model/company/tasks/taskcompanymodel.dart';
import 'package:companymanagment/view/screen/company/employee/tasks/view_task_company_employee.dart';

class WorkspaceEmployeeController extends GetxController {
  WorkspaceData workspaceData = WorkspaceData(Get.find());
  List<TaskCompanyModel> taskcompany = [];
  String? companyid;
  List<Employees>? companyemployee = [];
  List<TaskStatus> taskStatuses = TaskStatus.values;
  StatusRequest? statusRequest;
  String? userid;
  MyServices myServices = Get.find();
  String? username;
  int progress = 0;
  int completedTasks = 0;

  insertUpdateTaskStatus(
      String? taskid, String? status, String? tasktitle) async {
    print(" the $taskid  ,,,  $status  ,,  $userid");
    var response = await workspaceData.insertUpdateTaskStatus(
        taskid, userid!, status!, username, tasktitle);

    if (response["status"] == "success") {
      Get.defaultDialog(
        title: "Success",
        middleText: "Task status has been sent to the manager successfully!",
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back(); // Close dialog
        },
      );
    }
  }

  Future<void> getData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await workspaceData.getData(companyid);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      try {
        taskcompany = (response['tasks'] as List)
            .map((item) => TaskCompanyModel.fromJson(item))
            .toList();
        completedTasks = response['taskscompleted'] ?? 0;
        progress = taskcompany.isNotEmpty
            ? ((completedTasks / taskcompany.length) * 100).round()
            : 0;
      } catch (e) {
        print("Error parsing response data: $e");
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  goToDetailsTask(TaskCompanyModel taskcompanydetail) {
    Get.to(const ViewTaskCompanyEmployee(), arguments: {
      "taskcompanydetail": taskcompanydetail,
      "companyemployee": companyemployee
    });
  }

  @override
  void onInit() async {
    userid = myServices.sharedPreferences.getString("id");
    username = myServices.sharedPreferences.getString("username");
    companyid = await Get.arguments['companyid'];
    companyemployee = await Get.arguments['companyemployee'];

    await getData();
    super.onInit();
  }
}

enum TaskStatus {
  pending,
  acknowledged,
  inProgress,
  completed,
  notAcknowledged,
}

extension TaskStatusExtension on TaskStatus {
  String get value {
    switch (this) {
      case TaskStatus.pending:
        return "Pending";
      case TaskStatus.acknowledged:
        return "Acknowledged";
      case TaskStatus.inProgress:
        return "In Progress";
      case TaskStatus.completed:
        return "Completed";
      case TaskStatus.notAcknowledged:
        return "Not Acknowledged";
    }
  }
}
