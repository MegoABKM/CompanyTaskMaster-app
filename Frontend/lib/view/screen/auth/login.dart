import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:companymanagment/controller/auth/login_controller.dart';
import 'package:companymanagment/core/class/handlingdataauthview.dart';
import 'package:companymanagment/core/constant/imageasset.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/core/functions/alertexitapp.dart';
import 'package:companymanagment/core/functions/validinput.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_button_auth.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_text_form_auth.dart';
import 'package:companymanagment/view/widget/auth/shared/text_sign_up.dart';
import 'package:companymanagment/view/widget/auth/shared/auth_title.dart';
import 'package:companymanagment/view/widget/auth/shared/brand_identity.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    // The controller is now initialized by the routing system (bindings),
    // so we can safely find it here.

    return Scaffold(
      body: WillPopScope(
        onWillPop: alertExitApp,
        child: GetBuilder<LoginControllerImp>(
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
        top: scale.scale(60),
        bottom: scale.scale(50),
        left: scale.scale(24),
        right: scale.scale(24),
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        image: DecorationImage(
          image: const AssetImage(AppImageAsset.loginimage),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            theme.colorScheme.primary.withOpacity(0.6),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        children: [
          // Pass Colors.white to the header widgets
          const BrandIdentity(color: Colors.white),
          SizedBox(height: scale.scale(16)),
          AuthTitle(
            title: "11".tr, // Welcome Back
            subtitle: "34".tr, // Sign in to access your dashboard
            titleColor: Colors.white,
            subtitleColor: Colors.white.withOpacity(0.8),
          ),
        ],
      ).animate().slideY(begin: -0.2, duration: 400.ms, curve: Curves.easeOut),
    );
  }

  Widget _buildFormCard(BuildContext context, LoginControllerImp controller) {
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
                    validator: (val) => validInput(val!, 5, 100, 'email'),
                    mycontroller: controller.email,
                    texthint: "13".tr, // Enter your email
                    label: "14".tr, // Email
                    iconData: Icons.email_outlined,
                  ),
                  SizedBox(height: scale.scale(20)),
                  GetBuilder<LoginControllerImp>(
                    builder: (logic) => Customtextformauth(
                      onTapIcon: logic.changeObsecure,
                      obscureText: logic.valuebool,
                      isNumber: false,
                      validator: (val) => validInput(val!, 5, 30, "password"),
                      mycontroller: controller.password,
                      texthint: "15".tr, // Enter your password
                      label: "16".tr, // Password
                      iconData: Icons.lock_outline,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(top: scale.scale(10)),
                    child: InkWell(
                      onTap: controller.goToForgetPassword,
                      child: Text(
                        "17".tr, // Forgot Password?
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: theme.colorScheme.primary),
                      ),
                    ),
                  ),
                  SizedBox(height: scale.scale(30)),
                  CustomButtonAuth(
                    textbutton: "18".tr, // Sign In
                    onPressed: controller.login,
                  ),
                ],
              ),
            ),
            SizedBox(height: scale.scale(30)),
            CustomTextSignupOrSignin(
              text: "19".tr, // Don't have an account?
              textbutton: "20".tr, // Sign Up
              onTap: controller.goToSignup,
            ),
          ],
        ),
      ),
    );
  }
}
