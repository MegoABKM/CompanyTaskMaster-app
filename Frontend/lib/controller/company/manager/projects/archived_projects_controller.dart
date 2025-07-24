import 'package:get/get.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/data/datasource/remote/company/manager/projects_data.dart';
import 'package:companymanagment/data/model/company/project_model.dart';
import 'package:companymanagment/controller/company/manager/projects/projects_controller.dart'; // To get companyId

class ArchivedProjectsController extends GetxController {
  ProjectsData projectsData = ProjectsData(Get.find());
  List<ProjectModel> archivedProjects = [];
  StatusRequest? statusRequest;
  String? companyId;

  @override
  void onInit() {
    // Get the company ID from the main ProjectsController
    try {
      companyId = Get.find<ProjectsController>().companyId;
      if (companyId != null) {
        getArchivedProjects();
      }
    } catch (e) {
      print("Could not find ProjectsController or company ID.");
      statusRequest = StatusRequest.failure;
    }
    super.onInit();
  }

  Future<void> getArchivedProjects() async {
    statusRequest = StatusRequest.loading;
    update();

    if (companyId == null) {
      statusRequest = StatusRequest.failure;
      update();
      return;
    }

    // We can reuse the getAllProjects endpoint, as it fetches all projects.
    // We will filter them on the client-side.
    var response = await projectsData.getAllProjects(companyId!);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List responseData = response['data'];
        List<ProjectModel> allProjects =
            responseData.map((e) => ProjectModel.fromJson(e)).toList();
        // Filter for only 'Archived' projects
        archivedProjects = allProjects
            .where((project) => project.status == 'Archived')
            .toList();
      } else {
        archivedProjects = [];
      }
    }
    update();
  }

  // Optional: Add a method to unarchive a project
  Future<void> unarchiveProject(String projectId) async {
    var response = await projectsData.updateProjectStatus(projectId, 'Active');
    if (response['status'] == 'success') {
      Get.snackbar("Success", "Project has been restored.");
      getArchivedProjects(); // Refresh the list
      Get.find<ProjectsController>()
          .getProjects(); // Refresh the main project list
    } else {
      Get.snackbar("Error", "Could not restore project.");
    }
  }
}
