import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/employee/tasks/viewtaskemp_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';

class AssignedUsersSectionEmp extends GetView<ViewtaskEmpController> {
  final ThemeData theme;

  const AssignedUsersSectionEmp({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(context.scaleConfig.scale(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "267".tr, // Assigned Users
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: context.scaleConfig.scaleText(18),
              fontWeight: FontWeight.bold,
              color: Colors.black87, // Match manager's title color
            ),
          ),
          SizedBox(height: context.scaleConfig.scale(8)),
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
                      scaleConfig: context.scaleConfig,
                    );
                  },
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: context.scaleConfig.scale(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: context.scaleConfig.scale(20),
                        color: Colors.black54, // Match manager's no-data color
                      ),
                      SizedBox(width: context.scaleConfig.scale(8)),
                      Text(
                        "327".tr, // No users assigned.
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: context.scaleConfig.scaleText(12),
                          color:
                              Colors.black54, // Match manager's no-data color
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
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
          user.usersName ?? "350".tr, // Unknown User -> Unknown Employee
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: scaleConfig.scaleText(16),
            fontWeight: FontWeight.bold,
            color: Colors.black87, // Match manager's title color
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "330".tr + " ${user.usersPhone ?? "318".tr}", // Phone: N/A
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: scaleConfig.scaleText(14),
                color: Colors.black54, // Match manager's subtitle color
              ),
            ),
            Text(
              "331".tr + " ${user.usersEmail ?? "318".tr}", // Email: N/A
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: scaleConfig.scaleText(14),
                color: Colors.black54, // Match manager's subtitle color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
