import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/core/functions/handlingdatacontroller.dart';
import 'package:tasknotate/data/datasource/remote/auth/signup.dart';

abstract class SignupController extends GetxController {
  signup();
  goToLogin();
}

class SignupControllerImp extends SignupController {
  Signupdata signupdata = Signupdata(Get.find());
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController username;
  late TextEditingController phone;
  StatusRequest? statusRequest;

  @override
  signup() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      try {
        var response = await signupdata.postData(
            username.text, password.text, email.text, phone.text);

        print("Response: $response");

        statusRequest = handlingData(response);

        if (StatusRequest.success == statusRequest) {
          if (response['status'] == "success") {
            Get.offNamed(AppRoute.verifyCodeSignup,
                arguments: {"email": email.text});
          } else {
            String errorMsg =
                response['message'] ?? "Phone or email already exists";
            Get.defaultDialog(title: "Warning", middleText: errorMsg);
            statusRequest = StatusRequest.failure;
          }
        } else {
          Get.defaultDialog(
              title: "Error", middleText: "Server error. Please try again.");
        }
      } catch (e) {
        Get.defaultDialog(
            title: "Error", middleText: "Connection error: ${e.toString()}");
        statusRequest = StatusRequest.serverfailure;
      }

      update();
    }
  }

  @override
  goToLogin() {
    Get.offNamed(AppRoute.home);
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    username = TextEditingController();
    phone = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    username.dispose();
    phone.dispose();
    super.dispose();
  }
}
