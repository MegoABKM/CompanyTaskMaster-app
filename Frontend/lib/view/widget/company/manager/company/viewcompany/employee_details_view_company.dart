import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/crudcompany/viewcompany_controller.dart';
import 'package:tasknotate/core/constant/imageasset.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/data/model/company/companymodel.dart';

class EmployeeDetailsViewCompany extends StatelessWidget {
  final CompanyModel companyModel;
  const EmployeeDetailsViewCompany({super.key, required this.companyModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "205".tr, // Employees (reused from UpdateCompany)
          style: context.appTheme.textTheme.headlineSmall!.copyWith(
              color: context.appTheme.colorScheme.primary,
              fontSize: context.scaleConfig.scaleText(22)),
        ),
        SizedBox(height: context.scaleConfig.scale(10)),
        GetBuilder<ViewcompanyController>(
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
                              child: employee.employeeImage!.isNotEmpty
                                  ? Image.network(
                                      controller.getCompanyprofileImageUrl(
                                          employee.employeeImage!),
                                      height: context.scaleConfig.scale(60),
                                      width: context.scaleConfig.scale(60),
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  employee.employeeName ?? "N/A",
                                  style: context.appTheme.textTheme.bodyLarge!
                                      .copyWith(
                                          color: context
                                              .appTheme.colorScheme.primary,
                                          fontSize: context.scaleConfig
                                              .scaleText(16)),
                                ),
                                Text(
                                  employee.employeeEmail ?? "N/A",
                                  style: context.appTheme.textTheme.bodySmall
                                      ?.copyWith(
                                          fontSize: context.scaleConfig
                                              .scaleText(12)),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => controller
                                .deleteemployeecompany(employee.employeeId!),
                            icon: Icon(Icons.person_remove,
                                color: Colors.red,
                                size: context.scaleConfig.scale(24)),
                            tooltip: "236".tr, // Kick Employee
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Text(
                  "229".tr, // No employees available.
                  style: context.appTheme.textTheme.bodyMedium!.copyWith(
                      color: context.appTheme.colorScheme.secondary,
                      fontSize: context.scaleConfig.scaleText(16)),
                ),
        ),
      ],
    );
  }
}
