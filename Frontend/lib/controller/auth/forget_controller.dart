import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/core/functions/handlingdatacontroller.dart';
import 'package:tasknotate/data/datasource/remote/auth/forgetpassword.dart';

abstract class ForgetController extends GetxController {
  checkemail();
}

class ForgetControllerImp extends ForgetController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  ForgetpasswordData forgetpasswordData = ForgetpasswordData(Get.find());
  late TextEditingController email;
  StatusRequest? statusRequest;

  @override
  checkemail() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var respone = await forgetpasswordData.postData(email.text);

      print("=============================Controller $respone");

      statusRequest = handlingData(respone);

      print("==============controller${statusRequest}");

      if (StatusRequest.success == statusRequest) {
        if (respone['status'] == "success") {
          Get.toNamed(AppRoute.verifyCode, arguments: {"email": email.text});
        } else {
          Get.defaultDialog(title: "warning", middleText: "Email Not Exists");
          statusRequest = StatusRequest.failure;
        }
      }

      update();
    } else {}
  }

  @override
  void onInit() {
    email = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();

    super.dispose();
  }
}
