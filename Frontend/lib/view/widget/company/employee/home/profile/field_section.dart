import 'package:flutter/material.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class FieldSection extends StatelessWidget {
  final String value;
  final String label;
  const FieldSection({super.key, required this.value, required this.label});

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
                color: Colors.black87),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: context.scaleConfig.scaleText(16),
                color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
