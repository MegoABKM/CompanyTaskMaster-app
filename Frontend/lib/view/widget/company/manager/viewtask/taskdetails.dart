import 'package:flutter/material.dart';
import 'package:get/get.dart';
// REMOVE THE CONTROLLER IMPORT
// import 'package:companymanagment/controller/company/manager/tasks/viewtask_controller.dart';
import 'package:companymanagment/core/constant/utils/scale_confige.dart';
import 'package:companymanagment/core/functions/formatdate.dart';
// ADD THE MODEL IMPORT
import 'package:companymanagment/data/model/company/tasks/taskcompanymodel.dart';

// REMOVE 'GetView<ViewTaskCompanyManagerController>'
class TaskDetails extends StatelessWidget {
  final ThemeData theme;
  // ADD a required 'task' parameter
  final TaskCompanyModel task;

  const TaskDetails({
    super.key,
    required this.theme,
    required this.task, // Make it required
  });

  @override
  Widget build(BuildContext context) {
    final scaleConfig = ScaleConfig(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "265".tr, // Details
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: scaleConfig.scaleText(20),
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        // USE the 'task' object passed to the widget
        _buildRow("320".tr, formatDate(task.createdOn), context),
        _buildRow("321".tr, formatDate(task.dueDate), context),
        _buildRow("322".tr, task.priority ?? 'N/A', context, isPriority: true),
        _buildRow("323".tr, task.status ?? 'N/A', context),
        _buildRow("324".tr, formatDate(task.lastUpdated), context),
      ],
    );
  }

  // _buildRow and _getPriorityStyle methods remain exactly the same.
  Widget _buildRow(String label, String value, BuildContext context,
      {bool isPriority = false}) {
    final scaleConfig = ScaleConfig(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: scaleConfig.scale(8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle,
              size: scaleConfig.scale(10),
              color: theme.colorScheme.primary.withOpacity(0.6)),
          SizedBox(width: scaleConfig.scale(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: scaleConfig.scaleText(14),
                        color: Colors.grey[700])),
                SizedBox(height: scaleConfig.scale(2)),
                Text(
                  value,
                  style: isPriority
                      ? _getPriorityStyle(value, theme, scaleConfig)
                      : theme.textTheme.bodyLarge?.copyWith(
                          fontSize: scaleConfig.scaleText(16),
                          fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _getPriorityStyle(
      String priority, ThemeData theme, ScaleConfig scaleConfig) {
    final style = theme.textTheme.bodyLarge!.copyWith(
        fontSize: scaleConfig.scaleText(16), fontWeight: FontWeight.w600);
    switch (priority.toLowerCase()) {
      case "high":
      case "critical":
        return style.copyWith(color: Colors.red.shade600);
      case "medium":
        return style.copyWith(color: Colors.orange.shade700);
      case "low":
        return style.copyWith(color: Colors.green.shade600);
      default:
        return style;
    }
  }
}
