import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/data/datasource/remote/linkapi.dart';
import 'package:companymanagment/view/screen/company/manager/tasks/createtask/addfiletotask.dart';

class SubtaskController extends GetxController {
  String? taskId;
  final subtasks = <Subtask>[].obs;
  StatusRequest? statusRequest;

  void addSubtask() {
    subtasks.add(Subtask());
    print("Subtask added. Current count: ${subtasks.length}");
  }

  void removeSubtask(int index) {
    subtasks.removeAt(index);
    print("Subtask removed at index $index. Current count: ${subtasks.length}");
  }

  Future<void> submitSubtasks() async {
    if (subtasks.isEmpty) {
      skipToAddFile();
      return;
    }

    print("Preparing to submit subtasks for Task ID: $taskId");

    final List<Map<String, String>> subtaskData = subtasks.map((subtask) {
      return {
        "title": subtask.titleController.text.trim(),
        "description": subtask.descriptionController.text.trim(),
      };
    }).toList();

    print("Subtask Data: $subtaskData");

    try {
      statusRequest = StatusRequest.loading;
      update();

      final response = await http.post(
        Uri.parse(AppLink.creatsubtask),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "taskid": taskId,
          "subtasks": subtaskData,
        }),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200 &&
          jsonDecode(response.body)['status'] == 'success') {
        Get.snackbar(
          "Success",
          "Subtasks added successfully",
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.off(AddFilePage(), arguments: {"taskid": taskId});
        statusRequest = StatusRequest.success;
        update();
      } else {
        Get.snackbar(
          "Error",
          jsonDecode(response.body)['message'] ?? "Failed to add subtasks",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "An error occurred: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
      print("Exception occurred: $e");
    }
    statusRequest = null;
    update();
  }

  void skipToAddFile() {
    Get.off(AddFilePage(), arguments: {"taskid": taskId});
    Get.snackbar(
      "Info",
      "No subtasks added, proceeding to file upload.",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onInit() {
    taskId = Get.arguments['taskid'];
    super.onInit();
  }
}

class Subtask {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
}
