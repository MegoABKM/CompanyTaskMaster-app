import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  const GlassCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final scale = context.scaleConfig;
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(scale.scale(20)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.all(scale.scale(20)),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withOpacity(0.2),
            borderRadius: BorderRadius.circular(scale.scale(20)),
            border: Border.all(
              color: theme.colorScheme.onSurface.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
