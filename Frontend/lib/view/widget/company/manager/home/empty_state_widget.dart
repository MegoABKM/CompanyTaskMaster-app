import 'package:flutter/material.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String message;
  final String? details;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.message,
    this.details,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    return Center(
      child: Container(
        padding: EdgeInsets.all(scale.scale(32)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: scale.scale(70),
              color: theme.colorScheme.primary.withOpacity(0.5),
            ),
            SizedBox(height: scale.scale(16)),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.8),
                fontWeight: FontWeight.w600,
              ),
            ),
            if (details != null) ...[
              SizedBox(height: scale.scale(8)),
              Text(
                details!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ]
          ],
        ),
      ).animate().fade(duration: 500.ms).scale(begin: const Offset(0.9, 0.9)),
    );
  }
}
