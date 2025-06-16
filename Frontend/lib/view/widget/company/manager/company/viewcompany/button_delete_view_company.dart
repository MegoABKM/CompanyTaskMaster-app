import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/crudcompany/viewcompany_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/data/model/company/companymodel.dart';

class ButtonDeleteViewCompany extends GetView<ViewcompanyController> {
  final CompanyModel companyModel;
  const ButtonDeleteViewCompany({super.key, required this.companyModel});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.scaleConfig.scale(10))),
      color: Colors.red,
      padding: EdgeInsets.symmetric(
          horizontal: context.scaleConfig.scale(100),
          vertical: context.scaleConfig.scale(15)),
      onPressed: () {
        Get.defaultDialog(
          title: "232".tr, // Confirm Deletion
          middleText: "233".tr, // Are you sure you want to delete this company?
          textConfirm: "234".tr, // Yes
          textCancel: "235".tr, // No
          confirmTextColor: Colors.white,
          cancelTextColor: Colors.red,
          buttonColor: Colors.red,
          onConfirm: () {
            controller.deletecompany(companyModel.companyId!);
            Get.back();
          },
          onCancel: () {},
        );
      },
      child: Text(
        "231".tr, // DELETE COMPANY
        style: context.appTheme.textTheme.bodyLarge!.copyWith(
            color: context.appTheme.colorScheme.onSecondary,
            fontSize: context.scaleConfig.scaleText(16)),
      ),
    );
  }
}
