import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/data/model/company/sprint_model.dart';
import 'package:companymanagment/data/model/company/tasks/taskcompanymodel.dart';
import 'package:companymanagment/view/widget/company/manager/projects/kanban_board.dart';

class EmployeeSprintViewPage extends StatelessWidget {
  const EmployeeSprintViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the passed arguments
    final SprintModel sprint = Get.arguments['sprint'];
    final List<TaskCompanyModel> sprintTasks = Get.arguments['sprint_tasks'];

    return Scaffold(
      appBar: AppBar(
        title: Text(sprint.sprintName ?? 'sprint_details'.tr),
      ),
      body: KanbanBoard(tasks: sprintTasks),
    );
  }
}
