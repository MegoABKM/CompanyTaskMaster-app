// lib/view/widget/auth/custombuttonauth.dart
import 'package:flutter/material.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class CustomButtonAuth extends StatelessWidget {
  final String textbutton;
  final void Function()? onPressed;
  final TextStyle? textStyle;
  final double? height;

  const CustomButtonAuth({
    super.key,
    required this.textbutton,
    this.onPressed,
    this.textStyle,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: context.scaleConfig.scale(10)),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.scaleConfig.scale(20)),
        ),
        padding: EdgeInsets.symmetric(vertical: context.scaleConfig.scale(13)),
        color: context.appTheme.colorScheme.primary,
        onPressed: onPressed,
        child: Text(
          textbutton,
          style: textStyle ??
              context.appTheme.textTheme.bodyMedium?.copyWith(
                color: context.appTheme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: context.scaleConfig.scaleText(16),
              ),
        ),
        minWidth: double.infinity,
        height: height ?? context.scaleConfig.scale(50),
      ),
    );
  }
}
