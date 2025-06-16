import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class RoleSectionCompany extends StatelessWidget {
  final controller;
  const RoleSectionCompany({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "190".tr, // Company Role
          style: context.appTheme.textTheme.titleMedium
              ?.copyWith(fontSize: context.scaleConfig.scaleText(18)),
        ),
        SizedBox(height: context.scaleConfig.scale(5)),
        Card(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(context.scaleConfig.scale(10))),
            child: DropdownButtonFormField<String>(
              value: controller.selectedRole,
              items: controller.roles.map((role) {
                return DropdownMenuItem(
                    value: role,
                    child: Text(role,
                        style: TextStyle(
                            fontSize: context.scaleConfig.scaleText(16))));
              }).toList(),
              onChanged: controller.selectRole,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: context.scaleConfig.scale(15),
                    vertical: context.scaleConfig.scale(15)),
                hintText: "191".tr, // Select a role
                hintStyle: context.appTheme.textTheme.bodyMedium!.copyWith(
                    color: context.appTheme.hintColor,
                    fontSize: context.scaleConfig.scaleText(16)),
              ),
              validator: (value) =>
                  value == null ? "Please select a role" : null,
            )),
      ],
    );
  }
}
