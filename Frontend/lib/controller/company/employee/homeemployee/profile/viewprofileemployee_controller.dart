import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/constant/routes.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/core/services/services.dart';
import 'package:companymanagment/data/datasource/remote/company/profile_data.dart';
import 'package:companymanagment/data/model/company/usermodel.dart';
import 'package:companymanagment/data/datasource/remote/linkapi.dart';
import 'package:companymanagment/view/screen/company/employee/homeemployee/profile/update_profile_employee.dart';

class ViewProfileEmployeeController extends GetxController {
  UserModel? userModel;
  StatusRequest? statusRequest;
  MyServices myServices = Get.find();
  ProfileData profileData = ProfileData(Get.find());
  String? userid;

  @override
  void onInit() {
    userid = myServices.sharedPreferences.getString("id");
    fetchUserProfile();
    super.onInit();
  }

  // UPDATED: Reused the manager's update page, but can be a separate employee update page if needed.
  goToUpdateProfile() {
    Get.to(() => const UpdateProfileEmployeePage(),
        arguments: {"usermodel": userModel});
  }

  // NEW: Sign Out Method for Employee
  void signOut() {
    Get.defaultDialog(
      title: "sign_out".tr,
      middleText: "confirm_sign_out".tr,
      textConfirm: "yes_sign_out".tr,
      textCancel: "cancel".tr,
      confirmTextColor: Colors.white,
      onConfirm: () {
        // Remove only user-specific data, not app settings
        myServices.sharedPreferences.remove("id");
        myServices.sharedPreferences.remove("username");
        myServices.sharedPreferences.remove("email");
        myServices.sharedPreferences.remove("phone");
        myServices.sharedPreferences.remove("userrole");
        myServices.sharedPreferences
            .setString("step", "1"); // Go back to login step

        Get.offAllNamed(AppRoute.login);
      },
    );
  }

  String getCompanyImageUrl(String imageName) {
    return '${AppLink.imageprofileplace}$imageName';
  }

  void fetchUserProfile() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await profileData.getDataManager(userid);

    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success &&
        response is Map<String, dynamic>) {
      if (response["status"] == "success") {
        if (response["data"] is List && response["data"].isNotEmpty) {
          userModel = UserModel.fromJson(response["data"][0]);
        } else {
          userModel = null;
        }
      } else {
        userModel = null;
      }
    } else {
      statusRequest = StatusRequest.failure;
    }
    update();
  }
}
