import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/core/functions/savecachedata.dart';
import 'package:tasknotate/core/services/services.dart';
import 'package:tasknotate/data/datasource/remote/auth/createprofilegoogle.dart';

abstract class CreateprofileGoogleController extends GetxController {
  googlesignup();
}

class CreateprofileGoogleControllerImp extends CreateprofileGoogleController {
  ProfileSignupData profileSignupData = ProfileSignupData(Get.find());
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController username;
  late TextEditingController phone;
  String? email;
  StatusRequest? statusRequest;
  MyServices myServices = Get.find();

  @override
  googlesignup() async {
    if (!formstate.currentState!.validate()) {
      Get.defaultDialog(
        title: "Validation Error",
        middleText: "Please fill in all required fields",
      );
      return;
    }

    try {
      statusRequest = StatusRequest.loading;
      update();

      final user = myServices.supabase.auth.currentUser;
      if (user == null || user.email == null) {
        throw Exception("No authenticated user found");
      }

      final response = await profileSignupData.postData(
        username.text,
        user.email!,
        phone.text,
      );

      if (response == null) {
        throw Exception("No response from server");
      }

      if (response['status'] == "success" && response['data'] != null) {
        await saveUserData(response['data']);
        Get.offAllNamed(AppRoute.companyhome);
      } else if (response['status'] == "failure") {
        Get.defaultDialog(
          title: "Registration Error",
          middleText: response['message'] ?? "Unknown error",
        );
      } else {
        throw Exception("Invalid server response");
      }
    } catch (error, stack) {
      print('Profile Creation Error: $error\n$stack');
      Get.defaultDialog(
        title: "Registration Error",
        middleText: error.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      statusRequest = null;
      update();
    }
  }

  @override
  void onInit() {
    email = Get.arguments?['email'];
    username = TextEditingController();
    phone = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    phone.dispose();
    super.dispose();
  }
}
