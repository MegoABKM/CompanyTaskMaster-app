import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/tasks/managerhome_controller.dart';
import 'package:tasknotate/core/constant/appthemes.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/data/datasource/remote/linkapi.dart';
import 'package:tasknotate/data/model/company/companymodel.dart';

import '../../../../../../core/constant/routes.dart';

class ListCompanySection extends GetView<ManagerhomeController> {
  final CompanyModel company;
  const ListCompanySection({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(AppRoute.workspace, arguments: {
        "companyid": company.companyId,
        "companyemployee": company.employees,
      }),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: context.scaleConfig.scale(10)),
        decoration: BoxDecoration(
          color: context.appTheme.cardColor,
          borderRadius: BorderRadius.circular(context.scaleConfig.scale(10)),
          boxShadow: const [AppThemes.cardBoxShadow],
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              "${AppLink.imageplaceserver}${company.companyImage ?? 'default.png'}",
            ),
          ),
        ),
        child: Container(
          alignment: Alignment.bottomLeft,
          child: ListTile(
            title: Text(
              company.companyName ?? "No Name",
              style: context.appTheme.textTheme.titleLarge?.copyWith(
                fontSize: context.scaleConfig.scaleText(18),
              ),
            ),
            subtitle: Text(
              "${company.companyWorkes ?? "0"} employees",
              style: context.appTheme.textTheme.bodyMedium?.copyWith(
                fontSize: context.scaleConfig.scaleText(14),
              ),
            ),
            trailing: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(context.scaleConfig.scale(5)),
              ),
              onPressed: () => controller.goToDetailsCompany(company),
              color: context.appTheme.colorScheme.secondary,
              child: Text(
                "82".tr,
                style: context.appTheme.textTheme.bodySmall!.copyWith(
                  color: context.appTheme.colorScheme.onPrimary,
                  fontSize: context.scaleConfig.scaleText(12),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
