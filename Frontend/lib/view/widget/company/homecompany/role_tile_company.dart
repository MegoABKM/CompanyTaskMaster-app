import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/homecompany_controller.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class RoleTileCompany extends GetView<CompanyHomeController> {
  final String title;
  final String subtitle;
  final IconData icon;
  final String roleKey;
  final bool isSelected; // THE MISSING PARAMETER

  const RoleTileCompany({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.roleKey,
    required this.isSelected, // ADD IT TO THE CONSTRUCTOR
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scale = context.scaleConfig;
    final bool isRtl = Get.locale?.languageCode == 'ar';

    return GestureDetector(
      onTap: () => controller.selectTile(roleKey),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(scale.scale(16)),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(scale.scale(20)),
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : theme.dividerColor,
            width: isSelected ? 3.0 : 1.5,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.25),
                blurRadius: 12,
                spreadRadius: 2,
              )
            else
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Stack(
          children: [
            // Centered content for the grid layout
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: scale.scale(60), // Even larger icon for grid
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withOpacity(0.7),
                ),
                SizedBox(height: scale.scale(12)),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: scale.scaleText(18),
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: scale.scale(4)),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: scale.scaleText(14),
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
            if (isSelected)
              Positioned(
                top: scale.scale(4),
                // Use isRtl to correctly position the checkmark
                left: isRtl ? scale.scale(4) : null,
                right: isRtl ? null : scale.scale(4),
                child: Icon(
                  Icons.check_circle,
                  color: theme.colorScheme.primary,
                  size: scale.scale(28),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
