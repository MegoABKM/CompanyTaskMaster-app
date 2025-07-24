import 'package:companymanagment/data/model/company/project_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/core/functions/formatdate.dart';
import 'package:companymanagment/view/screen/company/manager/projects/project_workspace_page.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  const ProjectCard({super.key, required this.project});

  Color _getPriorityColor(String? priority) {
    switch (priority?.toLowerCase()) {
      case 'critical':
        return Colors.red;
      case 'high':
        return Colors.orange;
      case 'medium':
        return Colors.blue;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scale = context.scaleConfig;
    final priorityColor = _getPriorityColor(project.priority);

    return Card(
      margin: EdgeInsets.only(bottom: scale.scale(16)),
      elevation: 3,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: priorityColor, width: 1.5),
        borderRadius: BorderRadius.circular(scale.scale(12)),
      ),
      child: InkWell(
        onTap: () => Get.to(() => const ProjectWorkspacePage(),
            arguments: {'project': project}),
        borderRadius: BorderRadius.circular(scale.scale(12)),
        child: Padding(
          padding: EdgeInsets.all(scale.scale(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      project.projectName ?? 'untitled_project'.tr,
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontSize: scale.scaleText(18)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: scale.scale(10), vertical: scale.scale(4)),
                    decoration: BoxDecoration(
                      color: priorityColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(scale.scale(20)),
                    ),
                    child: Text(
                      project.priority ?? 'not_available'.tr,
                      style: theme.textTheme.labelSmall?.copyWith(
                          color: priorityColor,
                          fontWeight: FontWeight.bold,
                          fontSize: scale.scaleText(12)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: scale.scale(8)),
              if (project.deadline != null)
                Row(
                  children: [
                    Icon(Icons.calendar_month_outlined,
                        size: scale.scale(16),
                        color: theme.colorScheme.onSurface.withOpacity(0.7)),
                    SizedBox(width: scale.scale(6)),
                    Text(
                      "${'deadline_prefix'.tr} ${formatDate(project.deadline)}",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontSize: scale.scaleText(14)),
                    ),
                  ],
                ),
              SizedBox(height: scale.scale(8)),
              Text(
                project.projectDescription ?? 'no_description_available'.tr,
                style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600], fontSize: scale.scaleText(14)),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStat(context, Icons.task_alt,
                      "${project.taskCount ?? 0} ${'tasks_suffix'.tr}"),
                  _buildStat(context, Icons.people_outline,
                      "${project.memberCount ?? 0} ${'members_suffix'.tr}"),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: scale.scale(10), vertical: scale.scale(4)),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(scale.scale(20)),
                    ),
                    child: Text(
                      project.status ?? 'not_available'.tr,
                      style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: scale.scaleText(12)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(BuildContext context, IconData icon, String text) {
    final theme = Theme.of(context);
    final scale = context.scaleConfig;
    return Row(
      children: [
        Icon(icon,
            size: scale.scale(16),
            color: theme.colorScheme.onSurface.withOpacity(0.7)),
        SizedBox(width: scale.scale(6)),
        Text(text,
            style: theme.textTheme.bodyMedium
                ?.copyWith(fontSize: scale.scaleText(14))),
      ],
    );
  }
}
