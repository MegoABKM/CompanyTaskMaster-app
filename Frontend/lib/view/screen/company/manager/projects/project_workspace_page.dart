// lib/view/screen/company/manager/projects/project_workspace_page.dart
import 'package:companymanagment/view/screen/company/shared/project_timeline_page.dart';
import 'package:companymanagment/view/widget/company/manager/projects/project_finance_tap.dart';
import 'package:companymanagment/view/widget/company/manager/projects/scrum/backlog_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/projects/project_workspace_controller.dart';
import 'package:companymanagment/core/class/handlingdataview.dart';
import 'package:companymanagment/view/screen/company/manager/projects/create_sprint_page.dart';
import 'package:companymanagment/view/screen/company/manager/tasks/createtask/createtaskcompany.dart';
import 'package:companymanagment/view/widget/company/manager/projects/kanban_board.dart';
import 'package:companymanagment/view/widget/company/manager/projects/scrum/scrum_board.dart';

class ProjectWorkspacePage extends StatelessWidget {
  const ProjectWorkspacePage({super.key});

  void _goToCreateSprint(ProjectWorkspaceController controller) async {
    final result = await Get.to(
      () => const CreateSprintPage(),
      arguments: {
        'project': controller.project,
        'backlogTasks': controller.backlogTasks,
      },
    );
    if (result == 'success') {
      controller.getWorkspaceData();
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ProjectWorkspaceController());

    return GetBuilder<ProjectWorkspaceController>(
      builder: (controller) {
        final addTaskFab = FloatingActionButton(
          onPressed: () async {
            final result = await Get.to(
              () => const CreateTaskCompany(),
              arguments: {
                'companyid': controller.project.companyId.toString(),
                'projectid': controller.project.projectId.toString(),
                'companyemployee': controller.projectMembers,
              },
            );

            if (result == 'created_task') {
              controller.getWorkspaceData();
            }
          },
          child: const Icon(Icons.add),
          tooltip: "add_task_to_project".tr,
        );

        final appBarActions = [
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
          IconButton(
            icon: const Icon(Icons.group_add_outlined),
            tooltip: "assign_members".tr,
            onPressed: controller.goToAssignMembers,
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                controller.goToUpdateProject();
              } else if (value == 'archive') {
                controller.archiveProject();
              } else if (value == 'delete') {
                controller.deleteProject();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'edit',
                child: ListTile(
                    leading: const Icon(Icons.edit), title: Text('edit'.tr)),
              ),
              PopupMenuItem<String>(
                value: 'archive',
                child: ListTile(
                    leading: const Icon(Icons.archive_outlined),
                    title: Text('archive_project'.tr)),
              ),
              const PopupMenuDivider(),
              PopupMenuItem<String>(
                value: 'delete',
                child: ListTile(
                    leading:
                        const Icon(Icons.delete_forever, color: Colors.red),
                    // FIX: Use translation key
                    title: Text('delete_project'.tr,
                        style: const TextStyle(color: Colors.red))),
              ),
            ],
          )
        ];

        int tabLength = controller.project.methodologyType == 'Scrum' ? 3 : 2;

        List<Widget> tabs = [];
        List<Widget> tabViews = [];

        if (controller.project.methodologyType == 'Scrum') {
          tabs.add(Tab(icon: const Icon(Icons.sync_alt), text: "sprints".tr));
          tabViews.add(ScrumBoard(
            sprints: controller.sprints,
            allTasks: controller.allTasks,
            isManagerView: true,
            onCreateSprint: () => _goToCreateSprint(controller),
          ));
          tabs.add(Tab(
              icon: const Icon(Icons.inventory_2_outlined),
              text: "backlog".tr));
        } else {
          tabs.add(Tab(
              icon: const Icon(Icons.view_kanban_outlined), text: "board".tr));
        }

        tabViews.add(Scaffold(
          floatingActionButton: addTaskFab,
          body: controller.project.methodologyType == 'Scrum'
              ? BacklogListWidget(
                  tasks: controller.backlogTasks,
                  onTaskTap: controller.goToTaskDetails)
              : KanbanBoard(tasks: controller.allTasks),
        ));

        tabs.add(Tab(
            icon: const Icon(Icons.monetization_on_outlined),
            text: "finances".tr));
        tabViews.add(const ProjectFinanceTab());

        return DefaultTabController(
          length: tabLength,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                  controller.project.projectName ?? "project_workspace".tr),
              actions: appBarActions,
              bottom: TabBar(tabs: tabs),
            ),
            body: Handlingdataview(
              statusRequest: controller.statusRequest,
              widget: TabBarView(children: tabViews),
            ),
          ),
        );
      },
    );
  }
}
