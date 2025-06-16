// lib/controller/tasks/taskupdate_controller.dart
import 'dart:convert';
import 'dart:io';
import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasknotate/controller/home_controller.dart';
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/core/functions/alarm.dart';
import 'package:tasknotate/core/functions/saveimage.dart';
import 'package:tasknotate/data/datasource/local/sqldb.dart';
import 'package:tasknotate/data/model/categorymodel.dart';
import 'package:tasknotate/data/model/usertasksmodel.dart';

class TaskUpdatecontroller extends GetxController {
  UserTasksModel? task;
  String? index;
  DateTime? selectedAlarm;
  DateTime? selectedDate;
  DateTime? selectedStartDate;
  Map<String, dynamic>? decodedsubtask;
  TextEditingController? contentcontroller;
  TextEditingController? titlecontroller;
  final List<String> statuses = ["Pending", "In Progress", "Completed"];
  final List<String> priorities = ["Not Set", "Low", "Medium", "High"];
  bool statusprority = false;
  bool statusdateandtime = false;
  bool statusstartDate = false;
  bool statussubtasks = false;
  bool statusreminder = false;
  bool statustimeline = false;
  var timelineTiles = <Map<String, dynamic>>[].obs;
  Map<String, String> decodedImages = {};
  SqlDb sqlDb = SqlDb();
  String? newsubtasksconverted;
  String? newimagesconverted;
  List<TextEditingController> subtaskControllers = [];
  Map<int, String> subtasks = <int, String>{};
  int? selectedCategoryId;
  List<CategoryModel> categories = [];
  HomeController homeController = Get.find<HomeController>();

  String getTranslatedPriority(String priority) {
    switch (priority) {
      case "Not Set":
        return "166".tr;
      case "Low":
        return "160".tr;
      case "Medium":
        return "161".tr;
      case "High":
        return "162".tr;
      default:
        return priority;
    }
  }

  String getTranslatedStatus(String status) {
    switch (status) {
      case "Pending":
        return "163".tr;
      case "In Progress":
        return "164".tr;
      case "Completed":
        return "165".tr;
      default:
        return status;
    }
  }

  void decodeTimeline() {
    if (task?.timeline != null &&
        task!.timeline!.isNotEmpty &&
        task?.timeline != "Not Set") {
      try {
        timelineTiles.value =
            List<Map<String, dynamic>>.from(jsonDecode(task!.timeline!));
        timelineTiles.sort((a, b) => a['index'].compareTo(b['index']));
        statustimeline = true;
        print("Decoded timelineTiles: $timelineTiles");
      } catch (e) {
        print("Error decoding timeline: $e");
        timelineTiles.value = [];
        statustimeline = false;
      }
    } else {
      timelineTiles.value = [];
      statustimeline = false;
    }
  }

  void toggleTimeline() {
    statustimeline = !statustimeline;
    if (!statustimeline) {
      timelineTiles.clear();
    }
    update();
  }

  void addTimelineTile(String title, DateTime time, {int? index}) {
    try {
      if (title.isEmpty) {
        print('Cannot add timeline tile: title is empty');
        return;
      }
      if (index != null) {
        final tileIndex =
            timelineTiles.indexWhere((tile) => tile['index'] == index);
        if (tileIndex != -1) {
          timelineTiles[tileIndex] = {
            'index': index,
            'title': title,
            'time': time.toIso8601String(),
          };
          print('Updated timeline tile: $title at index $index');
        } else {
          print('Tile index $index not found for update');
        }
      } else {
        int newIndex = timelineTiles.isEmpty
            ? 1
            : timelineTiles
                    .map((tile) => tile['index'] as int)
                    .reduce((a, b) => a > b ? a : b) +
                1;
        timelineTiles.add({
          'index': newIndex,
          'title': title,
          'time': time.toIso8601String(),
        });
        print('Added new timeline tile: $title with index $newIndex');
      }
      timelineTiles.sort((a, b) => a['index'].compareTo(b['index']));
      timelineTiles.refresh();
      update();
    } catch (e) {
      print('Error adding timeline tile: $e');
    }
  }

  void deleteTimelineTile(int index) {
    try {
      timelineTiles.removeWhere((tile) => tile['index'] == index);
      print('Deleted timeline tile with index $index');
      timelineTiles.sort((a, b) => a['index'].compareTo(b['index']));
      timelineTiles.refresh();
      update();
    } catch (e) {
      print('Error deleting timeline tile: $e');
    }
  }

