import 'package:flutter/material.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class BuildTextFiledCompany extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final int? maxLines;

  const BuildTextFiledCompany(
      {super.key,
      required this.label,
      required this.controller,
      required this.hint,
      this.maxLines});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.appTheme.textTheme.titleMedium
              ?.copyWith(fontSize: context.scaleConfig.scaleText(18)),
        ),
        SizedBox(height: context.scaleConfig.scale(5)),
        Card(
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(context.scaleConfig.scale(10))),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: context.appTheme.textTheme.bodyMedium!.copyWith(
                  color: context.appTheme.hintColor,
                  fontSize: context.scaleConfig.scaleText(16)),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: context.scaleConfig.scale(15),
                  vertical: context.scaleConfig.scale(15)),
            ),
            maxLines: maxLines,
            validator: (value) =>
                value == null || value.isEmpty ? 'Please enter $label' : null,
          ),
        ),
      ],
    );
  }
}
