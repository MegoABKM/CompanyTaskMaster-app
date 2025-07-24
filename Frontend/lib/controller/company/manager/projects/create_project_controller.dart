import 'package:companymanagment/controller/company/manager/homemanager/home_manager_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/core/services/services.dart';
import 'package:companymanagment/data/datasource/remote/company/manager/projects_data.dart';

class CreateProjectController extends GetxController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController description;
  late TextEditingController budget;
  // State for deadline and priority
  String? deadline;
  String priority = 'Medium';
  final List<String> priorityOptions = ['Low', 'Medium', 'High', 'Critical'];

  // NEW: State for methodology
  String methodologyType = 'Kanban';
  final List<String> methodologyOptions = ['Kanban', 'Scrum'];

  ProjectsData projectsData = ProjectsData(Get.find());
  StatusRequest? statusRequest;
  MyServices myServices = Get.find();

  // Methods to update state from UI
  void updateDeadline(String? newDeadline) {
    deadline = newDeadline;
    update();
  }

  void updatePriority(String? newPriority) {
    if (newPriority != null) {
      priority = newPriority;
      update();
    }
  }

  // NEW: Method to update methodology
  void updateMethodology(String? newMethodology) {
    if (newMethodology != null) {
      methodologyType = newMethodology;
      update();
    }
  }

  Future<void> addProject() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      String? companyId =
          Get.find<ManagerhomeController>().companyData.first.companyId;
      String? managerId = myServices.sharedPreferences.getString("id");

      var response = await projectsData.createProject(
        name.text,
        description.text,
        companyId!,
        managerId!,
        deadline,
        priority,
        // Pass the methodology type
        methodologyType,
        budget.text,
      );

      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          Get.back(result: 'success'); // Go back and signal success
        } else {
          Get.snackbar("Error", "Failed to create project.");
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    }
  }

  @override
  void onInit() {
    name = TextEditingController();
    description = TextEditingController();
    budget = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    budget.dispose();
    super.dispose();
  }
}
