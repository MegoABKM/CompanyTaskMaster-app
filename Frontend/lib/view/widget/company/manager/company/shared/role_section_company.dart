import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class RoleSectionCompany extends StatelessWidget {
  final dynamic controller; // Can be Create or Update controller
  const RoleSectionCompany({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: controller.selectedRole,
      items: controller.roles.map<DropdownMenuItem<String>>((String roleKey) {
        // Changed 'role' to 'roleKey' for clarity
        return DropdownMenuItem<String>(
          value: roleKey, // The value remains the key (e.g., "194")
          child: Text(
            roleKey.tr, // THE FIX: Translate the key here
            style: TextStyle(fontSize: context.scaleConfig.scaleText(16)),
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        controller.selectRole(newValue);
      },
      decoration: InputDecoration(
        labelText: "190".tr, // Company Role
        hintText: "191".tr, // Select a role
        prefixIcon: const Icon(Icons.work_outline),
      ),
      validator: (value) => value == null ? "please_select_role".tr : null,
    );
  }
}
