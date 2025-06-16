import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class EditAbleField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const EditAbleField(
      {required this.label, required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(context.scaleConfig.scale(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: context.scaleConfig.scale(5),
            offset: Offset(0, context.scaleConfig.scale(2)),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
          vertical: context.scaleConfig.scale(12),
          horizontal: context.scaleConfig.scale(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: context.scaleConfig.scaleText(16),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: label == "215".tr
                    ? "340".tr
                    : "341".tr, // Enter Name or Enter Phone
                contentPadding: EdgeInsets.zero,
              ),
              style: TextStyle(
                  fontSize: context.scaleConfig.scaleText(16),
                  color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
