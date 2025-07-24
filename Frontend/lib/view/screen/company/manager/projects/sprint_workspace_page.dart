// lib/view/screen/company/manager/projects/sprint_workspace_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/projects/sprint_workspace_controller.dart';
import 'package:companymanagment/core/class/handlingdataview.dart';
import 'package:companymanagment/view/widget/company/manager/projects/kanban_board.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class SprintWorkspacePage extends StatelessWidget {
  const SprintWorkspacePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SprintWorkspaceController());

    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<SprintWorkspaceController>(
          builder: (controller) =>
              Text(controller.sprint.sprintName ?? 'sprint_workspace'.tr),
        ),
        actions: [
          GetBuilder<SprintWorkspaceController>(builder: (controller) {
            return PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit_details') {
                  controller.goToUpdateSprint();
                } else if (value == 'edit_tasks') {
                  controller.goToEditSprintTasks();
                } else if (value == 'status') {
                  controller.showStatusUpdateDialog();
                } else if (value == 'delete') {
                  controller.deleteSprint();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'edit_details',
                  child: ListTile(
                      leading: const Icon(Icons.edit_note),
                      title: Text('edit_sprint_details'.tr)),
                ),
                PopupMenuItem<String>(
                  value: 'edit_tasks',
                  child: ListTile(
                      leading: const Icon(Icons.playlist_add),
                      title: Text('edit_sprint_tasks'.tr)),
                ),
                PopupMenuItem<String>(
                  value: 'status',
                  child: ListTile(
                      leading: const Icon(Icons.sync_alt),
                      title: Text('update_sprint_status'.tr)),
                ),
                const PopupMenuDivider(),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: ListTile(
                      leading:
                          const Icon(Icons.delete_forever, color: Colors.red),
                      // FIX: Use translation key
                      title: Text('delete_sprint'.tr,
                          style: const TextStyle(color: Colors.red))),
                ),
              ],
            );
          }),
        ],
      ),
      body: GetBuilder<SprintWorkspaceController>(
        builder: (controller) {
          return Handlingdataview(
            statusRequest: controller.statusRequest,
            widget: Column(
              children: [
                _buildSprintHeader(context, controller),
                Expanded(
                  child: KanbanBoard(tasks: controller.sprintTasks),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSprintHeader(
      BuildContext context, SprintWorkspaceController controller) {
    final theme = Theme.of(context);
    final scale = context.scaleConfig;
    return Padding(
      padding: EdgeInsets.all(scale.scale(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${controller.sprint.startDate} - ${controller.sprint.endDate}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                  fontSize: scale.scaleText(14),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: scale.scale(12), vertical: scale.scale(4)),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(scale.scale(20)),
                ),
                child: Text(
                  controller.sprint.status ?? 'not_available'.tr,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontSize: scale.scaleText(14),
                  ),
                ),
              ),
            ],
          ),
          if (controller.sprint.sprintGoal != null &&
              controller.sprint.sprintGoal!.isNotEmpty) ...[
            SizedBox(height: scale.scale(8)),
            Text(
              "${'goal_prefix'.tr} ${controller.sprint.sprintGoal}",
              style: theme.textTheme.titleSmall
                  ?.copyWith(fontSize: scale.scaleText(15)),
            ),
          ],
          const Divider(height: 24),
        ],
      ),
    );
  }
}
