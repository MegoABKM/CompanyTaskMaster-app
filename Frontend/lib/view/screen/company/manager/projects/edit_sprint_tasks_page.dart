import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/projects/edit_sprint_tasks_controller.dart';
import 'package:companymanagment/core/class/handlingdataview.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_button_auth.dart';
import 'package:companymanagment/view/widget/company/manager/home/empty_state_widget.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class EditSprintTasksPage extends StatelessWidget {
  const EditSprintTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditSprintTasksController());
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    return Scaffold(
      appBar: AppBar(title: Text("edit_sprint_tasks".tr)),
      body: GetBuilder<EditSprintTasksController>(
        builder: (controller) => Handlingdataview(
          statusRequest: controller.statusRequest,
          widget: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(scale.scale(16)),
                child: Text(
                  "select_tasks_for_sprint".tr,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontSize: scale.scaleText(16)),
                ),
              ),
              Expanded(
                child: controller.availableTasksForSelection.isEmpty
                    ? EmptyStateWidget(
                        icon: Icons.inventory_2_outlined,
                        message: "no_tasks_available".tr,
                        details: "create_tasks_in_backlog_first".tr,
                      )
                    : ListView.builder(
                        itemCount: controller.availableTasksForSelection.length,
                        itemBuilder: (context, index) {
                          final task =
                              controller.availableTasksForSelection[index];
                          final isSelected = controller.selectedTasks
                              .any((t) => t.id == task.id);
                          return CheckboxListTile(
                            title: Text(task.title ?? "untitled_task".tr),
                            value: isSelected,
                            onChanged: (bool? value) {
                              controller.toggleTaskSelection(task);
                            },
                          );
                        },
                      ),
              ),
              Padding(
                padding: EdgeInsets.all(scale.scale(16)),
                child: CustomButtonAuth(
                  textbutton: "save_changes".tr,
                  onPressed: controller.saveSprintTaskChanges,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
