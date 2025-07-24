import 'package:companymanagment/controller/company/manager/projects/assign_project_memebers_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/class/handlingdataview.dart';
import 'package:companymanagment/view/widget/company/manager/home/empty_state_widget.dart';

class AssignProjectMembersPage extends StatelessWidget {
  const AssignProjectMembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AssignProjectMembersController());

    return Scaffold(
      appBar: AppBar(
        title: Text('assign_members'.tr),
        actions: [
          GetBuilder<AssignProjectMembersController>(
            builder: (controller) => TextButton(
              onPressed: controller.saveAssignments,
              child: Text("save".tr.toUpperCase()),
            ),
          ),
        ],
      ),
      body: GetBuilder<AssignProjectMembersController>(
        builder: (controller) => Handlingdataview(
          statusRequest: controller.statusRequest,
          widget: controller.allCompanyEmployees.isEmpty
              ? EmptyStateWidget(
                  icon: Icons.people_outline,
                  message: 'no_employees_in_company'.tr,
                  details: 'add_employees_first'.tr,
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: controller.allCompanyEmployees.length,
                  itemBuilder: (context, index) {
                    final employee = controller.allCompanyEmployees[index];
                    final bool isSelected = controller.selectedEmployees
                        .any((e) => e.employeeId == employee.employeeId);

                    return Card(
                      child: CheckboxListTile(
                        title: Text(employee.employeeName ?? 'no_name'.tr),
                        subtitle: Text(employee.employeeEmail ?? 'no_email'.tr),
                        value: isSelected,
                        onChanged: (bool? value) {
                          controller.toggleEmployeeSelection(employee);
                        },
                        secondary: CircleAvatar(
                          child: Text(
                              employee.employeeName?.substring(0, 1) ?? "?"),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
