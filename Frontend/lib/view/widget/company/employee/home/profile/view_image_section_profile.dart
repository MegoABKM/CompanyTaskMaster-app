import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/employee/homeemployee/profile/viewprofileemployee_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class ViewImageSectionProfile extends GetView<ViewProfileEmployeeController> {
  const ViewImageSectionProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipOval(
        child: controller.userModel?.usersImage != null &&
                controller.userModel?.usersImage != ''
            ? Image.network(
                controller
                    .getCompanyImageUrl(controller.userModel!.usersImage!),
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
    );
  }
}
