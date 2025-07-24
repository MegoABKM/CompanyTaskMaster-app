import 'package:flutter/material.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileInfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: scale.scale(8.0)),
      child: Row(
        children: [
          Icon(
            icon,
            color: theme.colorScheme.primary,
            size: scale.scale(24),
          ),
          SizedBox(width: scale.scale(16)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              SizedBox(height: scale.scale(2)),
              Text(
                value,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
