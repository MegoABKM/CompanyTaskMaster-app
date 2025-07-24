import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildTextFiledCompany extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator; // The validator function
  final int? maxLines;
  final IconData? icon;
  final bool readOnly;

  const BuildTextFiledCompany({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.validator, // Add validator to the constructor
    this.maxLines = 1,
    this.icon,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon) : null,
      ),
      // Use the passed-in validator, with a default fallback
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'please_enter_value'.tr;
            }
            return null;
          },
    );
  }
}
