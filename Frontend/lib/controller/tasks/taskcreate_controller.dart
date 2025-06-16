// lib/controller/tasks/taskcreate_controller.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasknotate/controller/home_controller.dart';
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/core/functions/saveimage.dart';
import 'package:tasknotate/core/functions/alarm.dart';
import 'package:tasknotate/data/datasource/local/sqldb.dart';

class TaskcreateController extends GetxController {
  TextEditingController? titlecontroller;
  TextEditingController? descriptioncontroller;

  DateTime? selectedFinish;
  DateTime? selectedAlarm;
  DateTime? selectedStart;
  bool statusprority = false;
  bool statusfinishdate = false;
  bool statusstartdate = false;
  bool statussubtasks = false;
  bool statustimer = false;
  bool statustimeline = false;
  bool statuscategory = false;
  var timelineTiles = <Map<String, dynamic>>[].obs;
  String? prority;
  String? status;
  int? selectedCategoryId;
  List taskData = [];
  SqlDb sqlDb = SqlDb();
  final HomeController homeController = Get.find<HomeController>();

  Map<int, String> images = {};
  int counter = 0;

  final List<String> priorities = ["Low", "Medium", "High"];
  final List<String> statuses = ["Pending", "In Progress", "Completed"];

  final Map<String, String> priorityTranslations = {
    "Low": "146",
    "Medium": "147",
    "High": "148",
  };
  final Map<String, String> statusTranslations = {
    "Pending": "149",
    "In Progress": "150",
    "Completed": "151",
  };

  int? lastTaskIdinreased;
  List<TextEditingController> subtaskControllers = [];

  void addtosubtasktextfield() {
    if (subtaskControllers.length < 5) {
      subtaskControllers.add(TextEditingController());
      update();
    }
  }

  void removeSubtask(int index) {
    if (index >= 0 && index < subtaskControllers.length) {
      subtaskControllers.removeAt(index);
      update();
    }
  }

  String? newsubtasksconverted;
  String? newimagesconverted;

  void fromMapToString(String type) {
    try {
      if (type == "subtasks") {
        final stringKeyedMap =
            subtasks.map((key, value) => MapEntry(key.toString(), value));
        newsubtasksconverted = jsonEncode(stringKeyedMap);
      } else {
        final stringKeyedMap =
            images.map((key, value) => MapEntry(key.toString(), value));
        newimagesconverted = jsonEncode(stringKeyedMap);
      }
    } catch (e) {
      print("Error encoding subtasks/images to JSON: $e");
    }
  }

  Map<int, String> subtasks = <int, String>{};

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

  void addTimelineTile(String title, DateTime time, {int? index}) {
    try {
      if (title.isEmpty) {
        print('Cannot add timeline tile: title is empty');
        return;
      }
      if (index != null) {
        int tileIndex =
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

  void switchstatusbutton(bool value, String type) {
    if (type == "prority") statusprority = value;
    if (type == "finishdate") statusfinishdate = value;
    if (type == "subtasks") statussubtasks = value;
    if (type == "timer") statustimer = value;
    if (type == "timeline") {
      statustimeline = value;
      if (!value) timelineTiles.clear();
    }
    if (type == "startdate") statusstartdate = value;
    if (type == "category") statuscategory = value;
    update();
  }

  Future<void> pickDateTime(BuildContext context, String type) async {
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

          final selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          switch (type) {
            case "startdate":
              selectedStart = selectedDateTime;
              break;
            case "finishdate":
              selectedFinish = selectedDateTime;
              break;
            case "timer":
              selectedAlarm = selectedDateTime;
              break;
          }
          update();
        }
      }
    } catch (e) {
      print('Error picking date/time: $e');
    }
  }

  String getFormattedDateTime(String type) {
    if (type == "finishdate") {
      if (selectedFinish == null) {
        return "key_press_to_select_finish_date".tr;
      } else {
        return "${selectedFinish!.toLocal()}".split(' ')[0] +
            " at " +
            "${selectedFinish!.hour}:${selectedFinish!.minute.toString().padLeft(2, '0')}";
      }
    }
    if (type == "startdate") {
      if (selectedStart == null) {
        return "key_press_to_select_start_date".tr;
      } else {
        return "${selectedStart!.toLocal()}".split(' ')[0] +
            " at " +
            "${selectedStart!.hour}:${selectedStart!.minute.toString().padLeft(2, '0')}";
      }
    } else {
      if (selectedAlarm == null) {
        return "key_press_to_select_date_and_time".tr;
      } else {
        return "${selectedAlarm!.toLocal()}".split(' ')[0] +
            " at " +
            "${selectedAlarm!.hour}:${selectedAlarm!.minute.toString().padLeft(2, '0')}";
      }
    }
  }

