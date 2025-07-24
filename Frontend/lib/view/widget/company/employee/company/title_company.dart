import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';

class TitleCompany extends StatelessWidget {
  final CompanyModel companyModel;
  const TitleCompany({super.key, required this.companyModel});

  @override
  Widget build(BuildContext context) {
    return Text(
      companyModel.companyName ?? "173".tr, // No Name -> No Title
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: context.appTheme.colorScheme.primary,
          fontSize: context.scaleConfig.scaleText(22)),
    );
  }
}
