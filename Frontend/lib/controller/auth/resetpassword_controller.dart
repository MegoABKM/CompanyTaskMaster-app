import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/core/functions/handlingdatacontroller.dart';
import 'package:tasknotate/data/datasource/remote/auth/resetpassword.dart';

abstract class ResetController extends GetxController {
  resetpassword();
}

class ResetControllerImp extends ResetController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  ResetPasswordData resetPasswordData = ResetPasswordData(Get.find());
  late TextEditingController password;
  late TextEditingController repassword;
  late String email;
  StatusRequest? statusRequest;
  @override
  resetpassword() async {
    if (formstate.currentState!.validate()) {
      if (password.text == repassword.text) {
        statusRequest = StatusRequest.loading;
        update();
        var response = await resetPasswordData.postData(email, password.text);
        statusRequest = handlingData(response);

        print("==============controller${statusRequest}");

        if (StatusRequest.success == statusRequest) {
          if (response['status'] == "success") {
            // data.addAll(respone['data']);
            Get.offNamed(AppRoute.successReset);
          } else {
            Get.defaultDialog(
                title: "warning",
                middleText: "The Password Is The Same As Old, Change It");
            statusRequest = StatusRequest.failure;
          }
        }
      } else {
        Get.defaultDialog(
            title: "warning", middleText: "The Password Not Match");
      }
    }
  }

  @override
  void onInit() {
    password = TextEditingController();
    repassword = TextEditingController();
    email = Get.arguments["email"];
    super.onInit();
  }

  @override
  void dispose() {
    password.dispose();
    repassword.dispose();
    super.dispose();
  }
}