  Future<void> uploadTask() async {
    if (titlecontroller!.text.isEmpty) {
      return Get.defaultDialog(middleText: "key_add_title_to_save_task".tr);
    }

    saveAllSubtasks();
    fromMapToString("subtasks");
    fromMapToString("images");

    print("Timeline Tiles before saving: $timelineTiles");
    String timelineJson = statustimeline && timelineTiles.isNotEmpty
        ? jsonEncode(timelineTiles)
        : "Not Set";

    try {
      int taskResponse = await sqlDb.insertData(
        "INSERT INTO tasks (title, content, date, estimatetime, starttime, status, priority, subtask, reminder, images, timeline, categoryId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        [
          titlecontroller!.text,
          descriptioncontroller!.text,
          DateTime.now().toIso8601String(),
          selectedFinish?.toIso8601String() ?? "Not Set",
          selectedStart?.toIso8601String() ?? "Not Set",
          status ?? "Pending",
          statusprority ? prority : "Not Set",
          statussubtasks ? newsubtasksconverted : "Not Set",
          statustimer && selectedAlarm != null
              ? selectedAlarm!.toIso8601String()
              : "Not Set",
          newimagesconverted != null && newimagesconverted!.isNotEmpty
              ? newimagesconverted
              : "Not Set",
          timelineJson,
          selectedCategoryId,
        ],
      );

      if (taskResponse > 0) {
        await getLastTaskId();
        if (statustimer && selectedAlarm != null) {
          await setAlarm(
              selectedAlarm, lastTaskIdinreased, titlecontroller!.text);
        }
        Get.offAllNamed(AppRoute.home);
        print("Task saved successfully with timeline: $timelineTiles");
        List<Map> tasks = await sqlDb.readData(
            "SELECT timeline FROM tasks WHERE id = ?", [lastTaskIdinreased]);
        print(
            "Saved timeline in DB: ${tasks.isNotEmpty ? tasks.first['timeline'] : 'No task found'}");
      } else {
        print("Task save failed!");
      }
    } catch (e) {
      print("Error inserting task: $e");
      Get.snackbar(
        "key_error".tr,
        "key_failed_to_save_task".tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> getLastTaskId() async {
    try {
      List<Map> response =
          await sqlDb.readData("SELECT MAX(id) AS lastId FROM tasks");
      if (response.isNotEmpty && response.first['lastId'] != null) {
        lastTaskIdinreased = response.first['lastId'];
      } else {
        lastTaskIdinreased = 1;
      }
      update();
    } catch (e) {
      print("Error fetching last task ID: $e");
      lastTaskIdinreased = null;
    }
  }

  void addValue(String value) {
    images[counter] = value;
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
      if (images.isNotEmpty) {
        fromMapToString("images");
      } else {
        print("No images to encode.");
      }
      print("==== the images is $newimagesconverted");
    }
  }

  Future<void> deleteImage(String imagePath) async {
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
        print("Image deleted successfully: $imagePath");
        images.removeWhere((key, value) => value == imagePath);
        update();
      } else {
        print("Image not found at: $imagePath");
      }
    } catch (e) {
      print("Error deleting image: $e");
    }
  }

  Future<void> deleteAllImages() async {
    try {
      for (String imagePath in images.values) {
        final file = File(imagePath);
        if (await file.exists()) {
          await file.delete();
          print("Image deleted successfully: $imagePath");
        } else {
          print("Image not found at: $imagePath");
        }
      }
      images.clear();
      update();
    } catch (e) {
      print("Error deleting images: $e");
    }
  }

  @override
  void onInit() {
    titlecontroller = TextEditingController();
    descriptioncontroller = TextEditingController();
    prority = priorities.first;
    status = statuses.first;
    homeController.getTaskCategories();
    super.onInit();
  }

  @override
  void onClose() {
    titlecontroller?.dispose();
    descriptioncontroller?.dispose();
    for (var controller in subtaskControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
