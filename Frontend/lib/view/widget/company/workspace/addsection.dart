import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Added for .tr
import 'package:tasknotate/core/constant/utils/scale_confige.dart'; // Added for scaleConfig

class AdSection extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onAdClick;

  const AdSection({
    super.key,
    required this.title,
    required this.description,
    required this.onAdClick,
  });

  @override
  Widget build(BuildContext context) {
    final scaleConfig = ScaleConfig(context);
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: scaleConfig.scale(10)),
      padding: EdgeInsets.all(scaleConfig.scale(16)),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(scaleConfig.scale(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: scaleConfig.scale(5),
            spreadRadius: scaleConfig.scale(2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title.tr, // Assuming title might be translatable
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: scaleConfig.scaleText(16),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: scaleConfig.scale(8)),
          Text(
            description.tr, // Assuming description might be translatable
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: scaleConfig.scaleText(14),
              color: Colors.black54,
            ),
          ),
          SizedBox(height: scaleConfig.scale(10)),
          ElevatedButton(
            onPressed: onAdClick,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: scaleConfig.scale(16),
                vertical: scaleConfig.scale(8),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(scaleConfig.scale(8)),
              ),
            ),
            child: Text(
              "336".tr, // Learn More
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: scaleConfig.scaleText(14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
