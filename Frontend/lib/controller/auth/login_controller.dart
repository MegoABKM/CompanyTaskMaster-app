import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/constant/routes.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/core/functions/savecachedata.dart';
import 'package:companymanagment/core/services/services.dart';
import 'package:companymanagment/data/datasource/remote/auth/login.dart';

abstract class LoginController extends GetxController {
  login();
  goToSignup();
  goToForgetPassword();
}

class LoginControllerImp extends LoginController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  LoginData loginData = LoginData(Get.find());
  late TextEditingController email;
  late TextEditingController password;
  bool valuebool = true;
  bool emailstatus = false;
  bool googlestatus = false;
  MyServices myServices = Get.find();
  StatusRequest? statusRequest;

  @override
  login() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await loginData.postData(email.text, password.text);
      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          if (response['data']['users_approve'] == 1) {
            await saveUserData(response['data']);

            String? userRole =
                myServices.sharedPreferences.getString("userrole");

            if (userRole == "manager") {
              myServices.sharedPreferences.setString("step", "3");
              Get.offAllNamed(AppRoute.managerhome);
            } else if (userRole == "employee") {
              myServices.sharedPreferences.setString("step", "3");
              Get.offAllNamed(AppRoute.employeehome);
            } else {
              Get.offAllNamed(AppRoute.companyhome);
            }
          } else {
            Get.toNamed(AppRoute.verifyCodeSignup,
                arguments: {"email": email.text});
          }
        } else {
          Get.defaultDialog(
              title: "warning", middleText: "Email Or Password Wrong");
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    }
  }

  changeObsecure() {
    valuebool = valuebool == true ? false : true;
    update();
    print("Changed=================");
  }

  @override
  goToSignup() {
    Get.toNamed(AppRoute.signUp);
  }

  @override
  goToForgetPassword() {
    Get.toNamed(AppRoute.forgetPassword);
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  switcher(String val) {
    if (val == "email") {
      if (emailstatus) {
        emailstatus = false;
      } else {
        emailstatus = true;
      }

      update();
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
