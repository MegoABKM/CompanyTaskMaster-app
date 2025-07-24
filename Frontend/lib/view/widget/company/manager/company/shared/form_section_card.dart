import 'package:flutter/material.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class FormSectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const FormSectionCard({
    super.key,
    required this.title,
    required this.children,
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
      margin: EdgeInsets.only(bottom: scale.scale(20)),
      child: Padding(
        padding: EdgeInsets.all(scale.scale(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }
}
