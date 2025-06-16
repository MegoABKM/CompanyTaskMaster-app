// lib/view/widget/auth/customtextformauth.dart
import 'package:flutter/material.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class Customtextformauth extends StatelessWidget {
  final String texthint;
  final String label;
  final IconData iconData;
  final TextEditingController mycontroller;
  final String? Function(String?)? validator;
  final bool isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final double? iconSize;

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
    this.textStyle,
    this.hintStyle,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.scaleConfig.scale(20)),
      margin: EdgeInsets.only(bottom: context.scaleConfig.scale(20)),
      child: TextFormField(
        obscureText: obscureText ?? false,
        keyboardType: isNumber
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        validator: validator,
        controller: mycontroller,
        style:
            textStyle ?? TextStyle(fontSize: context.scaleConfig.scaleText(16)),
        decoration: InputDecoration(
          hintStyle: hintStyle ??
              context.appTheme.textTheme.bodySmall?.copyWith(
                color: context.appTheme.hintColor,
                fontSize: context.scaleConfig.scaleText(14),
              ),
          hintText: texthint,
          contentPadding: EdgeInsets.symmetric(
            vertical: context.scaleConfig.scale(15),
            horizontal: context.scaleConfig.scale(20),
          ),
          suffixIcon: InkWell(
            onTap: onTapIcon,
            child: Icon(
              iconData,
              color: context.appTheme.iconTheme.color,
              size: iconSize ?? context.scaleConfig.scale(20),
            ),
          ),
          label: Container(
            margin:
                EdgeInsets.symmetric(horizontal: context.scaleConfig.scale(7)),
            child: Text(
              label,
              style: context.appTheme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: context.scaleConfig.scaleText(16),
              ),
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.scaleConfig.scale(30)),
            borderSide: BorderSide(
              color: context.appTheme.dividerColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.scaleConfig.scale(30)),
            borderSide: BorderSide(
              color: context.appTheme.colorScheme.primary,
              width: context.scaleConfig.scale(2),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.scaleConfig.scale(30)),
            borderSide: BorderSide(
              color: context.appTheme.dividerColor,
            ),
          ),
        ),
      ),
    );
  }
}
