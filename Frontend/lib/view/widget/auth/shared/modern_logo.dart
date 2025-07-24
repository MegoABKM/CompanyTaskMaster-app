import 'package:flutter/material.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class ModernLogo extends StatelessWidget {
  final Color? color; // Add this optional color parameter

  const ModernLogo({
    super.key,
    this.color, // Add this to the constructor
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = theme.colorScheme.primary;

    return Icon(
      Icons.hub_outlined,
      size: context.scaleConfig.scale(80),
      // Use the provided color, or fallback to the theme accent color
      color: color ?? accentColor,
      shadows: [
        BoxShadow(
          color: (color ?? accentColor).withOpacity(0.5),
          blurRadius: 20,
        )
      ],
    );
  }
}
