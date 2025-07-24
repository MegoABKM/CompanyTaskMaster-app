import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/constant/utils/scale_confige.dart';
import 'package:companymanagment/data/model/company/tasks/taskcompanymodel.dart';

class TaskCompanyAttributes extends StatelessWidget {
  final TaskCompanyModel task;
  final VoidCallback? onTap; // NEW: Add an optional onTap callback

  const TaskCompanyAttributes({
    required this.task,
    this.onTap, // NEW: Add to constructor
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scaleConfig = ScaleConfig(context);

    // The InkWell now uses the provided onTap callback
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: scaleConfig.scale(5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(scaleConfig.scale(12)),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Padding(
          padding: EdgeInsets.all(scaleConfig.scale(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleRow(context),
              SizedBox(height: scaleConfig.scale(8)),
              _buildInfoRow(context,
                  icon: FontAwesomeIcons.clock,
                  label: "${"305".tr} ${task.dueDate ?? 'N/A'}"),
              SizedBox(height: scaleConfig.scale(4)),
              _buildInfoRow(context,
                  icon: FontAwesomeIcons.fire,
                  label: "${"306".tr} ${task.priority ?? 'N/A'}"),
              SizedBox(height: scaleConfig.scale(4)),
              _buildInfoRow(context,
                  icon: Icons.update,
                  label: "${"307".tr} ${task.lastUpdated ?? 'N/A'}"),
              SizedBox(height: scaleConfig.scale(4)),
              _buildInfoRow(context,
                  icon: FontAwesomeIcons.circleInfo,
                  label: task.status ?? "N/A"),
            ],
          ),
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
