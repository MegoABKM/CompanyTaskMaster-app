import 'package:companymanagment/view/widget/company/manager/company/create/step_3_finalized.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/crudcompany/createcompany_controller.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_button_auth.dart';
import 'package:companymanagment/view/widget/company/manager/company/create/step_1_core_info.dart';
import 'package:companymanagment/view/widget/company/manager/company/create/step_2_profile.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CreateCompany extends StatelessWidget {
  const CreateCompany({super.key});

  @override
  Widget build(BuildContext context) {
    // Use lazyPut in a binding for CreateCompany for better performance

    Get.put(CreatecompanyController());
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    return Scaffold(
      appBar: AppBar(
        title: Text("181".tr), // Create Company
        backgroundColor: theme.colorScheme.background,
        elevation: 0,
      ),
      backgroundColor: theme.colorScheme.background,
      body: GetBuilder<CreatecompanyController>(
        builder: (controller) => Column(
          children: [
            // --- Step Progress Indicator ---
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: scale.scale(24), vertical: scale.scale(16)),
              child: Row(
                children: List.generate(3, (index) {
                  bool isActive = controller.currentStep >= index;
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: scale.scale(4)),
                      height: scale.scale(6),
                      decoration: BoxDecoration(
                        color: isActive
                            ? theme.colorScheme.primary
                            : theme.dividerColor,
                        borderRadius: BorderRadius.circular(scale.scale(10)),
                      ),
                    ),
                  );
                }).animate(interval: 100.ms).fade().slideX(),
              ),
            ),

            // --- Page View for Steps ---
            Expanded(
              child: Form(
                key: controller.formstate,
                child: PageView(
                  controller: controller.pageController,
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable swiping
                  children: const [
                    StepCoreInfo(),
                    StepProfile(),
                    StepFinalize(),
                  ],
                ),
              ),
            ),

            // --- Navigation Buttons ---
            _buildNavigationControls(context, controller),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationControls(
      BuildContext context, CreatecompanyController controller) {
    final scale = context.scaleConfig;
    return Padding(
      padding: EdgeInsets.all(scale.scale(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // "Back" Button
          if (controller.currentStep > 0)
            Expanded(
              // Use Expanded to give it a share of the space
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: controller.previousStep,
                child: Text("back".tr),
              ),
            ),

          if (controller.currentStep > 0)
            SizedBox(width: scale.scale(16)), // Spacer between buttons

          // "Next" or "Create" Button
          Expanded(
            // Use Expanded to make it fill the available space
            child: CustomButtonAuth(
              textbutton: controller.currentStep == 2
                  ? "193".tr
                  : "next".tr, // Create or Next
              onPressed: controller.nextStep,
            ),
          ),
        ],
      ).animate().fade(delay: 200.ms),
    );
  }
}