  void addtosubtasktextfield() {
    if (subtaskControllers.length < 5) {
      subtaskControllers.add(TextEditingController());
      update();
      print("added a row with textfield ${subtaskControllers.length}");
    }
  }

  void removeSubtask(int index) {
    if (index >= 0 && index < subtaskControllers.length) {
      subtaskControllers.removeAt(index);
      update();
    }
  }

  void fromMapToString(String type) {
    try {
      if (type == "subtasks") {
        final stringKeyedMap =
            subtasks.map((key, value) => MapEntry(key.toString(), value));
        newsubtasksconverted = jsonEncode(stringKeyedMap);
      } else {
        final stringKeyedMap =
            decodedImages.map((key, value) => MapEntry(key.toString(), value));
        newimagesconverted = jsonEncode(stringKeyedMap);
      }
    } catch (e) {
      print("Error encoding subtasks/images to JSON: $e");
    }
  }

  Future<void> deactivateAlarm() async {
    await Alarm.stop(int.parse(task!.id!));
    print('Alarm with ID ${task!.id} deactivated.');
  }

  void saveAllSubtasks() {
    subtasks.clear();
    for (int i = 0; i < subtaskControllers.length; i++) {
      final text = subtaskControllers[i].text;
      if (text.isNotEmpty) {
        subtasks[i] = text;
      }
    }
    if (subtasks.isEmpty) {
      print("No subtasks were saved as all fields are empty.");
    } else {
      print("All Subtasks Saved: $subtasks");
    }
    update();
  }

