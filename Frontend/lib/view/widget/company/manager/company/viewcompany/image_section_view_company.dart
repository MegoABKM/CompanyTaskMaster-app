import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/crudcompany/viewcompany_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/data/model/company/companymodel.dart';

class ImageSectionViewCompany extends GetView<ViewcompanyController> {
  final CompanyModel companyModel;
  const ImageSectionViewCompany(this.companyModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
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
                  height: context.scaleConfig.scale(150),
                  width: context.scaleConfig.scale(150),
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) => progress == null
                      ? child
                      : SizedBox(
                          height: context.scaleConfig.scale(150),
                          child: const CircularProgressIndicator()),
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.error, size: context.scaleConfig.scale(100)),
                ),
        ),
      ),
    );
  }
}
