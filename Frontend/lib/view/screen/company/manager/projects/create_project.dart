import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/projects/create_project_controller.dart';
import 'package:companymanagment/core/class/handlingdataview.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_button_auth.dart';
import 'package:companymanagment/view/widget/company/manager/company/shared/build_text_filed_company.dart';

class CreateProjectPage extends StatelessWidget {
  const CreateProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateProjectController());

    return Scaffold(
      appBar: AppBar(title: Text("create_new_project".tr)),
      body: GetBuilder<CreateProjectController>(
        builder: (controller) => Handlingdataview(
          statusRequest: controller.statusRequest,
          widget: Form(
            key: controller.formState,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                BuildTextFiledCompany(
                  controller: controller.name,
                  label: "project_name".tr,
                  hint: "project_name_hint".tr,
                  icon: Icons.folder_special,
                  validator: (val) =>
                      val!.isEmpty ? "cannot_be_empty".tr : null,
                ),
                const SizedBox(height: 20),
                BuildTextFiledCompany(
                  controller: controller.budget,
                  label: "project_budget".tr,
                  hint: "enter_budget_amount".tr,
                  icon: Icons.attach_money,
                  // You can add a validator for numbers if you wish
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: controller.methodologyType,
                  items: controller.methodologyOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (val) {
                    controller.updateMethodology(val);
                  },
                  decoration: InputDecoration(
                    labelText: "project_methodology".tr,
                    prefixIcon: const Icon(Icons.sync_alt),
                    border: const OutlineInputBorder(),
                  ),
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
                  textbutton: "create_project".tr,
                  onPressed: () {
                    controller.addProject();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeadlinePicker(
      BuildContext context, CreateProjectController controller) {
    final TextEditingController dateController =
        TextEditingController(text: controller.deadline);
    return TextFormField(
      controller: dateController,
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          String formattedDate =
              "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
          dateController.text = formattedDate;
          controller.updateDeadline(formattedDate);
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
