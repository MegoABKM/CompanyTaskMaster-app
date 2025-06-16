import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/auth/signup_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/core/functions/validinput.dart';
import 'package:tasknotate/view/widget/auth/shared/custom_button_auth.dart';
import 'package:tasknotate/view/widget/auth/shared/custom_text_form_auth.dart';

class TextFormFieldsSignup extends GetView<SignupControllerImp> {
  const TextFormFieldsSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: context.scaleConfig.scale(4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.scaleConfig.scale(15)),
      ),
      child: Padding(
        padding: EdgeInsets.all(context.scaleConfig.scale(10)),
        child: Form(
          key: controller.formstate,
          child: Column(
            children: [
              Customtextformauth(
                isNumber: false,
                validator: (val) => validInput(val!, 2, 30, 'username'),
                mycontroller: controller.username,
                texthint: "24".tr,
                label: "25".tr,
                iconData: Icons.person,
              ),
              Customtextformauth(
                isNumber: false,
                validator: (val) => validInput(val!, 5, 100, 'email'),
                mycontroller: controller.email,
                texthint: "26".tr,
                label: "27".tr,
                iconData: Icons.email_outlined,
              ),
              Customtextformauth(
                isNumber: true,
                validator: (val) => validInput(val!, 5, 40, 'phone'),
                mycontroller: controller.phone,
                texthint: "28".tr,
                label: "29".tr,
                iconData: Icons.phone,
              ),
              Customtextformauth(
                isNumber: false,
                validator: (val) => validInput(val!, 5, 30, 'password'),
                mycontroller: controller.password,
                texthint: "30".tr,
                label: "31".tr,
                iconData: Icons.lock_outlined,
              ),
              CustomButtonAuth(
                textbutton: "32".tr,
                onPressed: () async {
                  await controller.signup();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
