import 'package:companymanagment/view/screen/company/shared/project_timeline_page.dart'; // Ensure this is imported
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/employee/projects/employee_project_workspace_controller.dart';
import 'package:companymanagment/core/class/handlingdataview.dart';
import 'package:companymanagment/view/widget/company/manager/projects/kanban_board.dart';
import 'package:companymanagment/view/widget/company/manager/projects/scrum/scrum_board.dart';
import 'package:companymanagment/view/widget/company/manager/projects/scrum/backlog_list_widget.dart';

class EmployeeProjectWorkspacePage extends StatelessWidget {
  const EmployeeProjectWorkspacePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EmployeeProjectWorkspaceController());

    return GetBuilder<EmployeeProjectWorkspaceController>(
      builder: (controller) {
        // --- THIS IS THE FIX ---
        // Define the actions list here to be used in both Scaffolds.
        final List<Widget> appBarActions = [
          IconButton(
            icon: const Icon(Icons.timeline),
            tooltip: "view_timeline".tr,
            onPressed: () => Get.to(
              () => const ProjectTimelinePage(),
              arguments: {
                'project': controller.project,
                'sprints': controller.sprints,
                'tasks': controller.allTasks,
              },
            ),
          ),
        ];
        // --- END OF FIX ---

        if (controller.project.methodologyType == 'Scrum') {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                    controller.project.projectName ?? "project_workspace".tr),
                // Use the actions list here
                actions: appBarActions,
                bottom: TabBar(
                  tabs: [
                    Tab(icon: const Icon(Icons.sync_alt), text: "sprints".tr),
                    Tab(
                        icon: const Icon(Icons.inventory_2_outlined),
                        text: "backlog".tr),
                  ],
                ),
              ),
              body: Handlingdataview(
                statusRequest: controller.statusRequest,
                widget: TabBarView(
                  children: [
                    ScrumBoard(
                      sprints: controller.sprints,
                      allTasks: controller.allTasks,
                      isManagerView: false,
                    ),
                    BacklogListWidget(
                      tasks: controller.backlogTasks,
                      onTaskTap: (task) => controller.goToTaskDetails(task),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  controller.project.projectName ?? "project_workspace".tr),
              // Use the actions list here as well
              actions: appBarActions,
            ),
            body: Handlingdataview(
              statusRequest: controller.statusRequest,
              widget: KanbanBoard(tasks: controller.allTasks),
            ),
          );
        }
      },
    );
  }
}
