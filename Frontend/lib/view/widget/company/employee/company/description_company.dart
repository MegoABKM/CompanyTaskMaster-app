import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';

class DescriptionCompany extends StatelessWidget {
  final CompanyModel companyModel;
  const DescriptionCompany({super.key, required this.companyModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "227".tr, // About the company
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: context.appTheme.colorScheme.primary,
              fontSize: context.scaleConfig.scaleText(20)),
        ),
        SizedBox(height: context.scaleConfig.scale(10)),
        Text(
          companyModel.companyDescription ??
              "348".tr, // Description of the company goes here
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize: context.scaleConfig.scaleText(16)),
        ),
      ],
    );
  }
}
