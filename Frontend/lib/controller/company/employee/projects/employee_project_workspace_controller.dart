import 'package:get/get.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/data/datasource/remote/company/manager/projects_data.dart';
import 'package:companymanagment/data/model/company/project_model.dart';
import 'package:companymanagment/data/model/company/sprint_model.dart';
import 'package:companymanagment/data/model/company/tasks/taskcompanymodel.dart';
import 'package:companymanagment/controller/company/manager/projects/project_workspace_controller.dart';
// REMOVE the old details page import
// import 'package:companymanagment/view/screen/company/employee/projects/employee_task_details_page.dart';
// ADD THE CORRECT, FULL-FEATURED VIEW PAGE
import 'package:companymanagment/view/screen/company/employee/tasks/view_task_company_employee.dart';

class EmployeeProjectWorkspaceController extends GetxController {
  late ProjectModel project;
  List<SprintModel> sprints = [];
  List<TaskCompanyModel> allTasks = [];
  List<TaskCompanyModel> backlogTasks = [];

  ProjectsData projectsData = ProjectsData(Get.find());
  StatusRequest? statusRequest;

  @override
  void onInit() {
    project = Get.arguments['project'];
    getWorkspaceData();
    super.onInit();
  }

  Future<void> getWorkspaceData() async {
    statusRequest = StatusRequest.loading;
    update();

    var response =
        await projectsData.getWorkspace(project.projectId.toString());
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success &&
        response['status'] == 'success') {
      var data = response['data'];
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
    } else {
      Get.snackbar("Error", "Could not load project data.");
      statusRequest = StatusRequest.failure;
    }
    update();
  }

  // THE FIX: Navigate to the correct, full-featured view page for employees.
  void goToTaskDetails(TaskCompanyModel task) {
    Get.to(() => const ViewTaskCompanyEmployee(), arguments: {
      'taskcompanydetail': task,
      // We can pass project members as the potential assignees, though this view is read-only.
      'companyemployee': project.members,
    });
  }
}
