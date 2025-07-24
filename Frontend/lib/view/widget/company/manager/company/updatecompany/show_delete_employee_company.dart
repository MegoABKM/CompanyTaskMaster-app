import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';

class ShowDeleteEmployeeCompany extends StatelessWidget {
  final controller;
  const ShowDeleteEmployeeCompany({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Employees List
        Text(
          "205".tr, // Employees
          style: context.appTheme.textTheme.titleMedium
              ?.copyWith(fontSize: context.scaleConfig.scaleText(18)),
        ),
        SizedBox(height: context.scaleConfig.scale(10)),
        if (controller.companyData?.employees != null &&
            controller.companyData!.employees!.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            itemCount: controller.companyData!.employees!.length,
            itemBuilder: (context, index) {
              Employees employee = controller.companyData!.employees![index];
              return ListTile(
                title: Text(
                  employee.employeeName!,
                  style: TextStyle(fontSize: context.scaleConfig.scaleText(16)),
                ),
                subtitle: Text(
                  employee.employeeEmail!,
                  style: TextStyle(fontSize: context.scaleConfig.scaleText(14)),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon:
                          Icon(Icons.edit, size: context.scaleConfig.scale(24)),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.delete,
                          size: context.scaleConfig.scale(24)),
                      onPressed: () {},
                    ),
                  ],
                ),
              );
            },
          )
        else
          Center(
            child: Text(
              "206".tr, // No employees added yet
              style: TextStyle(fontSize: context.scaleConfig.scaleText(16)),
            ),
          ),
      ],
    );
  }
}
