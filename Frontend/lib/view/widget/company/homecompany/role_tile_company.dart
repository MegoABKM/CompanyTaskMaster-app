import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/homecompany_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class RoleTileCompany extends GetView<CompanyHomeController> {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const RoleTileCompany(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.scaleConfig.scale(16),
          vertical: context.scaleConfig.scale(12),
        ),
        decoration: BoxDecoration(
          color: context.appTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(context.scaleConfig.scale(15)),
          border: Border.all(
            color: controller.selectedindex!
                ? context.appTheme.colorScheme.primary
                : context.appTheme.colorScheme.onSurface.withOpacity(0.2),
            width: controller.selectedindex!
                ? context.scaleConfig.scale(2)
                : context.scaleConfig.scale(1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: context.scaleConfig.scale(6),
              offset: Offset(0, context.scaleConfig.scale(2)),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.appTheme.textTheme.bodyLarge?.copyWith(
                      color: context.appTheme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: context.scaleConfig.scaleText(16),
                    ),
                  ),
                  SizedBox(height: context.scaleConfig.scale(4)),
                  Text(
                    subtitle,
                    style: context.appTheme.textTheme.bodySmall?.copyWith(
                      color: context.appTheme.colorScheme.onSurface
                          .withOpacity(0.7),
                      fontSize: context.scaleConfig.scaleText(12),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              controller.selectedindex!
                  ? Icons.check_circle
                  : Icons.circle_outlined,
              color: controller.selectedindex!
                  ? context.appTheme.colorScheme.primary
                  : context.appTheme.colorScheme.onSurface.withOpacity(0.5),
              size: context.scaleConfig.scale(28),
            ),
          ],
        ),
      ),
    );
  }
}
