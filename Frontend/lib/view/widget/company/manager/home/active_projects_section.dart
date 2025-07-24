import 'package:companymanagment/controller/company/manager/homemanager/home_manager_controller.dart';
import 'package:companymanagment/data/model/company/project_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class ActiveProjectsSection extends GetView<ManagerhomeController> {
  const ActiveProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = context.scaleConfig;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: scale.scale(16)),
          child: Text(
            "380".tr, // "Active Projects"
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
              fontSize: scale.scaleText(20),
            ),
          ),
        ),
        SizedBox(height: scale.scale(12)),
        SizedBox(
          height: scale.scale(160),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding:
                EdgeInsets.only(left: scale.scale(16), right: scale.scale(4)),
            itemCount: controller.activeProjects.length,
            itemBuilder: (context, index) {
              final project = controller.activeProjects[index];
              // The controller provides a ProjectModel, which we pass to the card.
              return ProjectCard(project: project);
            },
          ),
        ),
      ],
    );
  }
}

class ProjectCard extends StatelessWidget {
  // THE FIX IS HERE: The `project` property is now correctly typed as ProjectModel.
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final scale = context.scaleConfig;
    final theme = Theme.of(context);

    Color statusColor;
    double progressValue;

    switch (project.status?.toLowerCase()) {
      case 'completed':
        statusColor = Colors.green;
        progressValue = 1.0;
        break;
      case 'active': // Match the status from the database
        statusColor = Colors.blue;
        progressValue = 0.5;
        break;
      default:
        statusColor = Colors.grey;
        progressValue = 0.0;
    }

    return Container(
      width: scale.scale(250),
      margin: EdgeInsets.only(right: scale.scale(12)),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(scale.scale(16)),
        ),
        child: Padding(
          padding: EdgeInsets.all(scale.scale(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.projectName ??
                    "Unnamed Project", // Now uses the correct field name
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: scale.scale(4)),
              Text(
                project.projectDescription ??
                    "No description.", // Now uses the correct field name
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    width: scale.scale(10),
                    height: scale.scale(10),
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: scale.scale(6)),
                  Text(
                    project.status ?? "N/A",
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: scale.scale(8)),
              LinearProgressIndicator(
                value: progressValue,
                backgroundColor: statusColor.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                borderRadius: BorderRadius.circular(scale.scale(10)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
