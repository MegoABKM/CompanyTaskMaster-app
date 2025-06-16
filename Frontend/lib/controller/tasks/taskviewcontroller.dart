import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/core/functions/alarm.dart';
import 'package:tasknotate/data/datasource/local/sqldb.dart';
import 'package:tasknotate/data/model/usertasksmodel.dart';
import 'package:tasknotate/view/screen/tasks/update_task.dart';

class Taskviewcontroller extends GetxController {
  UserTasksModel? task;
  String? index;
  DateTime? selectedAlarm;
  Map<String, dynamic>? decodedsubtask;
  Map<String, String> decodedImages = {};
  List<Map<String, dynamic>> decodedTimeline = [];
  String? categoryName;
  SqlDb sqlDb = SqlDb();

  void decodethemap() {
    if (task?.subtask != null &&
        task?.subtask != "Not Set" &&
        task!.subtask!.isNotEmpty) {
      try {
        decodedsubtask = jsonDecode(task!.subtask!);
        print("The decoded subtask is $decodedsubtask");
      } catch (e) {
        print("Error decoding subtasks: $e");
        decodedsubtask = null;
      }
    }
  }

  void decodeImages() {
    if (task?.images != null &&
        task!.images!.isNotEmpty &&
        task?.images != "Not Set") {
      try {
        decodedImages = Map<String, String>.from(jsonDecode(task!.images!));
        print("Decoded images: $decodedImages");
      } catch (e) {
        print("Error decoding images: $e");
      }
    }
  }

  void decodeTimeline() {
    if (task?.timeline != null &&
        task!.timeline!.isNotEmpty &&
        task?.timeline != "Not Set") {
      try {
        decodedTimeline =
            List<Map<String, dynamic>>.from(jsonDecode(task!.timeline!));
        decodedTimeline.sort((a, b) => a['index'].compareTo(b['index']));
        print("Decoded timeline: $decodedTimeline");
      } catch (e) {
        print("Error decoding timeline: $e");
        decodedTimeline = [];
      }
    }
  }

  Future<String?> fromIdToName(String? categoryid) async {
    try {
      if (categoryid == null || categoryid.isEmpty || categoryid == "Home") {
        return "Home";
      }
      int? parsedCategoryId = int.tryParse(categoryid);
      if (parsedCategoryId == null) {
        print("Invalid category ID: $categoryid");
        return "Home";
      }
      List<Map<String, dynamic>> response = await sqlDb.readData(
        "SELECT categoryName FROM categoriestasks WHERE id = ?",
        [parsedCategoryId],
      );
      if (response.isNotEmpty && response[0]['categoryName'] != null) {
        return response[0]['categoryName'] as String;
      } else {
        print("No category found for ID: $parsedCategoryId");
        return "Home";
      }
    } catch (e) {
      print("Error fetching category name: $e");
      return "Home";
    }
  }

  Future<void> updateStatus(
      String status, String id, String statustarget) async {
    try {
      int response = await sqlDb.updateData(
          "UPDATE tasks SET status = ? WHERE id = ?", [statustarget, id]);
      if (response > 0) {
        task = UserTasksModel(
          id: task?.id,
          title: task?.title,
          content: task?.content,
          date: task?.date,
          estimatetime: task?.estimatetime,
          starttime: task?.starttime,
          reminder: task?.reminder,
          status: statustarget,
          priority: task?.priority,
          subtask: task?.subtask,
          checked: task?.checked,
          images: task?.images,
          timeline: task?.timeline,
          category: task?.category,
        );
        print("Status updated to $statustarget for task ${task?.title}");
        update();
      } else {
        print("Failed to update status");
      }
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  Future<void> pickDateTime(BuildContext context) async {
    try {
      final DateTime now = DateTime.now();
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: now,
        lastDate: DateTime(2100),
      );
      if (pickedDate != null) {
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          if (pickedDate
              .isAtSameMomentAs(DateTime(now.year, now.month, now.day))) {
            if (pickedTime.hour < now.hour ||
                (pickedTime.hour == now.hour &&
                    pickedTime.minute < now.minute)) {
              Get.snackbar(
                "key_invalid_time".tr,
                "key_cannot_select_past_time".tr,
                snackPosition: SnackPosition.BOTTOM,
              );
              return;
            }
          }
          selectedAlarm = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          update();
          await setAlarm(selectedAlarm, int.parse(task!.id!), task!.title!);
          await updateReminder();
          await Get.offAllNamed(AppRoute.home);
        }
      }
    } catch (e) {
      print('Error picking date/time: $e');
    }
  }

  Future<void> updateReminder() async {
    try {
      if (selectedAlarm != null) {
        int response = await sqlDb.updateData(
            "UPDATE tasks SET reminder = ? WHERE id = ?",
            [selectedAlarm!.toIso8601String(), task!.id]);
        if (response > 0) {
          task = UserTasksModel(
            id: task?.id,
            title: task?.title,
            content: task?.content,
            date: task?.date,
            estimatetime: task?.estimatetime,
            starttime: task?.starttime,
            reminder: selectedAlarm!.toIso8601String(),
            status: task?.status,
            priority: task?.priority,
            subtask: task?.subtask,
            checked: task?.checked,
            images: task?.images,
            timeline: task?.timeline,
            category: task?.category,
          );
          print("Reminder updated to ${selectedAlarm!.toIso8601String()}");
          update();
        } else {
          print("Failed to update reminder");
        }
      }
    } catch (e) {
      print('Error updating reminder: $e');
    }
  }

  @override
  Future<void> onInit() async {
    try {
      final args = Get.arguments;
      print("Arguments received in Taskviewcontroller: $args");
      if (args == null || args['task'] == null) {
        print('No task provided in arguments');
        Get.back();
        return;
      }

      task = args['task'] as UserTasksModel?;
      index = args['taskindex']?.toString();
      print("Task loaded: id=${task?.id}, title=${task?.title}");

      if (task == null) {
        print('Task is null');
        Get.back();
        return;
      }

      print("Task starttime: ${task?.starttime}");
      if (task?.subtask != null &&
          task?.subtask != "Not Set" &&
          task!.subtask!.isNotEmpty) {
        decodethemap();
      }
      if (task?.images != null &&
          task!.images!.isNotEmpty &&
          task?.images != "Not Set") {
        decodeImages();
      }
      if (task?.timeline != null &&
          task!.timeline!.isNotEmpty &&
          task?.timeline != "Not Set") {
        decodeTimeline();
      }
      categoryName = await fromIdToName(task?.category);
      print("Category name: $categoryName");

      update();
    } catch (e, stackTrace) {
      print('Error in Taskviewcontroller.onInit: $e');
      print('Stack trace: $stackTrace');
      Get.back();
    }
    super.onInit();
  }

  void goToUpdateTask() {
    try {
      Get.to(
        const UpdateTask(),
        transition: Transition.noTransition,
        arguments: {
          "task": task,
          "taskindex": index,
          "taskdecodedimages": decodedImages,
          "taskdecodedtimeline": decodedTimeline,
          "categoryname": categoryName,
        },
      );
    } catch (e) {
      print('Error navigating to UpdateTask: $e');
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
