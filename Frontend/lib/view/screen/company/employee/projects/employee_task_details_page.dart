import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/data/model/company/tasks/taskcompanymodel.dart';
import 'package:companymanagment/view/widget/company/manager/viewtask/taskdetails.dart'; // Re-use this widget

// A simple controller to hold the task data for the details page
class EmployeeTaskDetailsController extends GetxController {
  late TaskCompanyModel taskcompanydetail;

  @override
  void onInit() {
    super.onInit();
    taskcompanydetail = Get.arguments['task'];
  }
}

class EmployeeTaskDetailsPage extends StatelessWidget {
  const EmployeeTaskDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the task directly from arguments
    final TaskCompanyModel task = Get.arguments['task'];

    return Scaffold(
      appBar: AppBar(
        title: Text('task_details'.tr),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        // Pass the task object directly to the independent TaskDetails widget
        child: TaskDetails(
          theme: Theme.of(context),
          task: task,
        ),
      ),
    );
  }
}
