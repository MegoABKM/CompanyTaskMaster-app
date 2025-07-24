import 'package:companymanagment/view/screen/company/manager/projects/edit_sprint_tasks_page.dart';
import 'package:companymanagment/view/screen/company/manager/projects/update_sprint_workspace_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/data/datasource/remote/company/manager/sprints_data.dart';
import 'package:companymanagment/data/model/company/sprint_model.dart';
import 'package:companymanagment/data/model/company/tasks/taskcompanymodel.dart';
import 'package:companymanagment/controller/company/manager/projects/project_workspace_controller.dart';

class SprintWorkspaceController extends GetxController {
  late SprintModel sprint;
  List<TaskCompanyModel> allProjectTasks = [];
  List<TaskCompanyModel> sprintTasks = [];

  SprintsData sprintsData = SprintsData(Get.find());
  StatusRequest? statusRequest;

  @override
  void onInit() {
    sprint = Get.arguments['sprint'];
    allProjectTasks = Get.arguments['tasks'];
    filterTasksForSprint();
    super.onInit();
  }

  void filterTasksForSprint() {
    sprintTasks = allProjectTasks
        .where((task) => task.sprintId == sprint.sprintId)
        .toList();
    update();
  }

  void goToUpdateSprint() async {
    final result = await Get.to(() => const UpdateSprintPage(),
        arguments: {'sprint': sprint});

    if (result is SprintModel) {
      sprint = result;
      update();
      Get.find<ProjectWorkspaceController>().getWorkspaceData();
    }
  }

  // NEW: Navigate to the edit tasks page
  void goToEditSprintTasks() async {
    // Get the latest backlog tasks from the parent controller
    final backlogTasks = Get.find<ProjectWorkspaceController>().backlogTasks;

    final result = await Get.to(
      () => const EditSprintTasksPage(),
      arguments: {
        'sprint': sprint,
        'sprintTasks': sprintTasks,
        'backlogTasks': backlogTasks,
      },
    );

    if (result == 'success') {
      // If tasks were updated, refresh the parent and this screen
      await Get.find<ProjectWorkspaceController>().getWorkspaceData();
      // Re-filter tasks for the current sprint
      allProjectTasks = Get.find<ProjectWorkspaceController>().allTasks;
      filterTasksForSprint();
    }
  }

  void showStatusUpdateDialog() {
    Get.defaultDialog(
      title: "Update Sprint Status",
      content: Column(
        children: [
          ListTile(
            title: const Text("Planned"),
            onTap: () {
              updateSprintStatus("Planned");
              Get.back();
            },
          ),
          ListTile(
            title: const Text("Active"),
            onTap: () {
              updateSprintStatus("Active");
              Get.back();
            },
          ),
          ListTile(
            title: const Text("Completed"),
            onTap: () {
              updateSprintStatus("Completed");
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  Future<void> updateSprintStatus(String newStatus) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await sprintsData.updateSprintStatus(
      sprintId: sprint.sprintId.toString(),
      status: newStatus,
    );

    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success &&
        response['status'] == 'success') {
      sprint.status = newStatus;
      Get.snackbar("Success", "Sprint status updated to '$newStatus'.");
      Get.find<ProjectWorkspaceController>().getWorkspaceData();
    } else {
      Get.snackbar("Error", "Failed to update status.");
    }
    update();
  }

  // NEW: Method to delete the current sprint
  void deleteSprint() {
    Get.defaultDialog(
      title: "Delete Sprint",
      middleText:
          "Are you sure? This will permanently delete the sprint. Tasks within it will be moved back to the backlog.",
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () async {
            Get.back(); // Close dialog first
            statusRequest = StatusRequest.loading;
            update();

            var response =
                await sprintsData.deleteSprint(sprint.sprintId.toString());

            if (response['status'] == 'success') {
              // Navigate back from the sprint workspace to the project workspace
              Get.back();
              // Find the parent controller and refresh its data to remove the deleted sprint from the list
              Get.find<ProjectWorkspaceController>().getWorkspaceData();
              Get.snackbar("Success", "Sprint deleted successfully.");
            } else {
              Get.snackbar("Error", "Failed to delete sprint.");
            }
            statusRequest = null;
            update();
          },
          child: const Text("DELETE", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
