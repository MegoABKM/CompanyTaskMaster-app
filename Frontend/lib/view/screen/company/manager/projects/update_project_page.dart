import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/projects/update_project_controller.dart';
import 'package:companymanagment/core/class/handlingdataview.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_button_auth.dart';
import 'package:companymanagment/view/widget/company/manager/company/shared/build_text_filed_company.dart';

class UpdateProjectPage extends StatelessWidget {
  const UpdateProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UpdateProjectController());

    return Scaffold(
      appBar: AppBar(title: Text("update_project".tr)),
      body: GetBuilder<UpdateProjectController>(
        builder: (controller) => Handlingdataview(
          statusRequest: controller.statusRequest,
          widget: Form(
            key: controller.formState,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                ListTile(
                  leading: const Icon(Icons.sync_alt, color: Colors.grey),
                  title: Text("methodology".tr),
                  subtitle: Text(
                    controller.project.methodologyType ?? 'not_available'.tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  tileColor: Theme.of(context).colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                const SizedBox(height: 20),
                BuildTextFiledCompany(
                  controller: controller.name,
                  label: "project_name".tr,
                  hint: "project_name_hint".tr,
                  icon: Icons.folder_special,
                  validator: (val) =>
                      val!.isEmpty ? "cannot_be_empty".tr : null,
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: controller.priority,
                  items: controller.priorityOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (val) {
                    controller.updatePriority(val);
                  },
                  decoration: InputDecoration(
                    labelText: "priority".tr,
                    prefixIcon: const Icon(Icons.flag_outlined),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                _buildDeadlinePicker(context, controller),
                const SizedBox(height: 20),
                BuildTextFiledCompany(
                  controller: controller.description,
                  label: "project_description".tr,
                  hint: "project_description_hint".tr,
                  icon: Icons.description_outlined,
                  maxLines: 5,
                ),
                const SizedBox(height: 30),
                CustomButtonAuth(
                  textbutton: "save_changes".tr,
                  onPressed: controller.saveProjectChanges,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeadlinePicker(
      BuildContext context, UpdateProjectController controller) {
    return TextFormField(
      controller: controller.deadlineController,
      readOnly: true,
      onTap: () async {
        DateTime initialDate =
            DateTime.tryParse(controller.deadlineController.text) ??
                DateTime.now();
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          String formattedDate =
              "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
          controller.deadlineController.text = formattedDate;
        }
      },
      decoration: InputDecoration(
        labelText: "deadline_optional".tr,
        hintText: "select_a_date".tr,
        prefixIcon: const Icon(Icons.calendar_today_outlined),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
