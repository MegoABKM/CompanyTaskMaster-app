import 'package:get/get.dart';
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/core/functions/handlingdatacontroller.dart';
import 'package:tasknotate/core/services/services.dart';
import 'package:tasknotate/data/datasource/remote/company/profile_data.dart';
import 'package:tasknotate/data/model/company/usermodel.dart';
import 'package:tasknotate/data/datasource/remote/linkapi.dart';
import 'package:tasknotate/view/screen/company/manager/homemanager/profile/updateprofilemanagerpage.dart';

class ViewProfileManagerController extends GetxController {
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

  goToUpdateProfile() {
    Get.to(const UpdateProfilePage(), arguments: {"usermodel": userModel});
  }

  // Construct the full image URL
  String getCompanyImageUrl(String imageName) {
    return '${AppLink.imageprofileplace}$imageName';
  }

  void fetchUserProfile() async {
    statusRequest = StatusRequest.loading;
    update();

    Map<String, dynamic> response = await profileData.getDataManager(userid);

    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        // Here, 'data' is a List, so we access the first element
        if (response["data"] is List && response["data"].isNotEmpty) {
          // Assuming only one user is returned and you want to use the first one
          userModel = UserModel.fromJson(response["data"][0]);
        } else {
          userModel = null;
          Get.snackbar("Error", "User data is empty");
        }
      } else {
        userModel = null;
        Get.snackbar("Error", "Failed to load profile");
      }
      update();
    } else {
      Get.snackbar("Error", "An error occurred while fetching data");
    }
  }
}
