// lib/controller/company/manager/projects/project_workspace_controller.dart
import 'package:companymanagment/data/datasource/remote/linkapi.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';
import 'package:companymanagment/data/model/company/project_model.dart';
import 'package:companymanagment/data/model/company/sprint_model.dart';
import 'package:companymanagment/view/screen/company/manager/projects/assign_project_memebers_page.dart';
import 'package:companymanagment/view/screen/company/manager/projects/update_project_page.dart';
import 'package:companymanagment/view/screen/company/manager/tasks/viewtaskcompany.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/data/datasource/remote/company/manager/projects_data.dart';
import 'package:companymanagment/data/model/company/tasks/taskcompanymodel.dart';
import 'package:companymanagment/controller/company/manager/homemanager/home_manager_controller.dart';
import 'package:companymanagment/data/model/company/finance_model.dart';
import 'package:companymanagment/data/datasource/remote/company/manager/finance_date.dart';
import 'package:companymanagment/view/screen/company/manager/finance/add_financial_entry_page.dart';

class ProjectWorkspaceController extends GetxController {
  late ProjectModel project;
  List<SprintModel> sprints = [];
  List<TaskCompanyModel> allTasks = [];
  List<TaskCompanyModel> backlogTasks = [];
  List<Employees> projectMembers = [];
  List<Employees> allCompanyEmployees = [];

  ProjectsData projectsData = ProjectsData(Get.find());
  StatusRequest? statusRequest;

  // NEW Financial Properties
  final FinanceData financeData = FinanceData(Get.find());
  List<ProjectFinanceModel> projectTransactions = [];
  double projectRevenue = 0.0;
  double projectCost = 0.0;
  double get projectProfit => projectRevenue - projectCost;

  @override
  void onInit() {
    project = Get.arguments['project'];
    allCompanyEmployees =
        Get.find<ManagerhomeController>().companyData.first.employees ?? [];
    getWorkspaceData();
    super.onInit();
  }

  Future<void> getWorkspaceData() async {
    statusRequest = StatusRequest.loading;
    update();

    final Future<dynamic> coreDataFuture =
        projectsData.getWorkspace(project.projectId.toString());
    // FIX IS HERE: Call the method directly from the financeData instance
    final Future<dynamic> financeDataFuture =
        financeData.getProjectDetails(project.projectId.toString());

    final List<dynamic> responses =
        await Future.wait<dynamic>([coreDataFuture, financeDataFuture]);
    // Handle Core Data Response
    var coreResponse = responses[0];
    statusRequest = handlingData(coreResponse);

    if (statusRequest == StatusRequest.success &&
        coreResponse['status'] == 'success') {
      var data = coreResponse['data'];
      project = ProjectModel.fromJson(data['project']);
      sprints = (data['sprints'] as List)
          .map((e) => SprintModel.fromJson(e))
          .toList();
      allTasks = (data['tasks'] as List)
          .map((e) => TaskCompanyModel.fromJson(e))
          .toList();
      backlogTasks = (data['backlog'] as List)
          .map((e) => TaskCompanyModel.fromJson(e))
          .toList();
      projectMembers = project.members ?? [];
    } else {
      Get.snackbar("Error", "Could not load project data.");
      statusRequest = StatusRequest.failure;
    }

    // Handle Finance Data Response
    var financeResponse = responses[1];
    if (handlingData(financeResponse) == StatusRequest.success &&
        financeResponse['status'] == 'success') {
      projectTransactions = (financeResponse['data'] as List? ?? [])
          .map((e) => ProjectFinanceModel.fromJson(e))
          .toList();
      _calculateProjectTotals();
    }

    update();
  }

  void _calculateProjectTotals() {
    projectRevenue = projectTransactions
        .where((e) => e.type == 'Revenue')
        .fold(0, (sum, item) => sum + item.amount);
    projectCost = projectTransactions
        .where((e) => e.type == 'Cost')
        .fold(0, (sum, item) => sum + item.amount);
  }

  void navigateToAddProjectEntry(String type) async {
    final result =
        await Get.to(() => const AddFinancialEntryPage(), arguments: {
      'entryType': type,
      'companyId': project.companyId.toString(),
      'projectId': project.projectId.toString(),
      'entryToEdit': null, // Explicitly null for adding
    });
    if (result == 'success') {
      getWorkspaceData();
    }
  }

  void navigateToEditProjectEntry(ProjectFinanceModel entry) async {
    final result =
        await Get.to(() => const AddFinancialEntryPage(), arguments: {
      'entryType': entry.type,
      'companyId': project.companyId.toString(),
      'projectId': project.projectId.toString(),
      'entryToEdit': entry, // Pass the entry to edit
    });
    if (result == 'success') {
      getWorkspaceData();
    }
  }

  void deleteProjectEntry(int id) async {
    var response = await financeData.deleteEntry(id: id, type: 'project');
    if (response['status'] == 'success') {
      Get.snackbar('Success', 'Entry deleted successfully.');
      getWorkspaceData(); // Refresh the list
    } else {
      Get.snackbar('Error', 'Failed to delete entry.');
    }
  }

  void goToTaskDetails(TaskCompanyModel task) async {
    final result = await Get.to(
      () => const ViewTaskCompany(),
      arguments: {
        "taskcompanydetail": task,
        "companyemployee": projectMembers,
      },
    );

    if (result == 'updated') {
      getWorkspaceData();
    }
  }

  void goToAssignMembers() async {
    final result = await Get.to(
      () => const AssignProjectMembersPage(),
      arguments: {
        'project': project,
        'allCompanyEmployees': allCompanyEmployees,
        'currentlyAssigned': projectMembers,
      },
    );

    if (result == 'success') {
      getWorkspaceData();
    }
  }

  void goToUpdateProject() async {
    final result = await Get.to(() => const UpdateProjectPage(),
        arguments: {'project': project});
    if (result == 'success') {
      getWorkspaceData();
      Get.find<ManagerhomeController>().getData();
    }
  }

  void deleteProject() {
    Get.defaultDialog(
      title: "Delete Project",
      middleText:
          "Are you sure? This will permanently delete the project and all its associated tasks and sprints.",
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () async {
            Get.back();
            statusRequest = StatusRequest.loading;
            update();
            var response =
                await projectsData.deleteProject(project.projectId.toString());
            if (response['status'] == 'success') {
              Get.back();
              Get.find<ManagerhomeController>().getData();
            } else {
              Get.snackbar("Error", "Failed to delete project.");
            }
            statusRequest = null;
            update();
          },
          child: const Text("DELETE", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  void archiveProject() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await projectsData.updateProjectStatus(
        project.projectId.toString(), 'Archived');

    if (response['status'] == 'success') {
      Get.back();
      Get.find<ManagerhomeController>().getData();
    } else {
      Get.snackbar("Error", "Failed to archive project.");
    }
    statusRequest = null;
    update();
  }
}

extension ProjectWorkspace on ProjectsData {
  getWorkspace(String projectId) async {
    var response = await crud.postData(AppLink.getProjectWorkspace, {
      "project_id": projectId,
    });
    return response.fold((l) => l, (r) => r);
  }
}
