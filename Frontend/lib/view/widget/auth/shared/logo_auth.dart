import 'package:flutter/material.dart';
import 'package:tasknotate/core/constant/appthemes.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class LogoAuth extends StatelessWidget {
  const LogoAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.scaleConfig.scale(20)),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.appTheme.colorScheme.surface,
        boxShadow: const [AppThemes.cardBoxShadow],
      ),
      child: Image.asset(
        "assets/images/logogreen.png",
        height: context.scaleConfig.scale(150),
        width: context.scaleConfig.scale(150),
      ),
    );
  }
}
