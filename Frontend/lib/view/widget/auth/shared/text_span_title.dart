import 'package:flutter/material.dart';
import 'package:companymanagment/core/constant/utils/scale_confige.dart';

class TextSpanTitle extends StatelessWidget {
  const TextSpanTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaleConfig = ScaleConfig(context);
    final textTheme = theme.textTheme;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: textTheme.displaySmall?.copyWith(
          fontFamily: 'Tajawal',
          fontWeight: FontWeight.bold,
          fontSize: scaleConfig.scaleText(42),
        ),
        children: [
          TextSpan(
            text: "تدفق ",
            style:
                TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.8)),
          ),
          TextSpan(
            text: "أعمالي",
            style: TextStyle(
                color: theme.colorScheme.secondary), // The accent color
          ),
        ],
      ),
    );
  }
}
