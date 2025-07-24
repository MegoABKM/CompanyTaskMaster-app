import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/projects/archived_projects_controller.dart';
import 'package:companymanagment/data/model/company/project_model.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class ArchivedProjectCard extends StatelessWidget {
  final ProjectModel project;
  const ArchivedProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scale = context.scaleConfig;
    final ArchivedProjectsController controller = Get.find();

    return Card(
      margin: EdgeInsets.only(bottom: scale.scale(16)),
      elevation: 2,
      color: Colors.grey.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(scale.scale(12)),
      ),
      child: Padding(
        padding: EdgeInsets.all(scale.scale(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.projectName ?? 'untitled_project'.tr,
              style: theme.textTheme.titleLarge?.copyWith(
                color: Colors.grey.shade700,
                decoration: TextDecoration.lineThrough,
                fontSize: scale.scaleText(18),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              project.projectDescription ?? 'no_description_available'.tr,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
                fontSize: scale.scaleText(14),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Divider(height: 24),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () =>
                    controller.unarchiveProject(project.projectId.toString()),
                icon: const Icon(Icons.unarchive_outlined),
                label: Text('restore'.tr),
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.primary,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
