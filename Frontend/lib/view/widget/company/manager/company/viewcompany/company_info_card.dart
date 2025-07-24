import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';
import 'package:companymanagment/view/widget/profile/profile_info_tile.dart';

class CompanyInfoCard extends StatelessWidget {
  final CompanyModel companyData;
  const CompanyInfoCard({super.key, required this.companyData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'key_about_company'.tr,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              companyData.companyDescription ?? 'no_description_available'.tr,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: Colors.grey[700], height: 1.5),
            ),
            const Divider(height: 32),
            ProfileInfoTile(
              icon: Icons.info_outline,
              label: 'company_id'.tr,
              value: companyData.companyNickID ?? 'not_available'.tr,
            ),
            const SizedBox(height: 8),
            ProfileInfoTile(
              icon: Icons.work_outline,
              label: 'industry'.tr,
              value: companyData.companyJob?.tr ?? 'not_specified'.tr,
            ),
            const SizedBox(height: 8),
            ProfileInfoTile(
              icon: Icons.groups_outlined,
              label: 'company_size'.tr,
              value: companyData.companyWorkes ?? 'not_specified'.tr,
            ),
          ],
        ),
      ),
    );
  }
}
