import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/homecompany_controller.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_button_auth.dart';

class ButtonProccedCompany extends GetView<CompanyHomeController> {
  const ButtonProccedCompany({super.key});

  @override
  Widget build(BuildContext context) {
    // We now use the standard, theme-consistent button from our auth flow.
    return CustomButtonAuth(
      textbutton: "78".tr, // "Proceed"
      onPressed: () => controller.goToManagerOrEmployee(),
    );
  }
}
