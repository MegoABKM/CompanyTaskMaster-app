import 'package:get/get.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/data/datasource/remote/company/manager/sprints_data.dart';
import 'package:companymanagment/data/model/company/sprint_model.dart';
import 'package:companymanagment/data/model/company/tasks/taskcompanymodel.dart';

class EditSprintTasksController extends GetxController {
  late SprintModel sprint;
  List<TaskCompanyModel> backlogTasks = [];
  List<TaskCompanyModel> initiallyAssignedTasks = [];
  List<TaskCompanyModel> selectedTasks = [];

  SprintsData sprintsData = SprintsData(Get.find());
  StatusRequest? statusRequest;

  @override
  void onInit() {
    sprint = Get.arguments['sprint'];
    backlogTasks = Get.arguments['backlogTasks'];
    initiallyAssignedTasks = Get.arguments['sprintTasks'];

    // Combine backlog and currently assigned tasks for the selection list
    // and pre-select the ones that are already in the sprint.
    selectedTasks = List<TaskCompanyModel>.from(initiallyAssignedTasks);
    super.onInit();
  }

  // A combined list for the UI to display all available tasks
  List<TaskCompanyModel> get availableTasksForSelection {
    // Prevents duplicates if a task was somehow in both lists
    final allTasks = <TaskCompanyModel>{
      ...initiallyAssignedTasks,
      ...backlogTasks
    };
    return allTasks.toList();
  }

  void toggleTaskSelection(TaskCompanyModel task) {
    final isSelected = selectedTasks.any((t) => t.id == task.id);
    if (isSelected) {
      selectedTasks.removeWhere((t) => t.id == task.id);
    } else {
      selectedTasks.add(task);
    }
    update();
  }

  Future<void> saveSprintTaskChanges() async {
    statusRequest = StatusRequest.loading;
    update();

    // Create a comma-separated string of selected task IDs
    String taskIds = selectedTasks.map((e) => e.id!).join(',');

    var response = await sprintsData.updateSprintTasks(
      sprintId: sprint.sprintId.toString(),
      taskIds: taskIds,
    );

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == 'success') {
        Get.back(result: 'success'); // Go back and signal a refresh
        Get.snackbar("Success", "Sprint tasks updated successfully.");
      } else {
        Get.snackbar("Error", "Failed to update sprint tasks.");
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }
}
