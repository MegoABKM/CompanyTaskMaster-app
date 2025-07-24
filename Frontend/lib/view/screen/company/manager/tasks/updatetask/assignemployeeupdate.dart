import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/tasks/updatetask/assignuserupdatetotask.dart';
import 'package:companymanagment/core/class/handlingdataview.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/constant/utils/scale_confige.dart';

class AssignemployeeUpdateToTask extends StatelessWidget {
  const AssignemployeeUpdateToTask({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaleConfig = ScaleConfig(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "315".tr, // Update Assign Employees to Task
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: scaleConfig.scaleText(20),
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary,
        elevation: 0,
      ),
      body: GetBuilder<AsignuserUpdatetotaskcontroller>(
        init: AsignuserUpdatetotaskcontroller(),
        builder: (controller) => Handlingdataview(
          statusRequest: controller.statusRequest,
          widget: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(scaleConfig.scale(16)),
                  child: ListView.builder(
                    itemCount: controller.employees.length,
                    itemBuilder: (context, index) {
                      final employee = controller.employees[index];
                      return Card(
                        margin: EdgeInsets.symmetric(
                          vertical: scaleConfig.scale(8),
                        ),
                        elevation: scaleConfig.scale(2),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(scaleConfig.scale(12)),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(scaleConfig.scale(12)),
                          leading: CircleAvatar(
                            backgroundColor:
                                theme.colorScheme.primary.withOpacity(0.1),
                            child: Text(
                              employee.employeeName?[0].toUpperCase() ?? 'N',
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            employee.employeeName ?? '318'.tr, // N/A
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: scaleConfig.scaleText(16),
                            ),
                          ),
                          subtitle: Text(
                            employee.employeeEmail ?? '318'.tr, // N/A
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey,
                              fontSize: scaleConfig.scaleText(14),
                            ),
                          ),
                          trailing: Checkbox(
                            value: controller.newAssignedEmployees
                                .contains(employee),
                            activeColor: theme.colorScheme.primary,
                            onChanged: (bool? selected) {
                              if (selected == true) {
                                controller.assignEmployee(employee);
                              } else {
                                controller.removeEmployee(employee);
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(scaleConfig.scale(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed:
                          controller.statusRequest == StatusRequest.loading
                              ? null
                              : controller.goToSubTask,
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: scaleConfig.scale(20),
                          vertical: scaleConfig.scale(12),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(scaleConfig.scale(12)),
                        ),
                      ),
                      child: controller.statusRequest == StatusRequest.loading
                          ? SizedBox(
                              width: scaleConfig.scale(24),
                              height: scaleConfig.scale(24),
                              child: CircularProgressIndicator(
                                strokeWidth: scaleConfig.scale(2),
                              ),
                            )
                          : Text(
                              "287".tr, // Skip
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontSize: scaleConfig.scaleText(16),
                                color: theme.colorScheme.primary,
                              ),
                            ),
                    ),
                    ElevatedButton(
                      onPressed:
                          controller.statusRequest == StatusRequest.loading
                              ? null
                              : controller.updatedata,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: scaleConfig.scale(20),
                          vertical: scaleConfig.scale(12),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(scaleConfig.scale(12)),
                        ),
                      ),
                      child: controller.statusRequest == StatusRequest.loading
                          ? SizedBox(
                              width: scaleConfig.scale(24),
                              height: scaleConfig.scale(24),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: scaleConfig.scale(2),
                              ),
                            )
                          : Text(
                              "288".tr, // Assign Employees
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontSize: scaleConfig.scaleText(16),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
