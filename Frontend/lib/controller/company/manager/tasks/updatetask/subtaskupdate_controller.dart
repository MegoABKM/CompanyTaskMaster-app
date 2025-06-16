import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/controller/company/manager/tasks/viewtask_controller.dart';
import 'package:tasknotate/data/model/company/tasks/assignedemployeemodel.dart';
import 'package:tasknotate/data/model/company/tasks/attachmentmodel.dart';
import 'package:tasknotate/data/model/company/companymodel.dart';
import 'package:tasknotate/data/model/company/tasks/subtasksmode.dart';
import 'package:tasknotate/data/model/company/tasks/taskcompanymodel.dart';
import 'package:tasknotate/data/datasource/remote/linkapi.dart';
import 'package:tasknotate/view/screen/company/manager/tasks/updatetask/updatefiletotask.dart';

class SubtaskUpdateController extends GetxController {
  String? taskId;
  List<SubtaskModel> subtasks = [];
  List<SubtaskModel> oldsubtask = [];
  List<AttachmentModel> attachments = [];
  String? from;
  TaskCompanyModel? taskcompanydetail;
  List<Assignedemployeemodel> assignedemployee = [];
  List<Employees>? companyemployee = [];
  StatusRequest? statusRequest;

  List<TextEditingController> titleControllers = [];
  List<TextEditingController> descriptionControllers = [];

  @override
  void onInit() {
    from = Get.arguments?['from'];
    attachments = Get.arguments['attachments'] ?? [];
    subtasks = Get.arguments['subtasks'] ?? [];
    companyemployee = Get.arguments['companyemployee'] ?? [];
    taskcompanydetail = Get.arguments['taskcompanydetail'];
    taskId = Get.arguments['taskid'];
    oldsubtask = List.from(subtasks);

    final subtasksData = Get.arguments['subtasks'] as List<dynamic>? ?? [];
    subtasks = subtasksData.map((data) {
      if (data is SubtaskModel) {
        return data;
      } else if (data is Map<String, dynamic>) {
        return SubtaskModel.fromJson(data);
      } else {
        throw Exception("Invalid subtask data type: ${data.runtimeType}");
      }
    }).toList();

    for (var subtask in subtasks) {
      titleControllers.add(TextEditingController(text: subtask.title));
      descriptionControllers
          .add(TextEditingController(text: subtask.description));
    }

    print(
        "onInit - from: $from, taskId: $taskId, subtasks count: ${subtasks.length}");
    super.onInit();
  }

  void addSubtask() {
    final newSubtask = SubtaskModel(
      id: DateTime.now().millisecondsSinceEpoch,
      title: '',
      description: '',
    );
    subtasks.add(newSubtask);
    titleControllers.add(TextEditingController(text: ''));
    descriptionControllers.add(TextEditingController(text: ''));
    update();
    print("Subtask added. Current count: ${subtasks.length}");
  }

  void removeSubtask(int index) {
    subtasks.removeAt(index);
    titleControllers[index].dispose();
    descriptionControllers[index].dispose();
    titleControllers.removeAt(index);
    descriptionControllers.removeAt(index);
    update();
    print("Subtask removed at index $index. Current count: ${subtasks.length}");
  }

  void updateSubtaskTitle(int index, String value) {
    subtasks[index].title = value;
    titleControllers[index].text = value;
    update();
    print("Updated title of subtask at index $index: $value");
  }

  void updateSubtaskDescription(int index, String value) {
    subtasks[index].description = value;
    descriptionControllers[index].text = value;
    update();
    print("Updated description of subtask at index $index: $value");
  }

  Future<void> submitSubtasks() async {
    bool hasChanges = _haveSubtasksChanged();
    print("Submitting subtasks - hasChanges: $hasChanges, from: $from");

    if (hasChanges) {
      statusRequest = StatusRequest.loading;
      update();

      final List<Map<String, dynamic>> subtaskData =
          subtasks.map((subtask) => subtask.toJson()).toList();

      try {
        final response = await http.post(
          Uri.parse(AppLink.updatesubtask),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "taskid": taskId,
            "subtasks": subtaskData,
          }),
        );

        print("Response Status: ${response.statusCode}");
        print("Response Body: ${response.body}");

        if (response.statusCode == 200 &&
            response.body.contains('"status":"success"')) {
          statusRequest = StatusRequest.success;
          update();
          Get.snackbar("Success", "Subtasks updated successfully",
              snackPosition: SnackPosition.BOTTOM);
          print("Subtasks updated successfully, deciding navigation...");

          if (from == "chain" && taskcompanydetail != null) {
            print("Navigating to UpdateFileToTask");
            goToFile();
          } else {
            print("Navigating to View Task");
            goToViewTask();
          }
        } else {
          statusRequest = StatusRequest.failure;
          update();
          Get.snackbar("Error", "Failed to update subtasks: ${response.body}",
              snackPosition: SnackPosition.BOTTOM);
          print("Failed to update subtasks: ${response.body}");
        }
      } catch (e) {
        statusRequest = StatusRequest.failure;
        update();
        Get.snackbar("Error", "An error occurred: $e",
            snackPosition: SnackPosition.BOTTOM);
        print("Exception occurred: $e");
      }
    } else {
      print("No changes detected, proceeding with navigation");
      if (from == "chain" && taskcompanydetail != null) {
        goToFile();
      } else {
        goToViewTask();
      }
    }
  }

  bool _haveSubtasksChanged() {
    if (oldsubtask.length != subtasks.length) return true;
    for (int i = 0; i < oldsubtask.length; i++) {
      if (oldsubtask[i].title != subtasks[i].title ||
          oldsubtask[i].description != subtasks[i].description) {
        return true;
      }
    }
    return false;
  }

  void goToFile() {
    print(
        "Navigating to UpdateFileToTask with taskId: ${taskcompanydetail?.id}, subtasks: ${subtasks.length}");
    Get.off(() => UpdateFileToTask(), arguments: {
      'taskcompanydetail': taskcompanydetail,
      'companyemployee': companyemployee,
      'assignedemployee': assignedemployee,
      'subtasks': subtasks,
      'attachments': attachments,
      'taskid': taskcompanydetail?.id,
      'from': "update"
    });
  }

  void goToViewTask() {
    print("Navigating to View Task with taskId: $taskId");
    try {
      // Ensure ViewtaskController is registered and refreshed
      if (!Get.isRegistered<ViewTaskCompanyManagerController>()) {
        print("ViewtaskController not found, registering...");
        Get.put(ViewTaskCompanyManagerController());
      }
      Get.find<ViewTaskCompanyManagerController>().onInit();

      // Explicitly navigate to /ViewTaskCompany
      print("Attempting navigation to /ViewTaskCompany");
      Get.offNamed('/ViewTaskCompany', arguments: {
        'taskid': taskId,
        'subtasks': subtasks,
        'attachments': attachments,
        'taskcompanydetail': taskcompanydetail,
        'companyemployee': companyemployee,
        'assignedemployee': assignedemployee,
      });
      print("Navigation to /ViewTaskCompany completed");
    } catch (e) {
      print("Navigation error: $e");
      Get.snackbar("Error", "Failed to navigate to View Task: $e",
          snackPosition: SnackPosition.BOTTOM);

      // Fallback: Go back if named route fails
      print("Falling back to Get.back()");
      Get.back();
    }
  }

  @override
  void onClose() {
    for (var controller in titleControllers) {
      controller.dispose();
    }
    for (var controller in descriptionControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
