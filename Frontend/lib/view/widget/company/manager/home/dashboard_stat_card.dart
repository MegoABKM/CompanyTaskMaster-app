import 'package:flutter/material.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class DashboardStatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const DashboardStatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(scale.scale(16)),
      ),
      child: Padding(
        padding: EdgeInsets.all(scale.scale(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: scale.scale(32),
              color: theme.colorScheme.primary,
            ),
            const Spacer(),
            Text(
              value,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: scale.scaleText(28),
              ),
            ),
            SizedBox(height: scale.scale(4)),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
