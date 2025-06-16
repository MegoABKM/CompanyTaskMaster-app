import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/data/datasource/remote/linkapi.dart';
import 'package:tasknotate/data/datasource/remote/company/profile_data.dart';
import 'package:tasknotate/data/model/company/usermodel.dart';
import 'package:tasknotate/core/services/services.dart';

class ProfileUpdateManagerController extends GetxController {
  UserModel? userModel;
  MyServices myServices = Get.find();
  ProfileData profileData = ProfileData(Get.find());

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String? userid;
  XFile? pickedImage;
  String? imageUrl;

  @override
  void onInit() {
    super.onInit();
    userid = myServices.sharedPreferences.getString("id");
    userModel = Get.arguments['usermodel'];

    nameController = TextEditingController(text: userModel!.usersName);
    phoneController =
        TextEditingController(text: userModel!.usersPhone.toString());
    imageUrl = userModel!.usersImage;
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    pickedImage = await picker.pickImage(source: ImageSource.gallery);
    update();
  }

  Future<String?> uploadImage() async {
    if (pickedImage == null) return null;

    var uri = Uri.parse(AppLink.profileUpload);
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll({'Content-Type': 'application/json'});

    var stream = http.ByteStream(pickedImage!.openRead());
    var length = await pickedImage!.length();
    String fileExtension = pickedImage!.path.split('.').last;

    var multipartFile = http.MultipartFile(
      'file',
      stream,
      length,
      filename: pickedImage!.path.split('/').last,
      contentType: MediaType('image', fileExtension),
    );
    request.files.add(multipartFile);

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        print('Response body: $responseBody');

        if (responseBody.isNotEmpty) {
          try {
            var responseJson = jsonDecode(responseBody);
            if (responseJson['status'] == 'success') {
              return responseJson['filename'];
            } else {
              Get.snackbar("Error", "Image upload failed.");
            }
          } catch (e) {
            print('Error decoding JSON: $e');
            Get.snackbar("Error", "Failed to decode server response.");
          }
        } else {
          print('Empty response body.');
          Get.snackbar("Error", "Server returned an empty response.");
        }
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
        Get.snackbar("Error", "Failed to upload image.");
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar("Error", "Unexpected error occurred while uploading image.");
    }

    return null;
  }

  Future<void> deleteOldImage() async {
    if (imageUrl != null && imageUrl != 'null') {
      var uri = Uri.parse(AppLink.profiledelete);
      var response = await http.post(uri, body: {
        'delete_filename': imageUrl!,
      });

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          try {
            var responseJson = jsonDecode(response.body);
            if (responseJson['status'] == 'success') {
              print("Old image deleted successfully.");
            } else {
              Get.snackbar("Error", "Failed to delete old image.");
            }
          } catch (e) {
            print('Error decoding JSON: $e');
            Get.snackbar("Error", "Failed to decode server response.");
          }
        } else {
          print('Empty response body.');
          Get.snackbar("Error", "Server returned an empty response.");
        }
      } else {
        Get.snackbar("Error",
            "Failed to delete old image. Status code: ${response.statusCode}");
      }
    }
  }

  Future<void> saveProfile() async {
    String? newImageUrl = pickedImage != null ? await uploadImage() : null;

    if (pickedImage != null) {
      await deleteOldImage();
    }

    if (newImageUrl == null) {
      newImageUrl = imageUrl;
    }

    try {
      var response = await profileData.updateData(
        userid,
        nameController.text,
        phoneController.text,
        newImageUrl,
      );

      if (response['status'] == 'success') {
        Get.snackbar("Success", "Profile updated successfully!");
        userModel!.usersName = nameController.text;
        userModel!.usersPhone = int.parse(phoneController.text);
        userModel!.usersImage = newImageUrl;
        update();
        Get.offAllNamed(AppRoute.home);
      } else {
        Get.snackbar("Error", "Failed to update profile.");
      }
    } catch (e) {
      print("Error updating profile: $e");
      Get.snackbar("Error", "An error occurred while updating the profile.");
    }
  }

  // Construct the full image URL
  String getCompanyImageUrl(String imageName) {
    return '${AppLink.imageprofileplace}$imageName';
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
