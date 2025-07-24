import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/employee/tasks/viewtaskemp_controller.dart';
import 'package:companymanagment/core/constant/utils/scale_confige.dart';

class SubtasksSectionEmp extends StatelessWidget {
  final ThemeData theme;

  const SubtasksSectionEmp({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    final scaleConfig = ScaleConfig(context);
    return GetBuilder<ViewtaskEmpController>(
      builder: (controller) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(scaleConfig.scale(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "311".tr, // Subtasks
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: scaleConfig.scaleText(20),
                  fontWeight: FontWeight.bold,
                  color: Colors.black87, // Match manager's title color
                ),
              ),
              SizedBox(height: scaleConfig.scale(16)),
              controller.subtasks.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.subtasks.length,
                      itemBuilder: (context, index) {
                        final subtask = controller.subtasks[index];
                        return SubtaskCard(
                          subtask: subtask,
                          index: index + 1,
                          theme: theme,
                          scaleConfig: scaleConfig,
                        );
                      },
                    )
                  : _noSubtasksAvailable(scaleConfig),
            ],
          ),
        );
      },
    );
  }

  Widget _noSubtasksAvailable(ScaleConfig scaleConfig) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: scaleConfig.scale(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline,
            size: scaleConfig.scale(24),
            color: Colors.black54, // Match manager's no-data color
          ),
          SizedBox(width: scaleConfig.scale(8)),
          Text(
            "325".tr, // No subtasks available.
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: scaleConfig.scaleText(16),
              color: Colors.black54, // Match manager's no-data color
            ),
          ),
        ],
      ),
    );
  }
}

class SubtaskCard extends StatelessWidget {
  final dynamic subtask;
  final int index;
  final ThemeData theme;
  final ScaleConfig scaleConfig;

  const SubtaskCard({
    super.key,
    required this.subtask,
    required this.index,
    required this.theme,
    required this.scaleConfig,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: scaleConfig.scale(4),
      margin: EdgeInsets.symmetric(vertical: scaleConfig.scale(12)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(scaleConfig.scale(12)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(scaleConfig.scale(16)),
        title: Row(
          children: [
            Text(
              "$index -",
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: scaleConfig.scaleText(18),
                fontWeight: FontWeight.bold,
                color: Colors.black87, // Match manager's title color
              ),
            ),
            SizedBox(width: scaleConfig.scale(8)),
            Expanded(
              child: Text(
                subtask.title ?? "173".tr, // No Title
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: scaleConfig.scaleText(18),
                  fontWeight: FontWeight.bold,
                  color: Colors.black87, // Match manager's title color
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "276".tr + ":", // Description:
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: scaleConfig.scaleText(14),
                fontWeight: FontWeight.bold,
                color: Colors.black54, // Match manager's subtitle color
              ),
            ),
            SizedBox(height: scaleConfig.scale(4)),
            Text(
              subtask.description ?? "228".tr, // No description available
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
