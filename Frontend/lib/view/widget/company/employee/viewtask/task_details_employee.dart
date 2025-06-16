import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/core/functions/formatdate.dart';
import 'package:tasknotate/data/model/company/tasks/newtasksmodel.dart';
import 'package:tasknotate/data/model/company/tasks/taskcompanymodel.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';

class TaskDetailsEmployee extends StatelessWidget {
  final ThemeData theme;
  final dynamic task;

  const TaskDetailsEmployee(
      {super.key, required this.theme, required this.task});

  @override
  Widget build(BuildContext context) {
    String title = "173".tr; // No title
    String createdOn = "328".tr; // No date provided
    String dueDate = "328".tr; // No date provided
    String priority = "129".tr; // No priority
    String status = "136".tr; // No status
    String lastUpdated = "328".tr; // No date provided

    if (task is Newtasks) {
      Newtasks newtask = task;
      title = newtask.taskTitle ?? "173".tr;
      createdOn = newtask.taskCreatedOn ?? "328".tr;
      dueDate = newtask.taskDueDate ?? "328".tr;
      priority = newtask.taskPriority ?? "129".tr;
      status = newtask.taskStatus ?? "136".tr;
      lastUpdated = newtask.taskUpdatedDate ?? "328".tr;
    } else if (task is TaskCompanyModel) {
      TaskCompanyModel taskcompany = task;
      title = taskcompany.title ?? "173".tr;
      createdOn = taskcompany.createdOn ?? "328".tr;
      dueDate = taskcompany.dueDate ?? "328".tr;
      priority = taskcompany.priority ?? "129".tr;
      status = taskcompany.status ?? "136".tr;
      lastUpdated = taskcompany.lastUpdated ?? "328".tr;
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.scaleConfig.scale(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: context.scaleConfig.scaleText(20),
              fontWeight: FontWeight.bold,
              color: Colors.black87, // Match manager's title color
            ),
          ),
          SizedBox(height: context.scaleConfig.scale(16)),
          _buildRow("320".tr, formatDate(createdOn), context), // Created On:
          _buildRow("321".tr, formatDate(dueDate), context), // Due Date:
          _buildRow("322".tr, priority, context, isPriority: true), // Priority:
          _buildRow("323".tr, status, context), // Status:
          _buildRow(
              "324".tr, formatDate(lastUpdated), context), // Last Updated:
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, BuildContext context,
      {bool isPriority = false}) {
    final scaleConfig = ScaleConfig(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: scaleConfig.scale(8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.circle,
            size: scaleConfig.scale(10),
            color: theme.colorScheme.primary,
          ),
          SizedBox(width: scaleConfig.scale(8)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: scaleConfig.scaleText(14),
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700], // Match manager's label color
                  ),
                ),
                Text(
                  value,
                  style: isPriority
                      ? _getPriorityStyle(value, scaleConfig)
                      : theme.textTheme.bodyLarge?.copyWith(
                          fontSize: scaleConfig.scaleText(16),
                          color: Colors.black87, // Match manager's value color
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _getPriorityStyle(String priority, ScaleConfig scaleConfig) {
    switch (priority.toLowerCase()) {
      case "148": // high (Arabic: عالي)
      case "high":
        return theme.textTheme.bodyLarge!.copyWith(
          fontSize: scaleConfig.scaleText(16),
          color: Colors.red, // Match manager's priority color
          fontWeight: FontWeight.bold,
        );
      case "147": // medium (Arabic: متوسط)
      case "medium":
        return theme.textTheme.bodyLarge!.copyWith(
          fontSize: scaleConfig.scaleText(16),
          color: Colors.orange, // Match manager's priority color
          fontWeight: FontWeight.bold,
        );
      case "146": // low (Arabic: منخفض)
      case "low":
        return theme.textTheme.bodyLarge!.copyWith(
          fontSize: scaleConfig.scaleText(16),
          color: Colors.green, // Match manager's priority color
          fontWeight: FontWeight.bold,
        );
      default:
        return theme.textTheme.bodyLarge!.copyWith(
          fontSize: scaleConfig.scaleText(16),
          color: Colors.black87,
        );
    }
  }
}
