import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/data/model/company/sprint_model.dart';
import 'package:companymanagment/data/model/company/tasks/taskcompanymodel.dart';
import 'package:companymanagment/view/widget/company/manager/home/empty_state_widget.dart';
import 'package:companymanagment/view/widget/company/manager/projects/scrum/sprint_card.dart';

class ScrumBoard extends StatelessWidget {
  final List<SprintModel> sprints;
  final List<TaskCompanyModel> allTasks;
  final bool isManagerView;
  final VoidCallback? onCreateSprint;

  const ScrumBoard({
    super.key,
    required this.sprints,
    required this.allTasks,
    this.isManagerView = false,
    this.onCreateSprint,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isManagerView
          ? FloatingActionButton(
              onPressed: onCreateSprint,
              child: const Icon(Icons.add),
              tooltip: 'create_sprint'.tr,
            )
          : null,
      body: sprints.isEmpty
          ? EmptyStateWidget(
              icon: Icons.circle_outlined,
              message: 'no_sprints_planned'.tr,
              details: 'create_sprint_details'.tr,
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: sprints.length,
              itemBuilder: (context, index) {
                final sprint = sprints[index];
                final sprintTasks = allTasks
                    .where((task) => task.sprintId == sprint.sprintId)
                    .toList();
                return SprintCard(
                  sprint: sprint,
                  tasks: sprintTasks,
                  allProjectTasks: allTasks,
                  isManagerView: isManagerView, // THE FIX: Pass the flag down
                );
              },
            ),
    );
  }
}
