import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/tasks/workspacemanager.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';
import 'package:tasknotate/main.dart'; // Added for scaleConfig

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final scaleConfig = ScaleConfig(context);
    final theme = Theme.of(context);
    return GetBuilder<WorkspaceController>(
      builder: (controller) => Padding(
        padding: EdgeInsets.all(scaleConfig.scale(16)),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "332".tr + " ${controller.progress}%", // Task Progress:
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: scaleConfig.scaleText(18),
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                SizedBox(height: scaleConfig.scale(12)),
                Stack(
                  children: [
                    Container(
                      height: scaleConfig.scale(20),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius:
                            BorderRadius.circular(scaleConfig.scale(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: scaleConfig.scale(6),
                            offset: Offset(0, scaleConfig.scale(3)),
                          ),
                        ],
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: (controller.progress.clamp(0, 100)) / 100,
                      child: Container(
                        height: scaleConfig.scale(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.green.shade300,
                              Colors.green.shade700,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius:
                              BorderRadius.circular(scaleConfig.scale(10)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: scaleConfig.scale(12)),
                Text(
                  "333".tr +
                      " ${controller.completedTasks}", // Completed Tasks:
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: scaleConfig.scaleText(16),
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ],
            ),
            Positioned(
              right: myServices.sharedPreferences.getString("lang") != "ar"
                  ? 0
                  : Get.width * 0.8,
              top: 0,
              child: IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.grey,
                  size: scaleConfig.scale(24),
                ),
                onPressed: () =>
                    _showEditDialog(context, controller, theme, scaleConfig),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, WorkspaceController controller,
      ThemeData theme, ScaleConfig scaleConfig) {
    TextEditingController textController =
        TextEditingController(text: controller.completedTasks.toString());

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(scaleConfig.scale(12)),
        ),
        title: Text(
          "334".tr, // Update Completed Tasks
          style: theme.textTheme.titleMedium?.copyWith(
            fontSize: scaleConfig.scaleText(18),
          ),
        ),
        content: TextField(
          controller: textController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "335".tr, // Enter number of completed tasks
            hintStyle: TextStyle(fontSize: scaleConfig.scaleText(14)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(scaleConfig.scale(8)),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: scaleConfig.scale(12),
              vertical: scaleConfig.scale(10),
            ),
            filled: true,
            fillColor: theme.colorScheme.surfaceContainerHighest,
          ),
          style: TextStyle(fontSize: scaleConfig.scaleText(16)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              "303".tr, // Cancel
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: scaleConfig.scaleText(14),
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              int? newValue = int.tryParse(textController.text);
              if (newValue != null && newValue >= 0) {
                try {
                  await controller.updateCompletedTasks(newValue);
                  Navigator.of(dialogContext).pop();
                } catch (e) {
                  Get.snackbar("Error", "Failed to update: $e");
                }
              } else {
                Get.snackbar("Error", "Please enter a valid number");
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: scaleConfig.scale(16),
                vertical: scaleConfig.scale(8),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(scaleConfig.scale(8)),
              ),
            ),
            child: Text(
              "278".tr, // Save
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: scaleConfig.scaleText(14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
