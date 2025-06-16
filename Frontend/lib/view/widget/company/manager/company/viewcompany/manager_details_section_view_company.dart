import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/crudcompany/viewcompany_controller.dart';
import 'package:tasknotate/core/constant/imageasset.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/data/model/company/companymodel.dart';

class ManagerDetailsSectionViewCompany extends GetView<ViewcompanyController> {
  final CompanyModel companyModel;
  const ManagerDetailsSectionViewCompany(
      {super.key, required this.companyModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "220".tr, // Manager (reused from ProfileManagerPage)
          style: context.appTheme.textTheme.headlineSmall!.copyWith(
              color: context.appTheme.colorScheme.primary,
              fontSize: context.scaleConfig.scaleText(22)),
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
                Container(
                  height: context.scaleConfig.scale(60),
                  width: context.scaleConfig.scale(60),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: context.appTheme.colorScheme.primary
                            .withOpacity(0.2)),
                  ),
                  child: ClipOval(
                    child: companyModel.manager!.managerImage!.isNotEmpty
                        ? Image.network(
                            controller.getCompanyprofileImageUrl(
                                companyModel.manager!.managerImage!),
                            height: context.scaleConfig.scale(60),
                            width: context.scaleConfig.scale(60),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                              AppImageAsset.managerimage,
                              height: context.scaleConfig.scale(60),
                              width: context.scaleConfig.scale(60),
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset(
                            AppImageAsset.managerimage,
                            height: context.scaleConfig.scale(60),
                            width: context.scaleConfig.scale(60),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(width: context.scaleConfig.scale(16)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      companyModel.manager!.managerName?.toString() ?? "N/A",
                      style: context.appTheme.textTheme.bodyLarge!.copyWith(
                          color: context.appTheme.colorScheme.primary,
                          fontSize: context.scaleConfig.scaleText(16)),
                    ),
                    Text(
                      "220".tr, // Manager
                      style: context.appTheme.textTheme.bodySmall?.copyWith(
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
