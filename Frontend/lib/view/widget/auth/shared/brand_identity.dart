import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/view/widget/auth/shared/modern_logo.dart';

class BrandIdentity extends StatelessWidget {
  final Color? color; // Add this optional color parameter

  const BrandIdentity({
    super.key,
    this.color, // Add this to the constructor
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    return Column(
      children: [
        ModernLogo(color: color), // Pass the color to the logo
        SizedBox(height: scale.scale(12)),
        Text(
          "key_app_name".tr,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontSize: scale.scaleText(40),
            fontWeight: FontWeight.w700,
            // Use the provided color, or fallback to the theme color
            color: color ?? theme.colorScheme.onBackground,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}
