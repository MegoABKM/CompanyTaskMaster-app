import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final ThemeData theme;

  SectionTitle({required this.title, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.primary,
      ),
    );
  }
}
