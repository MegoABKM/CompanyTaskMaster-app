import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/homemanager/home_manager_controller.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/data/datasource/remote/linkapi.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';

class CompanyHeaderCard extends GetView<ManagerhomeController> {
  final CompanyModel company;

  const CompanyHeaderCard({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(scale.scale(16)),
      ),
      child: Padding(
        padding: EdgeInsets.all(scale.scale(16)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(scale.scale(12)),
              child: Image.network(
                "${AppLink.imageplaceserver}${company.companyImage}",
                width: scale.scale(70),
                height: scale.scale(70),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.business_rounded,
                  size: scale.scale(70),
                  color: theme.dividerColor,
                ),
              ),
            ),
            SizedBox(width: scale.scale(16)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    company.companyName ?? "Unknown Company",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: scale.scaleText(20),
                    ),
                  ),
                  SizedBox(height: scale.scale(4)),
                  Text(
                    // THE FIX IS HERE: Apply .tr to the companyJob field
                    company.companyJob?.tr ?? "No industry specified".tr,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                      fontSize: scale.scaleText(14),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
