import 'package:get/get.dart';
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/core/functions/handlingdatacontroller.dart';
import 'package:tasknotate/data/datasource/remote/company/workspace.dart';
import 'package:tasknotate/data/model/company/companymodel.dart';
import 'package:tasknotate/data/model/company/tasks/taskcompanymodel.dart';
import 'package:tasknotate/view/screen/company/manager/tasks/createtask/createtaskcompany.dart';
import 'package:tasknotate/view/screen/company/manager/tasks/viewtaskcompany.dart';

class WorkspaceController extends GetxController {
  final WorkspaceData workspaceData = WorkspaceData(Get.find());
  List<TaskCompanyModel> taskcompany = [];
  String? companyid;
  List<Employees>? companyemployee = [];
  StatusRequest? statusRequest;
  int progress = 0;
  int completedTasks = 0;

  @override
  void onInit() async {
    companyid = Get.arguments['companyid'];
    companyemployee = Get.arguments['companyemployee'];
    await getData();
    super.onInit();
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

  Future<void> updateCompletedTasks(int newCompletedTasks) async {
    statusRequest = StatusRequest.loading;
    update();
    if (newCompletedTasks > taskcompany.length) {
      return Get.defaultDialog(
          title: "Completed tasks is more than the tasks you have");
    }
    var response =
        await workspaceData.updateProgress(companyid, newCompletedTasks);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        completedTasks = newCompletedTasks;
        progress = taskcompany.isNotEmpty
            ? ((completedTasks / taskcompany.length) * 100).round()
            : 0;
        Get.snackbar("Success", "Progress updated successfully");
      } else {
        Get.snackbar("Error", "Failed to update progress on server");
      }
    } else {
      Get.snackbar("Error", "Network or server error occurred");
    }
    update();
  }

  Future<void> deleteTask(String taskid) async {
    var response = await workspaceData.deleteData(taskid);
    if (response['status'] == "success") {
      taskcompany.removeWhere((task) => task.id.toString() == taskid);
      progress = taskcompany.isNotEmpty
          ? ((completedTasks / taskcompany.length) * 100).round()
          : 0;
      update();
    }
  }

  void goToDetailsTask(TaskCompanyModel taskcompanydetail) {
    Get.to(const ViewTaskCompany(), arguments: {
      "taskcompanydetail": taskcompanydetail,
      "companyemployee": companyemployee
    });
  }

  void goToCompanyCreateTask() {
    Get.to(const CreateTaskCompany(), arguments: {
      "companyid": companyid,
      "companyemployee": companyemployee
    });
  }
}
