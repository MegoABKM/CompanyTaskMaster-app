import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/data/datasource/remote/company/manager/projects_data.dart';
import 'package:companymanagment/data/model/company/project_model.dart';

class UpdateProjectController extends GetxController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController description;
  late TextEditingController deadlineController;

  late ProjectModel project;
  String priority = 'Medium';
  final List<String> priorityOptions = ['Low', 'Medium', 'High', 'Critical'];

  ProjectsData projectsData = ProjectsData(Get.find());
  StatusRequest? statusRequest;

  @override
  void onInit() {
    project = Get.arguments['project'];
    name = TextEditingController(text: project.projectName);
    description = TextEditingController(text: project.projectDescription);
    deadlineController = TextEditingController(text: project.deadline);
    priority = project.priority ?? 'Medium';
    super.onInit();
  }

  void updatePriority(String? newPriority) {
    if (newPriority != null) {
      priority = newPriority;
      update();
    }
  }

  Future<void> saveProjectChanges() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await projectsData.updateProject(
        projectId: project.projectId.toString(),
        name: name.text,
        description: description.text,
        deadline: deadlineController.text,
        priority: priority,
      );

      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == 'success') {
          Get.back(result: 'success'); // Go back and signal success
          Get.snackbar("Success", "Project updated successfully.");
        } else {
          Get.snackbar("Error", "Failed to update project.");
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    }
  }

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    deadlineController.dispose();
    super.dispose();
  }
}
