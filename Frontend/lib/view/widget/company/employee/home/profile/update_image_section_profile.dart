import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/employee/homeemployee/profile/updateprofileemployee_controller.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class UpdateImageSectionProfile
    extends GetView<ProfileUpdateEmployeeController> {
  const UpdateImageSectionProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.pickImage,
      child: Center(
        child: ClipOval(
          child: controller.pickedImage != null
              ? Image.file(
                  File(controller.pickedImage!.path),
                  width: context.scaleConfig.scale(120),
                  height: context.scaleConfig.scale(120),
                  fit: BoxFit.cover,
                )
              : controller.userModel?.usersImage != null &&
                      controller.userModel?.usersImage != ''
                  ? Image.network(
                      controller.getCompanyImageUrl(
                          controller.userModel!.usersImage!),
                      width: context.scaleConfig.scale(120),
                      height: context.scaleConfig.scale(120),
                      fit: BoxFit.cover,
                    )
                  : Icon(
                      Icons.account_circle,
                      size: context.scaleConfig.scale(120),
                      color: Colors.grey[300],
                    ),
        ),
      ),
    );
  }
}
