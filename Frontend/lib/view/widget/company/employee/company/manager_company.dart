import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/constant/imageasset.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';

class ManagerCompany extends StatelessWidget {
  final CompanyModel companyModel;
  const ManagerCompany({super.key, required this.companyModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "220".tr, // Manager
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: context.appTheme.colorScheme.primary,
              fontSize: context.scaleConfig.scaleText(20)),
        ),
        SizedBox(height: context.scaleConfig.scale(10)),
        ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 1,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => Padding(
            padding:
                EdgeInsets.symmetric(vertical: context.scaleConfig.scale(8)),
            child: Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    AppImageAsset.managerimage,
                    height: context.scaleConfig.scale(80),
                    width: context.scaleConfig.scale(80),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: context.scaleConfig.scale(16)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      companyModel.manager!.managerName?.toString() ??
                          "349".tr, // Unknown Manager
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: context.appTheme.colorScheme.primary,
                          fontSize: context.scaleConfig.scaleText(16)),
                    ),
                    Text(
                      "220".tr, // Manager
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: context.scaleConfig.scaleText(12)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
