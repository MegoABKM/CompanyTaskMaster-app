import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart'; // Added for .tr
import 'package:tasknotate/core/constant/utils/scale_confige.dart';
import 'package:tasknotate/data/model/company/tasks/taskcompanymodel.dart';

class TaskCompanyAttributes extends StatelessWidget {
  final TaskCompanyModel task;

  const TaskCompanyAttributes({
    required this.task,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scaleConfig = ScaleConfig(context); // Assuming available globally
    return Card(
      elevation: scaleConfig.scale(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(scaleConfig.scale(12)),
      ),
      child: Padding(
        padding: EdgeInsets.all(scaleConfig.scale(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleRow(context),
            SizedBox(height: scaleConfig.scale(8)),
            _buildInfoRow(context,
                icon: FontAwesomeIcons.clock,
                label: "305".tr + " ${task.dueDate ?? 'N/A'}"), // Due Date:
            SizedBox(height: scaleConfig.scale(4)),
            _buildInfoRow(context,
                icon: FontAwesomeIcons.fire,
                label: "306".tr + " ${task.priority ?? 'N/A'}"), // Priority:
            SizedBox(height: scaleConfig.scale(4)),
            _buildInfoRow(context,
                icon: Icons.update,
                label: "307".tr +
                    " ${task.lastUpdated ?? 'N/A'}"), // Last Updated:
            SizedBox(height: scaleConfig.scale(4)),
            _buildInfoRow(context,
                icon: FontAwesomeIcons.circleInfo, label: task.status ?? "N/A"),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleRow(BuildContext context) {
    final scaleConfig = ScaleConfig(context);
    return Row(
      children: [
        Text(
          "${task.id}.",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: scaleConfig.scaleText(20),
              ),
        ),
        SizedBox(width: scaleConfig.scale(8)),
        Expanded(
          child: Text(
            task.title ?? "N/A",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: scaleConfig.scaleText(20),
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context,
      {required IconData icon, required String label}) {
    final scaleConfig = ScaleConfig(context);
    return Row(
      children: [
        Icon(
          icon,
          size: scaleConfig.scale(16),
          color: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(width: scaleConfig.scale(8)),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: scaleConfig.scaleText(14),
                ),
          ),
        ),
      ],
    );
  }
}
