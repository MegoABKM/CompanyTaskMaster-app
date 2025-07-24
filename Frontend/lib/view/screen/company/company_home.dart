import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/homecompany_controller.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/view/widget/company/homecompany/button_procced_company.dart';
import 'package:companymanagment/view/widget/company/homecompany/role_tile_company.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CompanyHome extends StatelessWidget {
  const CompanyHome({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(CompanyHomeController());
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "71".tr, // "Select Your Role"
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: scale.scaleText(22),
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onBackground,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: scale.scale(20),
            vertical: scale.scale(10),
          ),
          child: Column(
            children: [
              Text(
                "72".tr, // "How will you be using Injaz today?"
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall!.copyWith(
                  fontSize: scale.scaleText(26),
                  color: theme.colorScheme.onBackground,
                ),
              ),
              SizedBox(height: scale.scale(16)),
              Text(
                "77".tr, // "You can change this later in the settings."
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                  fontSize: scale.scaleText(15),
                ),
              ),
              SizedBox(height: scale.scale(20)),
              Expanded(
                child: GetBuilder<CompanyHomeController>(
                  builder: (controller) => GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: scale.scale(16),
                    mainAxisSpacing: scale.scale(16),
                    childAspectRatio: 0.85,
                    children: [
                      RoleTileCompany(
                        title: "73".tr, // "Manager"
                        subtitle: "74".tr, // "Create & manage"
                        icon: Icons.business_center_outlined,
                        roleKey: "manager",
                        isSelected: controller.selectedRole == "manager",
                      ),
                      RoleTileCompany(
                        title: "75".tr, // "Employee"
                        subtitle: "76".tr, // "Join & work"
                        icon: Icons.person_outline_rounded,
                        roleKey: "employee",
                        isSelected: controller.selectedRole == "employee",
                      ),
                    ].animate(interval: 100.ms).fade(duration: 400.ms).slideX(
                        begin: 0.2, duration: 400.ms, curve: Curves.easeOut),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: scale.scale(16)),
                child: const ButtonProccedCompany(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
