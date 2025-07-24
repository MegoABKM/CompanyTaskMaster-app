import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/data/datasource/remote/company/manager/sprints_data.dart';
import 'package:companymanagment/data/model/company/sprint_model.dart';

class UpdateSprintController extends GetxController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController goal;
  late TextEditingController startDateController;
  late TextEditingController endDateController;

  late SprintModel sprint;

  SprintsData sprintsData = SprintsData(Get.find());
  StatusRequest? statusRequest;

  @override
  void onInit() {
    sprint = Get.arguments['sprint'];
    name = TextEditingController(text: sprint.sprintName);
    goal = TextEditingController(text: sprint.sprintGoal);
    startDateController = TextEditingController(text: sprint.startDate);
    endDateController = TextEditingController(text: sprint.endDate);
    super.onInit();
  }

  Future<void> updateSprint() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await sprintsData.updateSprint(
        sprintId: sprint.sprintId.toString(),
        sprintName: name.text,
        sprintGoal: goal.text,
        startDate: startDateController.text,
        endDate: endDateController.text,
      );

      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          // Update the local sprint model and pass it back
          sprint.sprintName = name.text;
          sprint.sprintGoal = goal.text;
          sprint.startDate = startDateController.text;
          sprint.endDate = endDateController.text;

          Get.back(result: sprint);
          Get.snackbar("Success", "Sprint details updated.");
        } else {
          Get.snackbar("Error", "Failed to update sprint.");
          statusRequest = StatusRequest.failure;
        }
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
