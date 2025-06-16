import 'package:flutter/material.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class RoleSelectionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const RoleSelectionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: context.scaleConfig.scale(20),
      ),
      label: Text(
        label,
        style: context.appTextTheme.labelLarge?.copyWith(
          fontSize: context.scaleConfig.scaleText(16),
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: context.scaleConfig.scale(20),
          vertical: context.scaleConfig.scale(12),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.scaleConfig.scale(16)),
        ),
        elevation: context.scaleConfig.scale(6),
      ),
    );
  }
}
