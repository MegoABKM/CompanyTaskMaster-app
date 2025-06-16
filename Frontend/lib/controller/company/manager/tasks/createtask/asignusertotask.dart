import 'package:get/get.dart';
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/data/datasource/remote/company/manager/assigneemployeetotask.dart';
import 'package:tasknotate/data/model/company/companymodel.dart';
import 'package:tasknotate/view/screen/company/manager/tasks/createtask/createsubtask.dart';

class Asignusertotaskcontroller extends GetxController {
  List<Employees> employees = [];
  List<Employees> assignedEmployees = [];
  AssigneemployeetotaskData assigneemployeetotaskData =
      AssigneemployeetotaskData(Get.find());

  String? taskid;
  StatusRequest? statusRequest;
  void assignEmployee(Employees employee) {
    if (!assignedEmployees.contains(employee)) {
      assignedEmployees.add(employee);
      update();
    }
  }

  void removeEmployee(Employees employee) {
    assignedEmployees.remove(employee);
    update();
  }

  Future<void> insertData() async {
    // If no employees exist, skip to the next page
    if (employees.isEmpty) {
      Get.off(CreateSubtasksPage(), arguments: {"taskid": taskid});
      Get.snackbar("Info", "No employees available, proceeding to subtasks.");
      return;
    }

    // If employees exist but none are assigned, show error
    if (assignedEmployees.isEmpty) {
      Get.snackbar("Error", "Please assign at least one employee.");
      return;
    }

    try {
      statusRequest = StatusRequest.loading;
      update();
      String userIds =
          assignedEmployees.map((e) => e.employeeId.toString()).join(",");

      print("Comma-separated user IDs: $userIds");

      // Send the data to the backend
      final response = await assigneemployeetotaskData.insertData(
        taskid.toString(),
        userIds,
      );

      // Check the response
      if (response['status'] == 'success') {
        Get.off(CreateSubtasksPage(), arguments: {"taskid": taskid});
        Get.snackbar("Success", "Employees assigned successfully!");
        statusRequest = StatusRequest.success;
        update();
      } else {
        Get.snackbar(
            "Error", response['message'] ?? "Failed to assign employees.");
      }
    } catch (e) {
      Get.snackbar("Error", "An unexpected error occurred: $e");
    }
    statusRequest = null;
    update();
  }

  void skipToSubtasks() {
    Get.off(CreateSubtasksPage(), arguments: {"taskid": taskid});
    if (employees.isEmpty) {
      Get.snackbar("Info", "No employees available, proceeding to subtasks.");
    }
  }

  @override
  void onInit() {
    super.onInit();
    print("Get.arguments: ${Get.arguments}");
    employees = Get.arguments['companyemployee'] ?? [];
    taskid = Get.arguments['taskid'];
  }
}
