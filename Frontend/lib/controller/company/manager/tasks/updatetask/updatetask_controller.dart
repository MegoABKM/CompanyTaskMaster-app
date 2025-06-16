import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/core/functions/handlingdatacontroller.dart';
import 'package:tasknotate/data/datasource/remote/company/taskcompany_data.dart';
import 'package:tasknotate/data/model/company/tasks/assignedemployeemodel.dart';
import 'package:tasknotate/data/model/company/tasks/attachmentmodel.dart';
import 'package:tasknotate/data/model/company/companymodel.dart';
import 'package:tasknotate/data/model/company/tasks/subtasksmode.dart';
import 'package:tasknotate/data/model/company/tasks/taskcompanymodel.dart';
import 'package:tasknotate/view/screen/company/manager/tasks/updatetask/assignemployeeupdate.dart';

class UpdatetaskCompanyController extends GetxController {
  List<Employees>? companyemployee = [];
  List<AttachmentModel> attachments = [];
  String? from;
  List<SubtaskModel> subtasks = [];
  List<Assignedemployeemodel> assignemployeetotask = [];
  TaskCompanyModel? taskcompanydetail;
  TextEditingController? titlecontroller;
  TextEditingController? disccontroller;
  String dueDate = '';
  String? priority;
  String? status;
  List<String> priorityOptions = ["Not set", "High", "Medium", "Low"];
  List<String> statusOptions = ["In Progress", "Completed", "Pending"];
  Taskcompanydata updatetaskcompanydata = Taskcompanydata(Get.find());
  StatusRequest? statusRequest;

  void updatePriority(String newPriority) {
    priority = newPriority;
    update();
  }

  void updateDueDate(String newDueDate) {
    dueDate = newDueDate;
    update();
  }

  void updateStatus(String newStatus) {
    status = newStatus;
    update();
  }

  Future<void> updateTask() async {
    // Made async for proper handling
    statusRequest = StatusRequest.loading;
    update();

    try {
      print("==========${taskcompanydetail!.companyId}");
      var response = await updatetaskcompanydata.updateData(
        taskid: taskcompanydetail!.id,
        tasktitle: titlecontroller!.text,
        taskdescription: disccontroller!.text,
        taskduedate: dueDate,
        taskpriority: priority,
        taskstatus: status,
        tasklastupdate: DateTime.now().toIso8601String(),
        companyid: taskcompanydetail!.companyId,
      );

      statusRequest = handlingData(response);
      update();

      if (statusRequest == StatusRequest.success) {
        if (from == "chain") {
          Get.offAll(const AssignemployeeUpdateToTask(), arguments: {
            "assignedemployee": assignemployeetotask,
            "companyemployee": companyemployee,
            "taskcompanydetail": taskcompanydetail,
            "subtasks": subtasks,
            "attachments": attachments,
            "from": from
          });
        } else {
          Get.back();
        }
      } else {
        Get.defaultDialog(middleText: "Failed to update task");
      }
    } catch (e) {
      statusRequest = StatusRequest.failure;
      update();
      Get.defaultDialog(middleText: "An error occurred: $e");
    }
  }

  @override
  void onInit() {
    from = Get.arguments['from'];
    attachments = Get.arguments['attachments'];
    subtasks = Get.arguments['subtasks'];
    companyemployee = Get.arguments['companyemployee'];
    assignemployeetotask = Get.arguments['assignedemployee'];
    taskcompanydetail = Get.arguments['taskcompanydetail'];
    dueDate = taskcompanydetail!.dueDate!;
    priority = taskcompanydetail!.priority!;
    status = taskcompanydetail!.status!;
    titlecontroller = TextEditingController(text: taskcompanydetail!.title);
    disccontroller =
        TextEditingController(text: taskcompanydetail!.description);
    super.onInit();
  }

  @override
  void onClose() {
    titlecontroller?.dispose();
    disccontroller?.dispose();
    super.onClose();
  }
}
