import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/data/model/company/tasks/taskcompanymodel.dart';
import 'package:companymanagment/view/widget/company/manager/home/empty_state_widget.dart';
import 'package:companymanagment/view/widget/company/manager/taskattributes.dart';

class BacklogListWidget extends StatelessWidget {
  final List<TaskCompanyModel> tasks;
  // This callback makes the widget independent. It just reports a tap.
  final void Function(TaskCompanyModel task)? onTaskTap;

  const BacklogListWidget({
    super.key,
    required this.tasks,
    this.onTaskTap,
  });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.inventory_2_outlined,
        message: 'backlog_is_empty'.tr,
        details: 'backlog_empty_details'.tr,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskCompanyAttributes(
          task: task,
          // The onTap for the task attribute card is now passed from the parent.
          onTap: onTaskTap != null ? () => onTaskTap!(task) : null,
        );
      },
    );
  }
}
