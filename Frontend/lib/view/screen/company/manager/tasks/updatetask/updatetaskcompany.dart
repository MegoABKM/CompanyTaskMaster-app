import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/tasks/updatetask/updatetask_controller.dart';
import 'package:companymanagment/core/class/handlingdataview.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_button_auth.dart';
import 'package:companymanagment/view/widget/company/manager/company/shared/build_text_filed_company.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:companymanagment/data/model/company/tasks/attachmentmodel.dart';
import 'package:companymanagment/core/functions/formatdate.dart';
import 'package:companymanagment/view/widget/company/manager/home/empty_state_widget.dart';

class Updatetaskcompany extends StatelessWidget {
  const Updatetaskcompany({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UpdatetaskCompanyController());

    return GetBuilder<UpdatetaskCompanyController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('edit_task'.tr),
            leading: IconButton(
              icon: const Icon(Icons.check_circle_outline),
              tooltip: 'finish_editing'.tr,
              onPressed: controller.finishEditing,
            ),
            bottom: TabBar(
              controller: controller.tabController,
              isScrollable: true,
              tabs: [
                Tab(
                    icon: const Icon(Icons.details_outlined),
                    text: 'details'.tr),
                Tab(
                    icon: const Icon(Icons.group_outlined),
                    text: 'assignments'.tr),
                Tab(icon: const Icon(Icons.list_alt), text: 'subtasks'.tr),
                Tab(
                    icon: const Icon(Icons.attach_file_outlined),
                    text: 'attachments'.tr),
              ],
            ),
          ),
          body: TabBarView(
            controller: controller.tabController,
            children: [
              _buildDetailsTab(context, controller),
              _buildAssignmentsTab(context, controller),
              _buildSubtasksTab(context, controller),
              _buildAttachmentsTab(context, controller),
            ],
          ).animate().fade(duration: 200.ms),
        );
      },
    );
  }

  // --- Tab 1: Details ---
  Widget _buildDetailsTab(
      BuildContext context, UpdatetaskCompanyController controller) {
    final scale = context.scaleConfig;
    return GetBuilder<UpdatetaskCompanyController>(
      id: 'details',
      builder: (c) => Handlingdataview(
        statusRequest: c.statusRequest,
        widget: ListView(
          padding: EdgeInsets.all(scale.scale(16)),
          children: [
            BuildTextFiledCompany(
                controller: c.titleController,
                label: "task_title".tr,
                hint: "enter_task_title".tr,
                icon: Icons.title),
            SizedBox(height: scale.scale(16)),
            DropdownButtonFormField<String>(
              value: c.priority,
              items: c.priorityOptions
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: c.updatePriority,
              decoration: InputDecoration(
                  labelText: "priority".tr,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.flag_outlined)),
            ),
            SizedBox(height: scale.scale(16)),
            DropdownButtonFormField<String>(
              value: c.status,
              items: c.statusOptions
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: c.updateStatus,
              decoration: InputDecoration(
                  labelText: "status".tr,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.task_alt_outlined)),
            ),
            SizedBox(height: scale.scale(16)),
            TextFormField(
              controller: c.startDateController, // Use controller from onInit
              readOnly: true,
              decoration: InputDecoration(
                  labelText: "start_date".tr,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.calendar_today)),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate:
                        DateTime.tryParse(c.startDateController.text) ??
                            DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2101));
                if (pickedDate != null) {
                  c.startDateController.text =
                      "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                }
              },
            ),
            SizedBox(height: scale.scale(16)),
            TextFormField(
              controller: c.dueDateController,
              readOnly: true,
              decoration: InputDecoration(
                  labelText: "due_date".tr,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.calendar_today)),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.tryParse(c.dueDateController.text) ??
                      DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  c.dueDateController.text =
                      "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                }
              },
            ),
            SizedBox(height: scale.scale(16)),
            BuildTextFiledCompany(
                controller: c.descriptionController,
                label: "description".tr,
                hint: "add_task_description".tr,
                maxLines: 5),
            SizedBox(height: scale.scale(24)),
            CustomButtonAuth(
                textbutton: "save_details".tr, onPressed: c.saveDetailsChanges),
          ],
        ),
      ),
    );
  }

  // --- Tab 2: Assignments ---
  Widget _buildAssignmentsTab(
      BuildContext context, UpdatetaskCompanyController controller) {
    return GetBuilder<UpdatetaskCompanyController>(
      id: 'assignments',
      builder: (c) => Handlingdataview(
        statusRequest: c.statusRequest,
        widget: Column(
          children: [
            Expanded(
              child: c.companyemployee.isEmpty
                  ? EmptyStateWidget(
                      icon: Icons.group_off_outlined,
                      message: "no_employees_in_company".tr)
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: c.companyemployee.length,
                      itemBuilder: (context, index) {
                        final Employees employee = c.companyemployee[index];
                        final bool isAssigned = c.assignedEmployees
                            .any((e) => e.employeeId == employee.employeeId);
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: CheckboxListTile(
                            title: Text(employee.employeeName ?? "no_name".tr),
                            subtitle:
                                Text(employee.employeeEmail ?? "no_email".tr),
                            value: isAssigned,
                            onChanged: (bool? selected) {
                              c.toggleEmployeeAssignment(employee);
                            },
                            secondary: CircleAvatar(
                                child: Text(
                                    employee.employeeName?.substring(0, 1) ??
                                        "?")),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomButtonAuth(
                  textbutton: "save_assignments".tr,
                  onPressed: c.saveAssignmentChanges),
            ),
          ],
        ),
      ),
    );
  }

  // --- Tab 3: Subtasks ---
  Widget _buildSubtasksTab(
      BuildContext context, UpdatetaskCompanyController controller) {
    final scale = context.scaleConfig;
    return GetBuilder<UpdatetaskCompanyController>(
      id: 'subtasks',
      builder: (c) => Handlingdataview(
        statusRequest: c.statusRequest,
        widget: Column(
          children: [
            Expanded(
              child: c.subtasks.isEmpty
                  ? EmptyStateWidget(
                      icon: Icons.list_alt_rounded,
                      message: "no_subtasks".tr,
                      details: "add_subtask_details".tr,
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(scale.scale(8)),
                      itemCount: c.subtasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin:
                              EdgeInsets.symmetric(vertical: scale.scale(6)),
                          elevation: 2,
                          child: Padding(
                            padding: EdgeInsets.all(scale.scale(8)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller:
                                            c.subtaskTitleControllers[index],
                                        decoration: InputDecoration(
                                            labelText: 'subtask_title'.tr,
                                            border: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 8)),
                                      ),
                                      const Divider(),
                                      TextFormField(
                                        controller:
                                            c.subtaskDescControllers[index],
                                        decoration: InputDecoration(
                                            labelText: 'subtask_description'.tr,
                                            border: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 8)),
                                        maxLines: null,
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline,
                                      color: Colors.red),
                                  onPressed: () => c.removeSubtask(index),
                                  tooltip: 'remove_subtask_tooltip'.tr,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: EdgeInsets.all(scale.scale(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                      onPressed: c.addSubtask,
                      icon: const Icon(Icons.add),
                      label: Text('add_subtask'.tr)),
                  ElevatedButton(
                      onPressed: c.saveSubtaskChanges,
                      child: Text('save_subtasks'.tr)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Tab 4: Attachments ---
  Widget _buildAttachmentsTab(
      BuildContext context, UpdatetaskCompanyController controller) {
    return GetBuilder<UpdatetaskCompanyController>(
      id: 'attachments',
      builder: (c) => Handlingdataview(
        statusRequest: c.statusRequest,
        widget: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomButtonAuth(
                  textbutton: "upload_new_file".tr,
                  onPressed: c.pickAndUploadFile),
            ),
            Expanded(
              child: c.attachments.isEmpty
                  ? EmptyStateWidget(
                      icon: Icons.attach_file_outlined,
                      message: "no_attachments".tr,
                      details: "upload_files_for_task".tr)
                  : ListView.builder(
                      itemCount: c.attachments.length,
                      itemBuilder: (context, index) {
                        final AttachmentModel attachment = c.attachments[index];
                        return ListTile(
                          leading: const Icon(Icons.attach_file),
                          title: Text(attachment.filename),
                          subtitle: Text(formatDate(attachment.uploadedAt)),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => c.deleteAttachment(attachment),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
