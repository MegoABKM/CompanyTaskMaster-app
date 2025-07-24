import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';

class NickIdCompany extends StatelessWidget {
  final CompanyModel companyModel;
  const NickIdCompany({super.key, required this.companyModel});

  @override
  Widget build(BuildContext context) {
    return Text(
      companyModel.companyNickID ?? "228".tr,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: context.appTheme.colorScheme.secondary,
          fontSize: context.scaleConfig.scaleText(16)),
    );
  }
}
