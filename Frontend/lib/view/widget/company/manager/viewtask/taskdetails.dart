import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/tasks/viewtask_controller.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart'; // Added for scaleConfig

class TaskDetails extends GetView<ViewTaskCompanyManagerController> {
  final ThemeData theme;

  const TaskDetails({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    final scaleConfig = ScaleConfig(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context, scaleConfig),
        SizedBox(height: scaleConfig.scale(16)),
        _buildRow(
            "320".tr, // Created On:
            _formatDate(controller.taskcompanydetail!.createdOn),
            context),
        _buildRow(
            "321".tr, // Due Date:
            _formatDate(controller.taskcompanydetail!.dueDate),
            context),
        _buildRow(
            "322".tr, // Priority:
            controller.taskcompanydetail!.priority!,
            context,
            isPriority: true),
        _buildRow(
            "323".tr, // Status:
            controller.taskcompanydetail!.status!,
            context),
        _buildRow(
            "324".tr, // Last Updated:
            _formatDate(controller.taskcompanydetail!.lastUpdated),
            context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, ScaleConfig scaleConfig) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "126".tr, // Task Details
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: scaleConfig.scaleText(20),
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        TextButton(
          onPressed: () => controller.goToUpdatetask("edit"),
          child: Text(
            "309".tr, // Edit
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: scaleConfig.scaleText(16),
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
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
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  value,
                  style: isPriority
                      ? _getPriorityStyle(value, theme, scaleConfig)
                      : theme.textTheme.bodyLarge?.copyWith(
                          fontSize: scaleConfig.scaleText(16),
                          color: Colors.black87,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? date) {
    if (date == null || date.isEmpty) return "328".tr; // No date provided
    try {
      final parsedDate = DateTime.parse(date.trim());
      return "${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}";
    } catch (e) {
      return "329".tr; // Invalid date
    }
  }

  TextStyle _getPriorityStyle(
      String priority, ThemeData theme, ScaleConfig scaleConfig) {
    switch (priority.toLowerCase()) {
      case "high":
        return theme.textTheme.bodyLarge!.copyWith(
          fontSize: scaleConfig.scaleText(16),
          color: Colors.red,
          fontWeight: FontWeight.bold,
        );
      case "medium":
        return theme.textTheme.bodyLarge!.copyWith(
          fontSize: scaleConfig.scaleText(16),
          color: Colors.orange,
          fontWeight: FontWeight.bold,
        );
      case "low":
        return theme.textTheme.bodyLarge!.copyWith(
          fontSize: scaleConfig.scaleText(16),
          color: Colors.green,
          fontWeight: FontWeight.bold,
        );
      default:
        return theme.textTheme.bodyLarge!.copyWith(
          fontSize: scaleConfig.scaleText(16),
        );
    }
  }
}
