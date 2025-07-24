import 'package:companymanagment/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:companymanagment/controller/auth/signup_controller.dart';
import 'package:companymanagment/core/class/handlingdataauthview.dart';
import 'package:companymanagment/core/constant/imageasset.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/core/functions/alertexitapp.dart';
import 'package:companymanagment/core/functions/validinput.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_button_auth.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_text_form_auth.dart';
import 'package:companymanagment/view/widget/auth/shared/terms_and_condition.dart';
import 'package:companymanagment/view/widget/auth/shared/text_sign_up.dart';
import 'package:companymanagment/view/widget/auth/shared/auth_title.dart';
import 'package:companymanagment/view/widget/auth/shared/brand_identity.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: alertExitApp,
        child: GetBuilder<SignupControllerImp>(
          builder: (controller) => HandlingDataAuthview(
            statusRequest: controller.statusRequest,
            widget: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildHeader(context),
                _buildFormCard(context, controller),
              ].animate(interval: 100.ms).fade(duration: 500.ms),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    return Container(
      padding: EdgeInsets.only(
        top: scale.scale(40), // Adjusted for back button
        bottom: scale.scale(50),
        left: scale.scale(24),
        right: scale.scale(24),
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        image: DecorationImage(
          image: const AssetImage(
              AppImageAsset.loginimage), // Use same image for consistency
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            theme.colorScheme.primary.withOpacity(0.6),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.back(),
            ),
          ),
          SizedBox(height: scale.scale(10)),
          // Pass Colors.white to the header widgets to make them visible
          const BrandIdentity(color: Colors.white),
          SizedBox(height: scale.scale(16)),
          AuthTitle(
            title: "21".tr, // Create Account
            subtitle: "22".tr, // Complete the form to get started
            titleColor: Colors.white,
            subtitleColor: Colors.white.withOpacity(0.8),
          ),
        ],
      ).animate().slideY(begin: -0.2, duration: 400.ms, curve: Curves.easeOut),
    );
  }

  Widget _buildFormCard(BuildContext context, SignupControllerImp controller) {
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    return Transform.translate(
      offset: Offset(0, -scale.scale(30)),
      child: Container(
        padding: EdgeInsets.all(scale.scale(24)),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            Form(
              key: controller.formstate,
              child: Column(
                children: [
                  Customtextformauth(
                    isNumber: false,
                    validator: (val) => validInput(val!, 2, 30, 'username'),
                    mycontroller: controller.username,
                    texthint: "24".tr,
                    label: "25".tr,
                    iconData: Icons.person_outline,
                  ),
                  SizedBox(height: scale.scale(20)),
                  Customtextformauth(
                    isNumber: false,
                    validator: (val) => validInput(val!, 5, 100, 'email'),
                    mycontroller: controller.email,
                    texthint: "26".tr,
                    label: "27".tr,
                    iconData: Icons.email_outlined,
                  ),
                  SizedBox(height: scale.scale(20)),
                  Customtextformauth(
                    isNumber: true,
                    validator: (val) => validInput(val!, 5, 40, 'phone'),
                    mycontroller: controller.phone,
                    texthint: "28".tr,
                    label: "29".tr,
                    iconData: Icons.phone_outlined,
                  ),
                  SizedBox(height: scale.scale(20)),
                  Customtextformauth(
                    isNumber: false,
                    validator: (val) => validInput(val!, 5, 30, 'password'),
                    mycontroller: controller.password,
                    texthint: "30".tr,
                    label: "31".tr,
                    iconData: Icons.lock_outline,
                  ),
                  SizedBox(height: scale.scale(30)),
                  CustomButtonAuth(
                    textbutton: "32".tr,
                    onPressed: controller.signup,
                  ),
                ],
              ),
            ),
            SizedBox(height: scale.scale(30)),
            CustomTextSignupOrSignin(
              text: "33".tr,
              textbutton: "34".tr,
              onTap: () =>
                  Get.offAllNamed(AppRoute.login), // Corrected navigation
            ),
            SizedBox(height: scale.scale(20)),
            const Termsandcondition(),
            SizedBox(height: scale.scale(20)),
          ],
        ),
      ),
    );
  }
}
