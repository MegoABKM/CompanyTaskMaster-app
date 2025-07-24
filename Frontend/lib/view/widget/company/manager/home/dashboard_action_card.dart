import 'package:flutter/material.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class DashboardActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const DashboardActionCard({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
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
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(scale.scale(16)),
        child: Padding(
          padding: EdgeInsets.all(scale.scale(16)),
          child: Row(
            children: [
              Icon(
                icon,
                size: scale.scale(28),
                color: theme.colorScheme.primary,
              ),
              SizedBox(width: scale.scale(12)),
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: scale.scale(16),
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
