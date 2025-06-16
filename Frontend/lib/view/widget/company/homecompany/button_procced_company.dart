import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/homecompany_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class ButtonProccedCompany extends GetView<CompanyHomeController> {
  const ButtonProccedCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => controller.goToManagerOrEmployee(),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.scaleConfig.scale(20),
            vertical: context.scaleConfig.scale(12),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                context.appTheme.colorScheme.primary,
                context.appTheme.colorScheme.secondary
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(context.scaleConfig.scale(12)),
            boxShadow: [
              BoxShadow(
                color: context.appTheme.colorScheme.primary.withOpacity(0.3),
                blurRadius: context.scaleConfig.scale(8),
                offset: Offset(0, context.scaleConfig.scale(3)),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "78".tr,
                style: context.appTheme.textTheme.bodyLarge?.copyWith(
                  color: context.appTheme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: context.scaleConfig.scaleText(16),
                ),
              ),
              SizedBox(width: context.scaleConfig.scale(8)),
              Icon(
                Icons.arrow_right_alt,
                color: context.appTheme.colorScheme.onPrimary,
                size: context.scaleConfig.scale(28),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
