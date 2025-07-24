import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/homemanager/home_manager_controller.dart';
import 'package:companymanagment/core/class/handlingdataview.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class TaskCheckSection extends GetView<ManagerhomeController> {
  const TaskCheckSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.scaleConfig.scale(16)),
          child: Text(
            "85".tr,
            style: context.appTheme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.appTheme.colorScheme.primary,
              fontSize: context.scaleConfig.scaleText(20),
            ),
          ),
        ),
        SizedBox(height: context.scaleConfig.scale(12)),
        GetBuilder<ManagerhomeController>(
          builder: (controller) => Handlingdataview(
            statusRequest: controller.statusRequest,
            widget: controller.taskcheck.isEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.scaleConfig.scale(16)),
                    child: Center(
                      child: Text(
                        "86".tr,
                        style: context.appTheme.textTheme.bodyMedium?.copyWith(
                          color: context.appTheme.colorScheme.secondary,
                          fontSize: context.scaleConfig.scaleText(16),
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: context.scaleConfig.scale(140),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                          horizontal: context.scaleConfig.scale(16)),
                      itemCount: controller.taskcheck.length > 5
                          ? 5
                          : controller.taskcheck.length,
                      itemBuilder: (context, index) {
                        var task = controller.taskcheck[index];
                        // Define status color and icon based on task status
                        Color statusColor = Colors.grey;
                        IconData statusIcon = Icons.error;
                        if (task.checktaskStatus == "87".tr) {
                          statusColor = Colors.yellow;
                          statusIcon = Icons.watch_later_outlined;
                        } else if (task.checktaskStatus == "88".tr) {
                          statusColor = Colors.orange;
                          statusIcon = Icons.task_alt;
                        } else if (task.checktaskStatus == "89".tr) {
                          statusColor = Colors.blue;
                          statusIcon = Icons.work_outline;
                        } else if (task.checktaskStatus == "90".tr) {
                          statusColor = Colors.green;
                          statusIcon = Icons.check_circle;
                        } else if (task.checktaskStatus == "91".tr) {
                          statusColor = Colors.red;
                          statusIcon = Icons.cancel;
                        }

                        return Container(
                          width: context.scaleConfig.scale(220),
                          margin: EdgeInsets.only(
                              right: context.scaleConfig.scale(12)),
                          child: Card(
                            elevation: context.scaleConfig.scale(4),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    context.scaleConfig.scale(12))),
                            child: Padding(
                              padding:
                                  EdgeInsets.all(context.scaleConfig.scale(12)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task.taskName ?? "Unknown Task",
                                    style: context
                                        .appTheme.textTheme.titleMedium
                                        ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          context.scaleConfig.scaleText(16),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                      height: context.scaleConfig.scale(4)),
                                  Text(
                                    "By: ${task.employeeName ?? 'Unknown'}",
                                    style: context.appTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: Colors.grey.shade600,
                                      fontSize:
                                          context.scaleConfig.scaleText(12),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                      height: context.scaleConfig.scale(4)),
                                  Row(
                                    children: [
                                      Icon(statusIcon,
                                          size: context.scaleConfig.scale(16),
                                          color: statusColor),
                                      SizedBox(
                                          width: context.scaleConfig.scale(4)),
                                      Expanded(
                                        child: Text(
                                          task.checktaskStatus ?? "N/A",
                                          style: context
                                              .appTheme.textTheme.bodySmall
                                              ?.copyWith(
                                            color: statusColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: context.scaleConfig
                                                .scaleText(12),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                    controller.formatDate(task.checktaskDate),
                                    style: context.appTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: Colors.grey,
                                      fontSize:
                                          context.scaleConfig.scaleText(12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
