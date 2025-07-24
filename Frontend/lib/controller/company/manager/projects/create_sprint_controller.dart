import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/data/datasource/remote/company/manager/sprints_data.dart';
import 'package:companymanagment/data/model/company/project_model.dart';
import 'package:companymanagment/data/model/company/tasks/taskcompanymodel.dart';
import 'package:companymanagment/controller/company/manager/projects/project_workspace_controller.dart'; // Import workspace controller

class CreateSprintController extends GetxController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController goal;
  late TextEditingController startDateController;
  late TextEditingController endDateController;

  late ProjectModel project;
  List<TaskCompanyModel> backlogTasks = [];
  List<TaskCompanyModel> selectedTasks = [];

  SprintsData sprintsData = SprintsData(Get.find());
  StatusRequest? statusRequest;

  @override
  void onInit() {
    project = Get.arguments['project'];
    backlogTasks = Get.arguments['backlogTasks'];
    name = TextEditingController();
    goal = TextEditingController();
    startDateController = TextEditingController();
    endDateController = TextEditingController();
    super.onInit();
  }

  void toggleTaskSelection(TaskCompanyModel task) {
    if (selectedTasks.contains(task)) {
      selectedTasks.remove(task);
    } else {
      selectedTasks.add(task);
    }
    update();
  }

  Future<void> createSprintAndAssignTasks() async {
    if (formState.currentState!.validate()) {
      if (startDateController.text.isEmpty || endDateController.text.isEmpty) {
        Get.snackbar("Validation Error",
            "Please select a start and end date for the sprint.");
        return;
      }

      statusRequest = StatusRequest.loading;
      update();

      // Step 1: Create the Sprint
      var sprintResponse = await sprintsData.createSprint(
        projectId: project.projectId.toString(),
        sprintName: name.text,
        sprintGoal: goal.text,
        startDate: startDateController.text,
        endDate: endDateController.text,
      );

      statusRequest = handlingData(sprintResponse);

      if (statusRequest == StatusRequest.success &&
          sprintResponse['status'] == 'success') {
        String newSprintId = sprintResponse['data']['id'].toString();

        // Step 2: If tasks were selected, assign them to the new sprint.
        if (selectedTasks.isNotEmpty) {
          String taskIds = selectedTasks.map((task) => task.id!).join(',');

          // Call the API to assign all selected tasks to the new sprint ID
          await sprintsData.updateSprintTasks(
            sprintId: newSprintId,
            taskIds: taskIds,
          );
        }

        Get.snackbar("Success", "Sprint created and tasks assigned!");

        // THE FIX: Navigate back and refresh the project workspace
        Get.back(result: 'success'); // This signals the ScrumBoard to refresh.
        // We also explicitly find the controller and call the refresh method
        // to ensure the sprint list is updated immediately.
        if (Get.isRegistered<ProjectWorkspaceController>()) {
          Get.find<ProjectWorkspaceController>().getWorkspaceData();
        }
      } else {
        Get.snackbar("Error", "Failed to create sprint. Please try again.");
        statusRequest = StatusRequest.failure;
      }

      update();
    }
  }

  @override
  void dispose() {
    name.dispose();
    goal.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }
}
