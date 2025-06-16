import 'package:flutter/material.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:get/get.dart';

class TaskViewContent extends StatelessWidget {
  final String content;

  const TaskViewContent({
    super.key,
    required this.content,
  });

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
              "137".tr, // "Description"
              style: context.appTheme.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: context.appTheme.colorScheme.onSurface,
                fontSize: context.scaleConfig.scaleText(20),
              ),
            ),
            SizedBox(height: context.scaleConfig.scale(12)),
            Text(
              content.isNotEmpty
                  ? content
                  : "157".tr, // "No description available"
              style: context.appTheme.textTheme.bodyLarge!.copyWith(
                color: context.appTheme.colorScheme.onSurface.withOpacity(0.85),
                fontSize: context.scaleConfig.scaleText(18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
