import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/tasks/viewtask_controller.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';

class AssignedUsersSection extends GetView<ViewTaskCompanyManagerController> {
  final ThemeData theme;

  const AssignedUsersSection({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    final scaleConfig = ScaleConfig(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "267".tr, // Assigned Users
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: scaleConfig.scaleText(18),
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            TextButton(
              onPressed: () => controller.goToUpdateAssignedEmp(),
              child: Text(
                "309".tr, // Edit
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: scaleConfig.scaleText(14),
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: scaleConfig.scale(8)),
        controller.assignedemployee.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.assignedemployee.length,
                itemBuilder: (context, index) {
                  final user = controller.assignedemployee[index];
                  return AssignedUserCard(
                    user: user,
                    theme: theme,
                    scaleConfig: scaleConfig,
                  );
                },
              )
            : Padding(
                padding: EdgeInsets.symmetric(vertical: scaleConfig.scale(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: scaleConfig.scale(20),
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    SizedBox(width: scaleConfig.scale(8)),
                    Text(
                      "327".tr, // No users assigned.
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: scaleConfig.scaleText(12),
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}

class AssignedUserCard extends StatelessWidget {
  final dynamic user;
  final ThemeData theme;
  final ScaleConfig scaleConfig;

  const AssignedUserCard({
    super.key,
    required this.user,
    required this.theme,
    required this.scaleConfig,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: scaleConfig.scale(2),
      margin: EdgeInsets.symmetric(vertical: scaleConfig.scale(8)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(scaleConfig.scale(12)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(scaleConfig.scale(12)),
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
          radius: scaleConfig.scale(20),
          child: Text(
            user.usersName?[0].toUpperCase() ?? "U",
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: scaleConfig.scaleText(16),
            ),
          ),
        ),
        title: Text(
          user.usersName ?? "318".tr, // N/A
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: scaleConfig.scaleText(16),
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "330".tr + " ${user.usersPhone ?? "318".tr}", // Phone: N/A
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: scaleConfig.scaleText(14),
              ),
            ),
            Text(
              "331".tr + " ${user.usersEmail ?? "318".tr}", // Email: N/A
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: scaleConfig.scaleText(14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
