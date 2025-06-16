import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/tasks/taskviewcontroller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class TaskViewSubtask extends GetView<Taskviewcontroller> {
  const TaskViewSubtask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: context.scaleConfig.scale(4),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.scaleConfig.scale(16))),
      child: Container(
        padding: EdgeInsets.all(context.scaleConfig.scale(16)),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.appTheme.colorScheme.surface,
              context.appTheme.colorScheme.surface.withOpacity(0.8)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(context.scaleConfig.scale(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "110".tr, // "Subtasks"
              style: context.appTheme.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: context.appTheme.colorScheme.onSurface,
                fontSize: context.scaleConfig.scaleText(20),
              ),
            ),
            SizedBox(height: context.scaleConfig.scale(12)),
            GetBuilder<Taskviewcontroller>(
              builder: (controller) {
                final subtasks = controller.decodedsubtask;
                if (subtasks == null || subtasks.isEmpty) {
                  return Center(
                    child: Text(
                      "158".tr, // "No Subtasks"
                      style: context.appTheme.textTheme.bodyLarge!.copyWith(
                        color: context.appTheme.colorScheme.onSurface
                            .withOpacity(0.7),
                        fontSize: context.scaleConfig.scaleText(18),
                      ),
                    ),
                  );
                }
                return Column(
                  children: subtasks.entries.map((entry) {
                    final index = int.parse(entry.key) + 1;
                    final subtask = entry.value;
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: context.scaleConfig.scale(6)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: context.scaleConfig.scale(32),
                            height: context.scaleConfig.scale(32),
                            decoration: BoxDecoration(
                              color: context.appTheme.colorScheme.primary
                                  .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(
                                  context.scaleConfig.scale(8)),
                            ),
                            child: Center(
                              child: Text(
                                "$index",
                                style: context.appTheme.textTheme.bodyLarge!
                                    .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: context.appTheme.colorScheme.primary,
                                  fontSize: context.scaleConfig.scaleText(18),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: context.scaleConfig.scale(12)),
                          Expanded(
                            child: Text(
                              subtask,
                              style: context.appTheme.textTheme.bodyLarge!
                                  .copyWith(
                                color: context.appTheme.colorScheme.onSurface,
                                fontSize: context.scaleConfig.scaleText(18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
