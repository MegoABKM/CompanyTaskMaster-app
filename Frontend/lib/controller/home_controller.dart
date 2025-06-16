import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/core/functions/alarm.dart';
import 'package:tasknotate/data/model/categorymodel.dart';
import 'package:tasknotate/data/model/usernotesmodel.dart';
import 'package:tasknotate/data/model/usertasksmodel.dart';
import 'package:tasknotate/main.dart';
import 'package:tasknotate/data/datasource/local/sqldb.dart';

class HomeController extends GetxController {
  StatusRequest? statusRequest;
  List<UserNotesModel> notedata = [];
  List<UserTasksModel> taskdata = [];
  List<CategoryModel> taskCategories = [];
  List<CategoryModel> noteCategories = [];
  SqlDb sqlDb = SqlDb();
  String? userid;
  String? selectedSortCriterion;
  int currentIndex = 0;
  bool isTimelineView = false;
  bool isLoadingTasks = true;
  bool isLoadingNotes = true;
  Rx<int?> selectedTaskCategoryId = Rx<int?>(null);
  Rx<int?> selectedNoteCategoryId = Rx<int?>(null);
  final AudioPlayer _audioPlayer = AudioPlayer();

  List<BottomNavigationBarItem> itemsOfScreen = [
    BottomNavigationBarItem(
        icon: Icon(Icons.timer_outlined), label: "key_tasks".tr),
    BottomNavigationBarItem(icon: Icon(Icons.group), label: "key_company".tr),
    BottomNavigationBarItem(
        icon: Icon(Icons.note_alt),
        label: "key_notes".tr,
        activeIcon: Icon(Icons.edit)),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: "key_settings".tr),
  ];

  int get nonCompletedTaskCount =>
      taskdata.where((task) => task.status != 'Completed').length;

  void toggleTaskView(bool showTimeline) {
    isTimelineView = showTimeline;
    update(['task-view', 'sort-view', 'timeline-view']);
  }

  void onTapBottom(int value) {
    currentIndex = value;
    myServices.sharedPreferences.setInt("indexhome", currentIndex);
    update();
  }

  Future<void> getTaskCategories() async {
    try {
      final List<Map<String, dynamic>> maps =
          await sqlDb.readData('SELECT * FROM categoriestasks');
      taskCategories = maps.map((map) => CategoryModel.fromMap(map)).toList();
      update(['task-category-view']);
    } catch (e) {
      print("Error fetching task categories: $e");
      taskCategories.clear();
      update(['task-category-view']);
    }
  }

  Future<void> getNoteCategories() async {
    try {
      final List<Map<String, dynamic>> maps =
          await sqlDb.readData('SELECT * FROM categoriesnotes');
      noteCategories = maps.map((map) => CategoryModel.fromMap(map)).toList();
      update(['note-category-view']);
    } catch (e) {
      print("Error fetching note categories: $e");
      noteCategories.clear();
      update(['note-category-view', "notes-length"]);
    }
  }

  Future<void> addTaskCategory(String name) async {
    try {
      final response = await sqlDb.insertData(
        'INSERT INTO categoriestasks (categoryName) VALUES (?)',
        [name],
      );
      if (response > 0) {
        await getTaskCategories();
        Get.snackbar('key_success'.tr, 'key_category_added'.tr,
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('key_error'.tr, 'key_failed_to_add_category'.tr,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print("Error adding task category: $e");
      Get.snackbar('key_error'.tr, 'key_failed_to_add_category'.tr,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> addNoteCategory(String name) async {
    try {
      final response = await sqlDb.insertData(
        'INSERT INTO categoriesnotes (categoryName) VALUES (?)',
        [name],
      );
      if (response > 0) {
        await getNoteCategories();
        Get.snackbar('key_success'.tr, 'key_category_added'.tr,
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('key_error'.tr, 'key_failed_to_add_category'.tr,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print("Error adding note category: $e");
      Get.snackbar('key_error'.tr, 'key_failed_to_add_category'.tr,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> updateTaskCategory(int? id, String name) async {
    try {
      final response = await sqlDb.updateData(
        'UPDATE categoriestasks SET categoryName = ? WHERE id = ?',
        [name, id],
      );
      if (response > 0) {
        await getTaskCategories();
        Get.snackbar('key_success'.tr, 'key_category_updated'.tr,
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('key_error'.tr, 'key_failed_to_update_category'.tr,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print("Error updating task category: $e");
      Get.snackbar('key_error'.tr, 'key_failed_to_update_category'.tr,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> updateNoteCategory(int? id, String name) async {
    try {
      final response = await sqlDb.updateData(
        'UPDATE categoriesnotes SET categoryName = ? WHERE id = ?',
        [name, id],
      );
      if (response > 0) {
        await getNoteCategories();
        Get.snackbar('key_success'.tr, 'key_category_updated'.tr,
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('key_error'.tr, 'key_failed_to_update_category'.tr,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print("Error updating note category: $e");
      Get.snackbar('key_error'.tr, 'key_failed_to_update_category'.tr,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> deleteTaskCategory(int? id) async {
    if (id == null) {
      print("Error: Task Category ID is null");
      Get.snackbar('key_error'.tr, 'key_invalid_category_id'.tr,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      final categoriesDeleted = await sqlDb.deleteData(
        'DELETE FROM categoriestasks WHERE id = ?',
        [id],
      );
      print("Task categories deleted: $categoriesDeleted rows affected");

      if (categoriesDeleted == 0) {
        throw Exception("No task category found with ID $id");
      }

      await getTaskCategories();

      if (selectedTaskCategoryId.value == id) {
        selectedTaskCategoryId.value = null;
        await getTaskData();
      }

      Get.snackbar('key_success'.tr, 'key_category_deleted'.tr,
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print("Error deleting task category: $e");
      Get.snackbar('key_error'.tr, 'key_failed_to_delete_category'.tr,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> deleteNoteCategory(int? id) async {
    if (id == null) {
      print("Error: Note Category ID is null");
      Get.snackbar('key_error'.tr, 'key_invalid_category_id'.tr,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      final categoriesDeleted = await sqlDb.deleteData(
        'DELETE FROM categoriesnotes WHERE id = ?',
        [id],
      );
      print("Note categories deleted: $categoriesDeleted rows affected");

      if (categoriesDeleted == 0) {
        throw Exception("No note category found with ID $id");
      }

      await getNoteCategories();

      if (selectedNoteCategoryId.value == id) {
        selectedNoteCategoryId.value = null;
        await getNoteData();
      }

      Get.snackbar('key_success'.tr, 'key_category_deleted'.tr,
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print("Error deleting note category: $e");
      Get.snackbar('key_error'.tr, 'key_failed_to_delete_category'.tr,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> deleteDataNote(String id) async {
    int response =
        await sqlDb.deleteData("DELETE FROM notes WHERE id = ?", [id]);
    if (response > 0) {
      notedata.removeWhere((note) => note.id == id);
      update(['notes-view', "notes-length"]);
      Get.snackbar('key_success'.tr, 'key_note_deleted'.tr,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('key_error'.tr, 'key_failed_to_delete_note'.tr,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> deleteDataTask(String idtask) async {
    int response =
        await sqlDb.deleteData("DELETE FROM tasks WHERE id = ?", [idtask]);
    if (response > 0) {
      taskdata.removeWhere((task) => task.id == idtask);
      deactivateAlarm(idtask);
      update(['task-view', 'timeline-view', "task-length"]);
    }
  }

  Future<void> updateStatus(
      String status, String id, String statustarget) async {
    await sqlDb.updateData(
        "UPDATE tasks SET status = ? WHERE id = ?", [statustarget, id]);
    final index = taskdata.indexWhere((task) => task.id == id);
    if (index != -1) {
      taskdata[index] = UserTasksModel(
        id: taskdata[index].id,
        title: taskdata[index].title,
        content: taskdata[index].content,
        date: taskdata[index].date,
        estimatetime: taskdata[index].estimatetime,
        starttime: taskdata[index].starttime,
        timeline: taskdata[index].timeline,
        reminder: taskdata[index].reminder,
        status: statustarget,
        priority: taskdata[index].priority,
        subtask: taskdata[index].subtask,
        images: taskdata[index].images,
      );
      if (statustarget == 'Completed') {
        try {
          await _audioPlayer.play(AssetSource('completed.mp3'));
        } catch (e) {
          print('Error playing sound: $e');
        }
      }
      update(['task-view', 'timeline-view', "task-length"]);
    }
  }

  Future<void> getNoteData() async {
    isLoadingNotes = true;
    update(['notes-view']);
    List<Map<String, dynamic>> response;
    if (selectedNoteCategoryId.value == null) {
      response = await sqlDb.readData('SELECT * FROM notes');
    } else {
      response = await sqlDb.readData(
        'SELECT * FROM notes WHERE categoryId = ?',
        [selectedNoteCategoryId.value],
      );
    }
    notedata.clear();
    notedata.addAll(response.map((e) => UserNotesModel.fromJson(e)).toList());
    isLoadingNotes = false;
    update(['notes-view', "notes-length"]);
  }

  Future<void> getTaskData() async {
    isLoadingTasks = true;
    update(['task-view', 'timeline-view', "task-length"]);
    List<Map<String, dynamic>> response;
    if (selectedTaskCategoryId.value == null) {
      response = await sqlDb.readData('SELECT * FROM tasks');
    } else {
      response = await sqlDb.readData(
        'SELECT * FROM tasks WHERE categoryId = ?',
        [selectedTaskCategoryId.value],
      );
    }
    taskdata.clear();
    taskdata.addAll(response.map((e) => UserTasksModel.fromJson(e)).toList());
    isLoadingTasks = false;
    update(['task-view', 'sort-view', 'timeline-view', "task-length"]);
  }

  Future<void> goToViewNote(String content, String title, String idnote,
      String signature, String category) async {
    Get.toNamed(
      AppRoute.viewNote,
      arguments: {
        "note": UserNotesModel(
            id: idnote,
            title: title,
            content: content,
            drawing: signature,
            categoryId: category),
      },
    );
  }

  Future<void> goToViewTask(UserTasksModel task, String index) async {
    Get.toNamed(AppRoute.viewTask, arguments: {
      "task": task,
      "taskindex": index,
    });
  }

  void sortTasks(String criterion) {
    selectedSortCriterion = criterion;
    if (criterion == "priority") {
      const priorityOrder = {'High': 1, 'Medium': 2, 'Low': 3, 'Not Set': 4};
      taskdata.sort((a, b) => (priorityOrder[a.priority] ?? 0)
          .compareTo(priorityOrder[b.priority] ?? 0));
    } else if (criterion == "status") {
      const statusOrder = {'In Progress': 1, 'Pending': 2, 'Completed': 3};
      taskdata.sort((a, b) =>
          (statusOrder[a.status] ?? 0).compareTo(statusOrder[b.status] ?? 0));
    } else if (criterion == "datecreated") {
      taskdata.sort((a, b) =>
          (a.date != null ? DateTime.parse(a.date!) : DateTime.now()).compareTo(
              b.date != null ? DateTime.parse(b.date!) : DateTime.now()));
    } else if (criterion == "datefinish") {
      taskdata.sort((a, b) {
        DateTime dateA = a.estimatetime != "Not Set" && a.estimatetime != null
            ? DateTime.parse(a.estimatetime!)
            : DateTime(9999);
        DateTime dateB = b.estimatetime != "Not Set" && b.estimatetime != null
            ? DateTime.parse(b.estimatetime!)
            : DateTime(9999);
        return dateA.compareTo(dateB);
      });
    } else if (criterion == "datestart") {
      taskdata.sort((a, b) {
        DateTime dateA = a.starttime != "Not Set" && a.starttime != null
            ? DateTime.parse(a.starttime!)
            : DateTime(9999);
        DateTime dateB = b.starttime != "Not Set" && b.starttime != null
            ? DateTime.parse(b.starttime!)
            : DateTime(9999);
        return dateA.compareTo(dateB);
      });
    }
    update(['task-view', 'timeline-view', 'sort-view', "task-length"]);
  }

  void filterTasksByCategory(int? categoryId) {
    selectedTaskCategoryId.value = categoryId;
    getTaskData();
  }

  void filterNotesByCategory(int? categoryId) {
    selectedNoteCategoryId.value = categoryId;
    getNoteData();
    update(['note-category-view', "notes-length"]);
  }

  @override
  void onInit() {
    getTaskCategories();
    getNoteCategories();
    getNoteData();
    getTaskData();
    currentIndex = myServices.sharedPreferences.getInt("indexhome") ?? 0;
    userid = myServices.sharedPreferences.getString("id");
    super.onInit();
  }
}
