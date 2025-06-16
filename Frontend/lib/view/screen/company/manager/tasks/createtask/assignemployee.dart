import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/tasks/createtask/asignusertotask.dart';
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';

class AssignemployeeToTask extends StatelessWidget {
  const AssignemployeeToTask({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaleConfig = ScaleConfig(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "284".tr, // Assign Employees to Task
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: scaleConfig.scaleText(20),
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary,
        elevation: 0,
      ),
      body: GetBuilder<Asignusertotaskcontroller>(
        init: Asignusertotaskcontroller(),
        builder: (controller) {
          if (controller.employees.isEmpty) {
            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(scaleConfig.scale(16)),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(scaleConfig.scale(16)),
                  ),
                  elevation: scaleConfig.scale(4),
                  child: Padding(
                    padding: EdgeInsets.all(scaleConfig.scale(16)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_alt_outlined,
                          size: scaleConfig.scale(80),
                          color: theme.colorScheme.primary.withOpacity(0.7),
                        ),
                        SizedBox(height: scaleConfig.scale(16)),
                        Text(
                          "285".tr, // No employees available yet.
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontSize: scaleConfig.scaleText(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: scaleConfig.scale(20)),
                        ElevatedButton(
                          onPressed: controller.skipToSubtasks,
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
                          child: Text(
                            "286".tr, // Skip to Subtasks
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontSize: scaleConfig.scaleText(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(scaleConfig.scale(16)),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(scaleConfig.scale(16)),
              ),
              elevation: scaleConfig.scale(4),
              child: Padding(
                padding: EdgeInsets.all(scaleConfig.scale(16)),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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
                            contentPadding:
                                EdgeInsets.all(scaleConfig.scale(12)),
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
                              employee.employeeName ?? 'N/A',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: scaleConfig.scaleText(16),
                              ),
                            ),
                            subtitle: Text(
                              employee.employeeEmail ?? 'N/A',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.grey,
                                fontSize: scaleConfig.scaleText(14),
                              ),
                            ),
                            trailing: Checkbox(
                              value: controller.assignedEmployees
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
                    SizedBox(height: scaleConfig.scale(24)),
                    Padding(
                      padding: EdgeInsets.all(scaleConfig.scale(16)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: controller.skipToSubtasks,
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: scaleConfig.scale(20),
                                vertical: scaleConfig.scale(12),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    scaleConfig.scale(12)),
                              ),
                            ),
                            child: Text(
                              "287".tr, // Skip
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontSize: scaleConfig.scaleText(16),
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                          controller.statusRequest != StatusRequest.loading
                              ? ElevatedButton(
                                  onPressed: controller.insertData,
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: scaleConfig.scale(20),
                                      vertical: scaleConfig.scale(12),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          scaleConfig.scale(12)),
                                    ),
                                  ),
                                  child: Text(
                                    "288".tr, // Assign Employees
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      fontSize: scaleConfig.scaleText(16),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  width: scaleConfig.scale(24),
                                  height: scaleConfig.scale(24),
                                  child: CircularProgressIndicator(
                                    strokeWidth: scaleConfig.scale(2),
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
        },
      ),
    );
  }
}
