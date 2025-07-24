import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/core/services/services.dart';
import 'package:companymanagment/data/datasource/remote/company/manager/company_data.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';
import 'package:companymanagment/data/datasource/remote/linkapi.dart';

class UpdatecompanyController extends GetxController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController companyname;
  late TextEditingController companynickid;
  late TextEditingController companydescription;

  int selectedIndex = -1;
  final List<String> options = ["1-10", "11-50", "51-200"];
  final List<String> roles = [
    "194".tr,
    "195".tr,
    "196".tr,
    "197".tr,
    "198".tr,
    "199".tr,
    "200".tr,
    "201".tr,
    "202".tr,
  ];
  String? companyworkers;
  String? selectedRole;
  CompanyModel? companyData;

  File? logoImage;
  final ImagePicker picker = ImagePicker();
  String? imageURL;

  MyServices myServices = Get.find();
  CompanyData updateCompanyData = CompanyData(Get.find());
  StatusRequest? statusRequest;

  void selectOption(int index) {
    selectedIndex = index;
    companyworkers = options[index];
    update();
  }

  void selectRole(String? role) {
    selectedRole = role;
    update();
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      logoImage = File(pickedFile.path);
      update();
    }
  }

  Future<void> uploadImage() async {
    if (logoImage == null) return;
    var uri = Uri.parse(AppLink.imageStatic);
    var request = http.MultipartRequest('POST', uri);
    var stream = http.ByteStream(logoImage!.openRead());
    var length = await logoImage!.length();
    String fileExtension = logoImage!.path.split('.').last;

    var multipartFile = http.MultipartFile('image', stream, length,
        filename: logoImage!.path.split('/').last,
        contentType: MediaType('image', fileExtension));
    request.files.add(multipartFile);

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseBody);
      if (responseJson['status'] == 'success') {
        imageURL = responseJson['filename'];
      } else {
        throw Exception(responseJson['message'] ?? "Image upload failed.");
      }
    } else {
      throw Exception("Server error during image upload.");
    }
  }

  Future<void> updateData() async {
    if (!formstate.currentState!.validate()) {
      return;
    }
    statusRequest = StatusRequest.loading;
    update();

    try {
      if (logoImage != null) {
        await uploadImage();
      }

      var response = await updateCompanyData.updateData(
        companyname.text,
        companynickid.text, // This is read-only, but still needs to be sent
        companydescription.text,
        imageURL ?? companyData!.companyImage!,
        companyworkers ?? companyData!.companyWorkes ?? "",
        selectedRole ?? companyData!.companyJob ?? "",
        companyData!.companyId!,
      );

      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success &&
          response['status'] == "success") {
        Get.snackbar("Success", "Company updated successfully.");
        // Go back and signal a refresh
        Get.back(result: true);
      } else {
        throw Exception(response['message'] ?? 'Failed to update company.');
      }
    } catch (e) {
      statusRequest = StatusRequest.failure;
      Get.defaultDialog(
          title: "Error",
          middleText: e.toString().replaceFirst('Exception: ', ''));
    } finally {
      update();
    }
  }

  @override
  void onInit() {
    companyData = Get.arguments['companydata'];
    companyname = TextEditingController(text: companyData?.companyName ?? "");
    companynickid =
        TextEditingController(text: companyData?.companyNickID ?? "");
    companydescription =
        TextEditingController(text: companyData?.companyDescription ?? "");
    selectedRole = companyData?.companyJob;
    companyworkers = companyData?.companyWorkes;
    if (companyworkers != null) {
      selectedIndex = options.indexOf(companyworkers!);
    }
    super.onInit();
  }

  @override
  void dispose() {
    companyname.dispose();
    companynickid.dispose();
    companydescription.dispose();
    super.dispose();
  }
}
