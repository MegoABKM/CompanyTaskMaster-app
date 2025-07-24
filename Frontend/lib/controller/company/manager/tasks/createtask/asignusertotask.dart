import 'package:get/get.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/data/datasource/remote/company/manager/assigneemployeetotask.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';
import 'package:companymanagment/view/screen/company/manager/tasks/createtask/createsubtask.dart';

class Asignusertotaskcontroller extends GetxController {
  List<Employees> employees = [];
  List<Employees> assignedEmployees = [];
  AssigneemployeetotaskData assigneemployeetotaskData =
      AssigneemployeetotaskData(Get.find());

  String? taskid;
  StatusRequest? statusRequest;

  // This is the new, reusable navigation function.
  Future<void> _navigateToNextScreen() async {
    final result = await Get.to(
      () => const CreateSubtasksPage(),
      arguments: {"taskid": taskid},
    );

    if (result == 'created_task') {
      Get.back(result: 'created_task');
    }
  }

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
    if (employees.isEmpty) {
      await _navigateToNextScreen();
      return;
    }

    if (assignedEmployees.isEmpty) {
      Get.snackbar("Error", "Please assign at least one employee.");
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    try {
      String userIds =
          assignedEmployees.map((e) => e.employeeId.toString()).join(",");

      print("Comma-separated user IDs: $userIds");

      var response = await assigneemployeetotaskData.insertData(
        taskid.toString(),
        userIds,
      );

      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          Get.snackbar("Success", "Employees assigned successfully!");
          await _navigateToNextScreen(); // Navigate to the next step
        } else {
          Get.snackbar(
              "Error", response['message'] ?? "Failed to assign employees.");
          statusRequest = StatusRequest.failure;
        }
      }
    } catch (e) {
      Get.snackbar("Error", "An unexpected error occurred: $e");
      statusRequest = StatusRequest.failure;
    } finally {
      if (statusRequest != StatusRequest.success) {
        update();
      }
    }
  }

  void skipToSubtasks() async {
    if (employees.isEmpty) {
      Get.snackbar("Info", "No employees available, proceeding to subtasks.");
    }
    await _navigateToNextScreen();
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      // THE FIX IS HERE
      var employeeData = Get.arguments['companyemployee'];
      if (employeeData != null && employeeData is List) {
        // Safely cast and map the list to the correct type
        employees = employeeData.map((e) => e as Employees).toList();
      } else {
        employees = [];
      }

      taskid = Get.arguments['taskid'];
    }
  }
}
