// lib/view/widget/auth/customtextformauth.dart

import 'package:flutter/material.dart';

class Customtextformauth extends StatelessWidget {
  final String texthint;
  final String label;
  final IconData iconData;
  final TextEditingController mycontroller;
  final String? Function(String?)? validator;
  final bool isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;

  const Customtextformauth({
    super.key,
    required this.texthint,
    required this.label,
    required this.iconData,
    required this.mycontroller,
    required this.validator,
    required this.isNumber,
    this.obscureText,
    this.onTapIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Removed the outer Container. Spacing should be handled by the parent layout (e.g., with SizedBox).
    return TextFormField(
      obscureText: obscureText ?? false,
      keyboardType: isNumber
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      validator: validator,
      controller: mycontroller,
      style: theme.textTheme.bodyLarge?.copyWith(
        color: theme.colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        // The theme now controls the fill color, borders, and padding.
        // This ensures a consistent look with the "Slate & Spark" theme.
        labelText: label,
        hintText: texthint,
        suffixIcon: InkWell(
          onTap: onTapIcon,
          child: Icon(
            iconData,
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}
