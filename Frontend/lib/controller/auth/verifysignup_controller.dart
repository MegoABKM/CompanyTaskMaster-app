import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/constant/routes.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/data/datasource/remote/auth/verifycode.dart';

abstract class VerifySignupController extends GetxController {
  checkemail();
}

class VerifySignupControllerImp extends VerifySignupController {
  VerifyCodeSignupData verifycodedata = VerifyCodeSignupData(Get.find());
  String? email;
  late String verifycode;
  StatusRequest? statusRequest;
  @override
  checkemail() async {
    statusRequest = StatusRequest.loading;
    update();
    print("=================verifycode is ${verifycode}");
    var respone = await verifycodedata.postData(email!, verifycode);
    print("=============================Controller $respone");

    statusRequest = handlingData(respone);

    if (StatusRequest.success == statusRequest) {
      if (respone['status'] == "success") {
        // data.addAll(respone['data']);
        Get.offNamed(AppRoute.successSignup);
      } else {
        Get.defaultDialog(
            title: "warning", middleText: "verify code is not correct");
      }
    }
    update();
  }

  resend(BuildContext context) async {
    verifycodedata.resend(email!);
    Get.rawSnackbar(
        messageText: Text("verify code has been sent"),
        backgroundColor: Theme.of(context).colorScheme.primary);
  }

  @override
  void onInit() {
    email = Get.arguments["email"];
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
