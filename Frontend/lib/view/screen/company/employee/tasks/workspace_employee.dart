import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/employee/tasks/workspaceemployee_controller.dart';
import 'package:companymanagment/core/class/handlingdataview.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/view/widget/company/employee/workspace/progressbaremployee.dart';
import 'package:companymanagment/view/widget/company/workspace/addsection.dart';
import 'package:companymanagment/view/widget/company/manager/taskattributes.dart';

class WorkspaceEmployee extends StatelessWidget {
  const WorkspaceEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WorkspaceEmployeeController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "256".tr, // Workspace
          style: TextStyle(fontSize: context.scaleConfig.scaleText(20)),
        ),
      ),
      body: GetBuilder<WorkspaceEmployeeController>(
        builder: (controller) => Handlingdataview(
          statusRequest: controller.statusRequest,
          widget: ListView.builder(
            padding: EdgeInsets.all(context.scaleConfig.scale(10)),
            itemCount: (controller.taskcompany.length) + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const ProgressBarEmployeeWidget();
              }
              if (index == 1) {
                return AdSection(
                  title: "257".tr, // Sponsored Ad
                  description: "258"
                      .tr, // Check out this amazing offer! Limited time only.
                  onAdClick: () => print('Ad clicked!'),
                );
              }

              final task = controller.taskcompany[index - 2];
              return InkWell(
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      final theme = Theme.of(context);
                      return Dialog(
                        backgroundColor: theme.colorScheme.surface,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                context.scaleConfig.scale(12))),
                        elevation: context.scaleConfig.scale(8),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.scaleConfig.scale(16),
                              vertical: context.scaleConfig.scale(20)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "351".tr, // Change Task Status
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                  fontSize: context.scaleConfig.scaleText(18),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: context.scaleConfig.scale(16)),
                              Column(
                                children: controller.taskStatuses.map((status) {
                                  Color color;
                                  IconData icon;
                                  String translatedStatus;
                                  switch (status) {
                                    case TaskStatus.completed:
                                      color = Colors.green;
                                      icon = Icons.check_circle;
                                      translatedStatus = "151".tr; // Completed
                                      break;
                                    case TaskStatus.inProgress:
                                      color = Colors.blue;
                                      icon = Icons.work;
                                      translatedStatus =
                                          "150".tr; // In Progress
                                      break;
                                    case TaskStatus.pending:
                                      color = const Color.fromARGB(
                                          156, 255, 235, 59);
                                      icon = Icons.watch_outlined;
                                      translatedStatus = "149".tr; // Pending
                                      break;
                                    case TaskStatus.acknowledged:
                                      color = Colors.orange;
                                      icon = Icons.task_alt;
                                      translatedStatus =
                                          "88".tr; // Acknowledged
                                      break;
                                    case TaskStatus.notAcknowledged:
                                      color = Colors.grey;
                                      icon = Icons.cancel;
                                      translatedStatus =
                                          "91".tr; // Not Acknowledged
                                      break;
                                  }
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: context.scaleConfig.scale(5)),
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: color,
                                        foregroundColor: Colors.white,
                                        minimumSize: Size(double.infinity,
                                            context.scaleConfig.scale(48)),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                context.scaleConfig.scale(8))),
                                      ),
                                      icon: Icon(icon,
                                          size: context.scaleConfig.scale(24)),
                                      label: Text(
                                        translatedStatus,
                                        style: TextStyle(
                                            fontSize: context.scaleConfig
                                                .scaleText(16)),
                                      ),
                                      onPressed: () {
                                        controller.insertUpdateTaskStatus(
                                            task.id!, status.value, task.title);
                                        Get.back();
                                      },
                                    ),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: context.scaleConfig.scale(16)),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                onTap: () => controller.goToDetailsTask(task),
                child: TaskCompanyAttributes(task: task),
              );
            },
          ),
        ),
      ),
    );
  }
}
