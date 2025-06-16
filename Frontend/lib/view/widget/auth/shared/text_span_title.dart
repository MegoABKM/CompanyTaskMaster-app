import 'package:flutter/material.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';

class TextSpanTitle extends StatelessWidget {
  const TextSpanTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaleConfig = ScaleConfig(context);
    final textTheme = theme.textTheme;

    return Container(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "Task",
                style: textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                  fontSize: scaleConfig.scaleText(40),
                ),
              ),
              TextSpan(
                text: "notate",
                style: textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.secondary,
                  fontSize: scaleConfig.scaleText(40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
