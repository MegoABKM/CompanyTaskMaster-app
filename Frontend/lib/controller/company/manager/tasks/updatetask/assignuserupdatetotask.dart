import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/tasks/viewtask_controller.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/data/datasource/remote/company/manager/assigneemployeetotask.dart';
import 'package:companymanagment/data/model/company/tasks/assignedemployeemodel.dart';
import 'package:companymanagment/data/model/company/tasks/attachmentmodel.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';
import 'package:companymanagment/data/model/company/tasks/subtasksmode.dart';
import 'package:companymanagment/data/model/company/tasks/taskcompanymodel.dart';
import 'package:companymanagment/view/screen/company/manager/tasks/updatetask/updatesubtask.dart';

class AsignuserUpdatetotaskcontroller extends GetxController {
  TaskCompanyModel? taskcompanydetail;
  List<Assignedemployeemodel> assignedemployee = [];
  List<SubtaskModel> subtasks = [];
  List<AttachmentModel> attachments = [];
  List<Employees>? companyemployee = [];
  String? from;
  List<Assignedemployeemodel> oldAssignemployeetotask = [];
  List<Employees> employees = [];
  List<Employees> newAssignedEmployees = [];
  AssigneemployeetotaskData assigneemployeetotaskData =
      AssigneemployeetotaskData(Get.find());
  StatusRequest? statusRequest;

  void assignEmployee(Employees employee) {
    if (!newAssignedEmployees.contains(employee)) {
      newAssignedEmployees.add(employee);
      update();
    }
  }

  void removeEmployee(Employees employee) {
    newAssignedEmployees.remove(employee);
    update();
  }

  Future<void> updatedata() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      String newUserIds =
          newAssignedEmployees.map((e) => e.employeeId.toString()).join(",");

      final response = await assigneemployeetotaskData.updateData(
          taskcompanydetail!.id, newUserIds);

      statusRequest = StatusRequest.success;
      update();

      if (response['status'] == 'success') {
        print("========updating the assign==$from");
        if (from == "edit") {
          goToViewTask();
        } else {
          goToSubTask();
        }
        Get.snackbar("Success", response['message']);
      } else {
        statusRequest = StatusRequest.failure;
        update();
        Get.snackbar(
            "Error", response['message'] ?? "Failed to process request.");
      }
    } catch (e) {
      statusRequest = StatusRequest.failure;
      update();
      Get.snackbar("Error", "An unexpected error occurred: $e");
    }
  }

  void goToSubTask() {
    Get.off(const UpdatesubtaskView(), arguments: {
      'taskcompanydetail': taskcompanydetail,
      "companyemployee": employees,
      'assignedemployee': newAssignedEmployees,
      'subtasks': subtasks,
      'attachments': attachments,
      'taskid': taskcompanydetail!.id,
      'from': "chain"
    });
  }

  void goToViewTask() {
    List<Assignedemployeemodel> convertedEmployees =
        newAssignedEmployees.map((e) {
      return Assignedemployeemodel(
        userId: e.employeeId,
        usersName: e.employeeName,
        usersEmail: e.employeeEmail,
        usersPhone: e.employeePhone.toString(),
      );
    }).toList();

    Get.back(result: {
      'taskcompanydetail': taskcompanydetail,
      "companyemployee": employees,
      'assignedemployee': convertedEmployees,
      'subtasks': subtasks,
      'attachments': attachments,
      'taskid': taskcompanydetail!.id,
      'from': "update"
    });

    Get.find<ViewTaskCompanyManagerController>().onInit();
  }

  @override
  void onInit() {
    from = Get.arguments?['from'];
    attachments = Get.arguments['attachments'];
    subtasks = Get.arguments['subtasks'];
    employees = Get.arguments['companyemployee'] ?? [];
    oldAssignemployeetotask = Get.arguments['assignedemployee'] ?? [];
    taskcompanydetail = Get.arguments['taskcompanydetail'];

    for (var assigned in oldAssignemployeetotask) {
      Employees? employee = employees.firstWhereOrNull(
        (e) => e.employeeId == assigned.userId,
      );
      if (employee != null && !newAssignedEmployees.contains(employee)) {
        newAssignedEmployees.add(employee);
      }
    }
    update();
    super.onInit();
  }
}
