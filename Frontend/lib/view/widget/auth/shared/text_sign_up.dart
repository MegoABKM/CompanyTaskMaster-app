import 'package:flutter/material.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class CustomTextSignupOrSignin extends StatelessWidget {
  final String text;
  final String textbutton;
  final Function()? onTap;
  final TextStyle? textStyle;
  final TextStyle? textButtonStyle;

  const CustomTextSignupOrSignin({
    super.key,
    required this.text,
    required this.textbutton,
    this.onTap,
    this.textStyle,
    this.textButtonStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: textStyle ??
              context.appTheme.textTheme.bodyMedium!.copyWith(
                fontSize: context.scaleConfig.scaleText(14),
                color: context.appTheme.colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            textbutton,
            style: textButtonStyle ??
                context.appTheme.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.appTheme.colorScheme.primary,
                  fontSize: context.scaleConfig.scaleText(14),
                ),
          ),
        ),
      ],
    );
  }
}
