import 'package:flutter/material.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class LogoAuth extends StatelessWidget {
  const LogoAuth({super.key});

  @override
  Widget build(BuildContext context) {
    // The new, simple, and modern icon.
    return Icon(
      Icons.insights_rounded,
      size: context.scaleConfig.scale(80),
      color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
    );
  }
}
