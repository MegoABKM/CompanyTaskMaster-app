import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/homemanager/notificationmanager_controller.dart';
import 'package:companymanagment/core/class/handlingdataview.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class NotificationManager extends StatelessWidget {
  const NotificationManager({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationManagerController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '237'.tr, // Task Status Notifications
          style: TextStyle(fontSize: context.scaleConfig.scaleText(20)),
        ),
      ),
      body: GetBuilder<NotificationManagerController>(
        builder: (controller) => Handlingdataview(
          statusRequest: controller.statusRequest,
          widget: ListView.builder(
            itemCount: controller.taskStatusModel.length,
            itemBuilder: (context, index) {
              final task = controller.taskStatusModel[index];
              final status = task.checktaskStatus ?? 'N/A';
              Color statusColor;
              IconData statusIcon;
              String statusText;
              switch (status) {
                case 'Pending':
                  statusColor = Colors.yellow;
                  statusIcon = Icons.watch_later_outlined;
                  statusText = '243'.tr; // Pending
                  break;
                case 'Acknowledged':
                  statusColor = Colors.orange;
                  statusIcon = Icons.task_alt;
                  statusText = '244'.tr; // Acknowledged
                  break;
                case 'In Progress':
                  statusColor = Colors.blue;
                  statusIcon = Icons.work_outline;
                  statusText = '245'.tr; // In Progress
                  break;
                case 'Completed':
                  statusColor = Colors.green;
                  statusIcon = Icons.check_circle;
                  statusText = '246'.tr; // Completed
                  break;
                case 'Not Acknowledged':
                  statusColor = Colors.red;
                  statusIcon = Icons.cancel;
                  statusText = '247'.tr; // Not Acknowledged
                  break;
                default:
                  statusColor = Colors.grey;
                  statusIcon = Icons.error;
                  statusText = 'N/A';
              }
              return Card(
                margin: EdgeInsets.symmetric(
                  vertical: context.scaleConfig.scale(8),
                  horizontal: context.scaleConfig.scale(16),
                ),
                elevation: context.scaleConfig.scale(4),
                child: ListTile(
                  contentPadding: EdgeInsets.all(context.scaleConfig.scale(16)),
                  title: Text(
                    task.taskName ?? 'N/A',
                    style:
                        TextStyle(fontSize: context.scaleConfig.scaleText(16)),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '238'.tr +
                            ' ${task.employeeName ?? 'N/A'}', // Employee:
                        style: TextStyle(
                            fontSize: context.scaleConfig.scaleText(14)),
                      ),
                      Text(
                        '239'.tr +
                            ' ${task.employeeEmail ?? 'N/A'}', // Employee Email:
                        style: TextStyle(
                            fontSize: context.scaleConfig.scaleText(14)),
                      ),
                      Text(
                        '240'.tr + ' $statusText', // Status:
                        style: TextStyle(
                            fontSize: context.scaleConfig.scaleText(14)),
                      ),
                      Text(
                        '241'.tr + ' ${task.companyName ?? 'N/A'}', // Company:
                        style: TextStyle(
                            fontSize: context.scaleConfig.scaleText(14)),
                      ),
                      Text(
                        '242'.tr +
                            ' ${task.checktaskDate ?? 'N/A'}', // Task Check Date:
                        style: TextStyle(
                            fontSize: context.scaleConfig.scaleText(14)),
                      ),
                    ],
                  ),
                  trailing: Container(
                    padding: EdgeInsets.all(context.scaleConfig.scale(8)),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.2),
                      borderRadius:
                          BorderRadius.circular(context.scaleConfig.scale(8)),
                    ),
                    child: Icon(
                      statusIcon,
                      color: statusColor,
                      size: context.scaleConfig.scale(24),
                    ),
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
