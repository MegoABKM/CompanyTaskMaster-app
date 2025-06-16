// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/core/functions/handlingdatacontroller.dart';
import 'package:tasknotate/core/functions/savecachedata.dart';
import 'package:tasknotate/core/services/services.dart';
import 'package:tasknotate/data/datasource/remote/auth/login.dart';
import 'package:tasknotate/view/screen/auth/sign_up_google.dart';

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
  Future<void> signInWithGoogle() async {
    try {
      statusRequest = StatusRequest.loading;
      update();

      // Clear any existing session to force a fresh sign-in
      final currentSession = myServices.supabase.auth.currentSession;
      if (currentSession != null) {
        await myServices.supabase.auth.signOut();
      }

      // Trigger Google OAuth sign-in
      final authResponse = await myServices.supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'tasknotate://google-auth-callback',
        authScreenLaunchMode: LaunchMode.externalApplication,
        scopes: 'email profile',
      );

      if (!authResponse) {
        throw Exception('Google sign-in failed or was canceled');
      }

      // Wait for the session using polling as a fallback
      Session? session;
      const maxAttempts = 15;
      for (int i = 0; i < maxAttempts; i++) {
        session = myServices.supabase.auth.currentSession;
        if (session != null) break;
        await Future.delayed(const Duration(seconds: 1));
        print('Attempt $i: Waiting for session...');
      }

      if (session == null) {
        throw Exception('No session found after Google sign-in');
      }

      await handleSession(session);
    } catch (error, stackTrace) {
      print('Google Sign-In Error: $error\n$stackTrace');
      statusRequest = StatusRequest.failure;
      update();

      Get.defaultDialog(
        title: "Login Error",
        middleText: error.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<void> handleSession(Session session) async {
    final user = session.user;
    if (user.email == null) {
      throw Exception('No email found in Google session');
    }

    final email = user.email!;
    final name = user.userMetadata?['full_name'] ?? "";

    statusRequest = StatusRequest.loading;
    update();

    // Check backend
    final response = await loginData.checkGoogleToNotCreateProfile(email);
    if (response == null) {
      throw Exception('No response from backend');
    }

    if (response['status'] == "success") {
      if (response['navigate'] == "company" && response['data'] != null) {
        saveUserData(response['data']);
        statusRequest = StatusRequest.success;
        update();
        Get.offAllNamed(AppRoute.companyhome);
      } else if (response['navigate'] == "createprofile") {
        statusRequest = StatusRequest.success;
        update();
        Get.to(() => const SignupGoogle(), arguments: {
          "email": email,
          "name": name,
        });
      } else {
        throw Exception('Invalid navigation response');
      }
    } else {
      throw Exception(response['message'] ?? 'Failed to check user status');
    }
  }

  @override
  login() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await loginData.postData(
        email.text,
        password.text,
      );

      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          if (response['data']['users_approve'] == 1) {
            saveUserData(response['data']);

            Get.offAllNamed(AppRoute.home);
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
    } else {}
  }

  changeObsecure() {
    valuebool = valuebool == true ? false : true;
    update();
    print("Changed=================");
  }

  @override
  goToSignup() {
    Get.offNamed(AppRoute.signUp);
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
