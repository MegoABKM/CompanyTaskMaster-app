import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/data/model/company/tasks/taskcompanymodel.dart';
import 'package:companymanagment/view/widget/company/manager/taskattributes.dart';
import 'package:companymanagment/view/widget/company/manager/home/empty_state_widget.dart';
// Import both controllers that might use this board
import 'package:companymanagment/controller/company/manager/projects/project_workspace_controller.dart';
import 'package:companymanagment/controller/company/employee/projects/employee_project_workspace_controller.dart';

class KanbanBoard extends StatelessWidget {
  final List<TaskCompanyModel> tasks;
  const KanbanBoard({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final pendingTasks =
        tasks.where((task) => task.status == 'Pending').toList();
    final inProgressTasks =
        tasks.where((task) => task.status == 'In Progress').toList();
    final completedTasks =
        tasks.where((task) => task.status == 'Completed').toList();

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "${'kanban_pending'.tr} (${pendingTasks.length})"),
              Tab(
                  text:
                      "${'kanban_in_progress'.tr} (${inProgressTasks.length})"),
              Tab(text: "${'kanban_completed'.tr} (${completedTasks.length})"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildTaskList(pendingTasks),
                _buildTaskList(inProgressTasks),
                _buildTaskList(completedTasks),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList(List<TaskCompanyModel> taskList) {
    if (taskList.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.task_alt_outlined,
        message: 'no_tasks_here'.tr,
        details: 'tasks_with_status_will_appear'.tr,
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        final task = taskList[index];
        // NEW: Smartly find the correct controller and pass the navigation function
        VoidCallback? onTap;
        if (Get.isRegistered<ProjectWorkspaceController>()) {
          onTap = () =>
              Get.find<ProjectWorkspaceController>().goToTaskDetails(task);
        } else if (Get.isRegistered<EmployeeProjectWorkspaceController>()) {
          onTap = () => Get.find<EmployeeProjectWorkspaceController>()
              .goToTaskDetails(task);
        }

        return TaskCompanyAttributes(
          task: task,
          onTap: onTap, // Pass the function here
        );
      },
    );
  }
}