  Future<void> pickDateTime(BuildContext context, String type) async {
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
              (pickedTime.hour == now.hour && pickedTime.minute < now.minute)) {
            Get.snackbar(
              "key_invalid_time".tr,
              "key_cannot_select_past_time".tr,
              snackPosition: SnackPosition.BOTTOM,
            );
            return;
          }
        }

        final selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        switch (type) {
          case "alarm":
            selectedAlarm = selectedDateTime;
            break;
          case "startdate":
            selectedStartDate = selectedDateTime;
            break;
          case "dateandtime":
            selectedDate = selectedDateTime;
            break;
        }
        update();
      }
    }
  }

  void switchstatusbutton(bool value, String type) {
    print("Switch toggled: $type = $value");
    switch (type) {
      case "priority":
        statusprority = value;
        if (!value) {
          task = UserTasksModel(
            id: task?.id,
            title: task?.title,
            content: task?.content,
            date: task?.date,
            estimatetime: task?.estimatetime,
            starttime: task?.starttime,
            reminder: task?.reminder,
            status: task?.status,
            priority: "Not Set",
            subtask: task?.subtask,
            checked: task?.checked,
            images: task?.images,
            timeline: task?.timeline,
            category: task?.category,
          );
        }
        break;
      case "dateandtime":
        statusdateandtime = value;
        if (!value) selectedDate = null;
        break;
      case "startdate":
        statusstartDate = value;
        if (!value) selectedStartDate = null;
        break;
      case "subtasks":
        statussubtasks = value;
        if (!value) {
          subtaskControllers.clear();
          subtasks.clear();
        }
        break;
      case "reminder":
        statusreminder = value;
        if (!value) selectedAlarm = null;
        break;
      case "timeline":
        statustimeline = value;
        if (!value) timelineTiles.clear();
        break;
    }
    update();
  }

  void assigndateifnotset() {
    try {
      if (task?.estimatetime != null && task?.estimatetime != "Not Set") {
        selectedDate = DateTime.parse(task!.estimatetime!);
        statusdateandtime = true;
        print("Parsed finishDate: $selectedDate");
      }

      if (task?.reminder != null && task?.reminder != "Not Set") {
        selectedAlarm = DateTime.parse(task!.reminder!);
        statusreminder = true;
        print("Parsed reminder: $selectedAlarm");
      }

      if (task?.starttime != null && task?.starttime != "Not Set") {
        selectedStartDate = DateTime.parse(task!.starttime!);
        statusstartDate = true;
        print("Parsed startDate: $selectedStartDate");
      }
    } catch (e) {
      print("Error parsing dates: $e");
    }
    update();
  }

  Future<void> updateReminder() async {
    if (selectedAlarm != null) {
      int response = await sqlDb.updateData(
          "UPDATE tasks SET reminder = ? WHERE id = ? ",
          [selectedAlarm?.toIso8601String(), task!.id]);
      if (response > 0) {
        print("=======================success update");
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
      } else {
        print("Failed to update");
      }
    }
  }

  Future<void> updatetaskafteredit() async {
    if (statusreminder && selectedAlarm == null) {
      return Get.defaultDialog(
          title: "key_no_reminder_date".tr,
          content: Text("key_add_reminder_date".tr),
          confirm: TextButton(onPressed: Get.back, child: Text("key_ok".tr)));
    }
    if (statusdateandtime && selectedDate == null) {
      return Get.defaultDialog(
          title: "key_no_finish_date".tr,
          content: Text("key_add_finish_date".tr),
          confirm: TextButton(onPressed: Get.back, child: Text("key_ok".tr)));
    }

    saveAllSubtasks();
    if (subtasks.isNotEmpty) {
      fromMapToString("subtasks");
    } else {
      newsubtasksconverted = "Not Set";
      statussubtasks = false;
    }
    if (decodedImages.isNotEmpty) {
      fromMapToString("images");
    } else {
      newimagesconverted = "Not Set";
    }

    String timelineJson = "Not Set";
    if (statustimeline && timelineTiles.isNotEmpty) {
      timelineJson = jsonEncode(timelineTiles);
    }

    int response = await sqlDb.updateData(
        "UPDATE tasks SET title = ?, content = ?, estimatetime = ?, starttime = ?, reminder = ?, status = ?, priority = ?, subtask = ?, images = ?, timeline = ?, categoryId = ? WHERE id = ?",
        [
          titlecontroller!.text,
          contentcontroller!.text.isNotEmpty ? contentcontroller!.text : "",
          statusdateandtime ? selectedDate!.toIso8601String() : "Not Set",
          statusstartDate ? selectedStartDate!.toIso8601String() : "Not Set",
          statusreminder ? selectedAlarm!.toIso8601String() : "Not Set",
          task?.status,
          statusprority ? task?.priority : "Not Set",
          statussubtasks && subtasks.isNotEmpty
              ? newsubtasksconverted
              : "Not Set",
          decodedImages.isNotEmpty ? newimagesconverted : "Not Set",
          timelineJson,
          selectedCategoryId,
          task?.id,
        ]);
    if (response > 0) {
      if (!statusreminder) deactivateAlarm();
      if (statusreminder && selectedAlarm != null)
        setAlarm(selectedAlarm, int.parse(task!.id!), task!.title!);
      Get.offAllNamed(AppRoute.home);
      print("Success Update $response");
    } else {
      print("Failed to Update $response");
    }
  }

  Future<void> deleteImage(String imagePath) async {
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
        print("Image deleted successfully: $imagePath");
        decodedImages.removeWhere((key, value) => value == imagePath);
        update();
        if (decodedImages.isNotEmpty) {
          fromMapToString("images");
        }
        await sqlDb.updateData("UPDATE tasks SET images = ? WHERE id = ? ", [
          decodedImages.isNotEmpty ? newimagesconverted : "Not Set",
          task!.id
        ]);
      } else {
        print("Image not found at: $imagePath");
      }
    } catch (e) {
      print("Error deleting image: $e");
    }
  }

  void addValue(String value) {
    int counter = decodedImages.length;
    decodedImages[counter.toString()] = value;
    counter++;
    update();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      String savedPath = await saveImageToFileSystem(pickedFile);
      addValue(savedPath);
    }
  }

  Future<void> fetchCategories() async {
    await homeController.getTaskCategories();
    categories = homeController.taskCategories;
    update();
  }

  @override
  void onInit() {
    task = Get.arguments['task'] as UserTasksModel?;
    index = Get.arguments['taskindex'];
    decodedImages = Get.arguments['taskdecodedimages'] ?? {};
    selectedCategoryId =
        int.tryParse(task!.category!); // Initialize with task's categoryId
    contentcontroller = TextEditingController(text: task?.content);
    titlecontroller = TextEditingController(text: task?.title);

    assigndateifnotset();
    statusprority = task?.priority != null && task?.priority != "Not Set";
    statusdateandtime =
        task?.estimatetime != null && task?.estimatetime != "Not Set";
    statusreminder = task?.reminder != null && task?.reminder != "Not Set";
    statussubtasks = task?.subtask != null && task?.subtask != "Not Set";

    if (statussubtasks && task?.subtask != "Not Set") {
      decodedsubtask = jsonDecode(task!.subtask!);
      decodedsubtask!.forEach((key, value) {
        int index = int.tryParse(key) ?? -1;
        if (index >= 0) {
          subtaskControllers.add(TextEditingController(text: value));
        }
      });
    }

    decodeTimeline();
    fetchCategories();

    update();
    super.onInit();
  }
}
