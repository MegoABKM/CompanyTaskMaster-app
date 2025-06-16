import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/data/model/company/companymodel.dart';

class ShowFieldsSectionViewCompany extends StatelessWidget {
  final CompanyModel companyModel;
  const ShowFieldsSectionViewCompany({super.key, required this.companyModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          companyModel.companyName ?? "N/A",
          style: context.appTheme.textTheme.titleLarge!.copyWith(
              color: context.appTheme.colorScheme.primary,
              fontSize: context.scaleConfig.scaleText(20)),
        ),
        SizedBox(height: context.scaleConfig.scale(10)),
        Text(
          companyModel.companyNickID ?? "228".tr, // No description available
          style: context.appTheme.textTheme.bodyMedium!.copyWith(
              color: context.appTheme.colorScheme.secondary,
              fontSize: context.scaleConfig.scaleText(16)),
        ),
        SizedBox(height: context.scaleConfig.scale(10)),
        Text(
          companyModel.companyJob ?? "228".tr, // No description available
          style: context.appTheme.textTheme.bodyMedium!.copyWith(
              color: context.appTheme.colorScheme.secondary,
              fontSize: context.scaleConfig.scaleText(16)),
        ),
        SizedBox(height: context.scaleConfig.scale(20)),
        Text(
          "227".tr, // About the company
          style: context.appTheme.textTheme.headlineSmall!.copyWith(
              color: context.appTheme.colorScheme.primary,
              fontSize: context.scaleConfig.scaleText(22)),
        ),
        SizedBox(height: context.scaleConfig.scale(10)),
        Text(
          companyModel.companyDescription ??
              "228".tr, // No description available
          style: context.appTheme.textTheme.bodyLarge
              ?.copyWith(fontSize: context.scaleConfig.scaleText(16)),
        ),
      ],
    );
  }
}
