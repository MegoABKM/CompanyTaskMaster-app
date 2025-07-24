import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/employee/homeemployee/viewcompany_controller.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';

class ImageCompany extends GetView<ViewcompanyEmployeeController> {
  final CompanyModel companyModel;
  const ImageCompany({super.key, required this.companyModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.appTheme.colorScheme.primary.withOpacity(0.2),
      ),
      child: ClipOval(
        child: companyModel.companyImage == "Not Set"
            ? Icon(Icons.business,
                size: context.scaleConfig.scale(100),
                color: context.appTheme.colorScheme.onPrimary)
            : Image.network(
                controller.getCompanyImageUrl(companyModel.companyImage!),
                height: context.scaleConfig.scale(100),
                width: context.scaleConfig.scale(100),
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) => progress == null
                    ? child
                    : CircularProgressIndicator(
                        strokeWidth: context.scaleConfig.scale(2)),
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.error, size: context.scaleConfig.scale(100)),
              ),
      ),
    );
  }
}
