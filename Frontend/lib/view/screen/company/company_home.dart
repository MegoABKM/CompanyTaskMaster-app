import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/homecompany_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/view/widget/company/homecompany/button_procced_company.dart';
import 'package:tasknotate/view/widget/company/homecompany/role_tile_company.dart';

class CompanyHome extends StatelessWidget {
  const CompanyHome({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(CompanyHomeController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "71".tr,
          style: context.appTheme.textTheme.titleLarge?.copyWith(
            fontSize: context.scaleConfig.scaleText(20),
          ),
        ),
        elevation: 0,
        backgroundColor: context.appTheme.colorScheme.primary.withOpacity(0.7),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.appTheme.colorScheme.primary.withOpacity(0.05),
              context.appTheme.colorScheme.surface,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.scaleConfig.scale(16),
            vertical: context.scaleConfig.scale(20),
          ),
          child: ListView(
            children: [
              Text(
                "72".tr,
                textAlign: TextAlign.center,
                style: context.appTheme.textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: context.scaleConfig.scaleText(26),
                  color: context.appTheme.colorScheme.primary,
                  letterSpacing: context.scaleConfig.scale(0.5),
                ),
              ),
              SizedBox(height: context.scaleConfig.scale(50)),
              GetBuilder<CompanyHomeController>(
                builder: (controller) => Column(
                  children: [
                    RoleTileCompany(
                      title: "73".tr,
                      subtitle: "74".tr,
                      onTap: () => controller.selectTile("manager"),
                    ),
                    SizedBox(height: context.scaleConfig.scale(12)),
                    RoleTileCompany(
                      title: "75".tr,
                      subtitle: "76".tr,
                      onTap: () => controller.selectTile("employee"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.scaleConfig.scale(20)),
              Text(
                "77".tr,
                style: context.appTheme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color:
                      context.appTheme.colorScheme.onSurface.withOpacity(0.7),
                  fontSize: context.scaleConfig.scaleText(14),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.scaleConfig.scale(20)),
              ButtonProccedCompany(),
              SizedBox(height: context.scaleConfig.scale(20)),
            ],
          ),
        ),
      ),
    );
  }
}
