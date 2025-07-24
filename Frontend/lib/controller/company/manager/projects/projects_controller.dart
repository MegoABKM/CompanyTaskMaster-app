import 'package:companymanagment/controller/company/manager/homemanager/home_manager_controller.dart';
import 'package:companymanagment/data/model/company/project_model.dart';
import 'package:companymanagment/view/screen/company/manager/projects/create_project.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/core/services/services.dart';
import 'package:companymanagment/data/datasource/remote/company/manager/projects_data.dart';

class ProjectsController extends GetxController {
  ProjectsData projectsData = ProjectsData(Get.find());
  List<ProjectModel> projects = [];
  StatusRequest? statusRequest;
  MyServices myServices = Get.find();
  String? companyId;

  Future<void> getProjects() async {
    statusRequest = StatusRequest.loading;
    update();

    if (companyId == null) {
      statusRequest = StatusRequest.failure;
      update();
      return;
    }

    var response = await projectsData.getAllProjects(companyId!);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List responseData = response['data'];

        // --- FIX IS HERE ---
        // 1. Map all projects from the response.
        List<ProjectModel> allProjects =
            responseData.map((e) => ProjectModel.fromJson(e)).toList();

        // 2. Filter the list to only include projects that are NOT archived.
        projects = allProjects
            .where((project) => project.status != 'Archived')
            .toList();
      } else {
        projects = []; // Clear list if API returns failure
      }
    }
    update();
  }

  void goToCreateProject() async {
    final result = await Get.to(() => const CreateProjectPage());
    if (result == 'success') {
      getProjects(); // Refresh the list after creating a new project
    }
  }

  @override
  void onInit() {
    // Attempt to get company ID from ManagerhomeController
    try {
      ManagerhomeController managerhomeController = Get.find();
      if (managerhomeController.companyData.isNotEmpty) {
        companyId = managerhomeController.companyData.first.companyId;
        getProjects();
      }
    } catch (e) {
      print("Could not find ManagerhomeController or company data.");
      statusRequest = StatusRequest.failure;
    }
    super.onInit();
  }
}
