import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/projects/update_sprint_controller.dart';
import 'package:companymanagment/core/class/handlingdataview.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_button_auth.dart';
import 'package:companymanagment/view/widget/company/manager/company/shared/build_text_filed_company.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class UpdateSprintPage extends StatelessWidget {
  const UpdateSprintPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UpdateSprintController());

    return Scaffold(
      appBar: AppBar(title: Text("update_sprint".tr)),
      body: GetBuilder<UpdateSprintController>(
        builder: (controller) => Handlingdataview(
          statusRequest: controller.statusRequest,
          widget: Form(
            key: controller.formState,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                BuildTextFiledCompany(
                  controller: controller.name,
                  label: "sprint_name".tr,
                  hint: "sprint_name_hint".tr,
                  validator: (val) =>
                      val!.isEmpty ? "cannot_be_empty".tr : null,
                ),
                const SizedBox(height: 20),
                BuildTextFiledCompany(
                  controller: controller.goal,
                  label: "sprint_goal_optional".tr,
                  hint: "sprint_goal_hint".tr,
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                _buildDateRangePicker(context, controller),
                const SizedBox(height: 30),
                CustomButtonAuth(
                  textbutton: "save_changes".tr,
                  onPressed: controller.updateSprint,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateRangePicker(
      BuildContext context, UpdateSprintController controller) {
    final scale = context.scaleConfig;
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
                initialDate:
                    DateTime.tryParse(controller.startDateController.text) ??
                        DateTime.now(),
                firstDate: DateTime.now().subtract(const Duration(days: 90)),
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
                initialDate:
                    DateTime.tryParse(controller.endDateController.text) ??
                        DateTime.now().add(const Duration(days: 14)),
                firstDate: DateTime.now().subtract(const Duration(days: 90)),
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
}
