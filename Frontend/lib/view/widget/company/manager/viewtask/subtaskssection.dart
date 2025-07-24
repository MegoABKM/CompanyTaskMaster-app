import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/tasks/viewtask_controller.dart';
import 'package:companymanagment/core/constant/utils/scale_confige.dart';

class SubtasksSection extends GetView<ViewTaskCompanyManagerController> {
  final ThemeData theme;
  const SubtasksSection({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    final scaleConfig = ScaleConfig(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "311".tr, // Subtasks
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: scaleConfig.scaleText(20),
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
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
                      scaleConfig: scaleConfig);
                },
              )
            : _noSubtasksAvailable(scaleConfig, theme),
      ],
    );
  }

  Widget _noSubtasksAvailable(ScaleConfig scaleConfig, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: scaleConfig.scale(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline,
              size: scaleConfig.scale(24),
              color: theme.colorScheme.onSurface.withOpacity(0.6)),
          SizedBox(width: scaleConfig.scale(8)),
          Text("325".tr,
              style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: scaleConfig.scaleText(16),
                  color: theme.colorScheme.onSurface.withOpacity(0.6))),
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

  const SubtaskCard(
      {super.key,
      required this.subtask,
      required this.index,
      required this.theme,
      required this.scaleConfig});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: scaleConfig.scale(2),
      margin: EdgeInsets.symmetric(vertical: scaleConfig.scale(8)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(scaleConfig.scale(12))),
      child: ListTile(
        contentPadding: EdgeInsets.all(scaleConfig.scale(16)),
        leading: CircleAvatar(child: Text('$index')),
        title: Text(
          subtask.title ?? "318".tr,
          style: theme.textTheme.titleMedium?.copyWith(
              fontSize: scaleConfig.scaleText(16), fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            subtask.description ?? "318".tr,
            style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: scaleConfig.scaleText(14), color: Colors.grey[600]),
          ),
        ),
      ),
    );
  }
}
