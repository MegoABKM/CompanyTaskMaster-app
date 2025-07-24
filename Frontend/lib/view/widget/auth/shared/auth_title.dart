import 'package:flutter/material.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class AuthTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color? titleColor; // Add optional color
  final Color? subtitleColor; // Add optional color

  const AuthTitle({
    super.key,
    required this.title,
    required this.subtitle,
    this.titleColor, // Add to constructor
    this.subtitleColor, // Add to constructor
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scale = context.scaleConfig;
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineLarge?.copyWith(
            fontSize: scale.scaleText(32),
            color: titleColor ?? theme.colorScheme.onBackground, // Use override
          ),
        ),
        SizedBox(height: scale.scale(8)),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: scale.scaleText(16),
            color: subtitleColor ??
                theme.colorScheme.onBackground.withOpacity(0.7), // Use override
          ),
        ),
      ],
    );
  }
}
