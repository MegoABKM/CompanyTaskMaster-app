import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/employee/homeemployee/viewcompany_controller.dart';
import 'package:companymanagment/core/constant/imageasset.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';

class EmployeeCompany extends StatelessWidget {
  final CompanyModel companyModel;
  const EmployeeCompany({super.key, required this.companyModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "205".tr, // Employees
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: context.appTheme.colorScheme.primary,
              fontSize: context.scaleConfig.scaleText(20)),
        ),
        SizedBox(height: context.scaleConfig.scale(10)),
        GetBuilder<ViewcompanyEmployeeController>(
          builder: (controller) => companyModel.employees != null &&
                  companyModel.employees!.isNotEmpty
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: companyModel.employees!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final employee = companyModel.employees![index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: context.scaleConfig.scale(8)),
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  employee.employeeName ??
                                      "350".tr, // Unknown Employee
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: context
                                              .appTheme.colorScheme.primary,
                                          fontSize: context.scaleConfig
                                              .scaleText(16)),
                                ),
                                Text(
                                  employee.employeeEmail ??
                                      "223".tr, // No Role -> None
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          fontSize: context.scaleConfig
                                              .scaleText(12)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Text(
                  "229".tr, // No employees available
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: context.appTheme.colorScheme.secondary,
                      fontSize: context.scaleConfig.scaleText(16)),
                ),
        ),
      ],
    );
  }
}
