import 'package:flutter/material.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class CustomButtonAuth extends StatelessWidget {
  final String textbutton;
  final void Function()? onPressed;

  const CustomButtonAuth({
    super.key,
    required this.textbutton,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // The button now uses the modern ElevatedButton style from the theme.
    // The problematic SizedBox has been removed.
    return ElevatedButton(
      style: context.appTheme.elevatedButtonTheme.style?.copyWith(
        // Ensure the button stretches horizontally if placed in a constrained parent
        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50)),
      ),
      onPressed: onPressed,
      child: Text(textbutton),
    );
  }
}
