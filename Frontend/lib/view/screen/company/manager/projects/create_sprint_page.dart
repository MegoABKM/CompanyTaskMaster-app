import 'package:companymanagment/core/constant/utils/scale_confige.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/projects/create_sprint_controller.dart';
import 'package:companymanagment/core/class/handlingdataview.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_button_auth.dart';
import 'package:companymanagment/view/widget/company/manager/company/shared/build_text_filed_company.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class CreateSprintPage extends StatelessWidget {
  const CreateSprintPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateSprintController());
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    return Scaffold(
      appBar: AppBar(title: Text("create_new_sprint".tr)),
      body: GetBuilder<CreateSprintController>(
        builder: (controller) => Handlingdataview(
          statusRequest: controller.statusRequest,
          widget: Form(
            key: controller.formState,
            child: ListView(
              padding: EdgeInsets.all(scale.scale(16)),
              children: [
                Text("sprint_details".tr,
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(fontSize: scale.scaleText(22))),
                SizedBox(height: scale.scale(20)),
                BuildTextFiledCompany(
                  controller: controller.name,
                  label: "sprint_name".tr,
                  hint: "sprint_name_hint".tr,
                  validator: (val) =>
                      val!.isEmpty ? "cannot_be_empty".tr : null,
                ),
                SizedBox(height: scale.scale(20)),
                BuildTextFiledCompany(
                  controller: controller.goal,
                  label: "sprint_goal_optional".tr,
                  hint: "sprint_goal_hint".tr,
                  maxLines: 3,
                ),
                SizedBox(height: scale.scale(20)),
                _buildDateRangePicker(context, controller, scale),
                SizedBox(height: scale.scale(30)),
                Text("select_backlog_items".tr,
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(fontSize: scale.scaleText(22))),
                SizedBox(height: scale.scale(10)),
                _buildBacklogTaskList(controller),
                SizedBox(height: scale.scale(30)),
                CustomButtonAuth(
                  textbutton: "start_sprint".tr,
                  onPressed: controller.createSprintAndAssignTasks,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateRangePicker(BuildContext context,
      CreateSprintController controller, ScaleConfig scale) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller.startDateController,
            readOnly: true,
            decoration: InputDecoration(
                labelText: "start_date".tr, border: const OutlineInputBorder()),
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(const Duration(days: 30)),
                lastDate: DateTime(2101),
              );
              if (picked != null) {
                controller.startDateController.text =
                    "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
              }
            },
          ),
        ),
        SizedBox(width: scale.scale(16)),
        Expanded(
          child: TextFormField(
            controller: controller.endDateController,
            readOnly: true,
            decoration: InputDecoration(
                labelText: "end_date".tr, border: const OutlineInputBorder()),
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now().add(const Duration(days: 14)),
                firstDate: DateTime.now(),
                lastDate: DateTime(2101),
              );
              if (picked != null) {
                controller.endDateController.text =
                    "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBacklogTaskList(CreateSprintController controller) {
    if (controller.backlogTasks.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(child: Text("no_items_in_backlog".tr)),
      );
    }
    return Container(
      height: 250,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.builder(
        itemCount: controller.backlogTasks.length,
        itemBuilder: (context, index) {
          final task = controller.backlogTasks[index];
          return CheckboxListTile(
            title: Text(task.title ?? "untitled_task".tr),
            value: controller.selectedTasks.contains(task),
            onChanged: (bool? value) {
              controller.toggleTaskSelection(task);
            },
          );
        },
      ),
    );
  }
}
