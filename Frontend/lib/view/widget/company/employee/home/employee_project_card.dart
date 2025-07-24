import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/data/model/company/project_model.dart';
import 'package:companymanagment/core/functions/formatdate.dart';

class EmployeeProjectCard extends StatelessWidget {
  final ProjectModel project;
  final VoidCallback onTap;

  const EmployeeProjectCard({
    super.key,
    required this.project,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.projectName ?? 'untitled_project'.tr,
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                // This will now work correctly
                "${'company_prefix'.tr}: ${project.companyName ?? 'N/A'}",
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: Colors.grey[600]),
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStat(context, theme, Icons.task_alt,
                      "${project.taskCount ?? 0} ${'tasks_suffix'.tr}"),
                  _buildStat(context, theme, Icons.people_alt_outlined,
                      "${project.memberCount ?? 0} ${'members_suffix'.tr}"),
                ],
              ),
              if (project.deadline != null && project.deadline!.isNotEmpty) ...[
                const SizedBox(height: 12),
                _buildStat(context, theme, Icons.calendar_today_outlined,
                    "${'deadline_prefix'.tr}: ${formatDate(project.deadline)}",
                    color: theme.colorScheme.error),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(
      BuildContext context, ThemeData theme, IconData icon, String text,
      {Color? color}) {
    final scale = context.scaleConfig;
    return Row(
      children: [
        Icon(icon,
            size: scale.scale(16), color: color ?? theme.colorScheme.primary),
        SizedBox(width: scale.scale(6)),
        Text(
          text,
          style: theme.textTheme.bodyMedium?.copyWith(
              color: color ?? theme.colorScheme.onSurface,
              fontSize: scale.scaleText(14)),
        ),
      ],
    );
  }
}
