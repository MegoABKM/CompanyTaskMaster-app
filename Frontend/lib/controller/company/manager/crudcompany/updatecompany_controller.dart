import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/core/functions/handlingdatacontroller.dart';
import 'package:tasknotate/core/services/services.dart';
import 'package:tasknotate/data/datasource/remote/company/manager/company_data.dart';
import 'package:tasknotate/data/model/company/companymodel.dart';
import 'package:tasknotate/data/datasource/remote/linkapi.dart';

class UpdatecompanyController extends GetxController {
  // Form-related variables
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController companyname;
  late TextEditingController companynickid;
  late TextEditingController companydescription;
  CompanyData companyDataRequest = CompanyData(Get.find());
  int selectedIndex = -1;
  final List<String> options = ["1-10", "11-50", "51-200"];
  final List<String> roles = [
    "194".tr, // Technology
    "195".tr, // Finance
    "196".tr, // Healthcare
    "197".tr, // Retail
    "198".tr, // Manufacturing
    "199".tr, // Education
    "200".tr, // Logistics
    "201".tr, // Entertainment
    "202".tr, // Consulting
  ];
  String? companyworkers;
  String? selectedRole;
  CompanyModel? companyData;

  // Image picker and upload
  File? logoImage;
  final ImagePicker picker = ImagePicker();
  String? imageURL;

  // User ID and service instances
  String? userid;
  MyServices myServices = Get.find();
  CompanyData updateCompanyData = CompanyData(Get.find());

  // Request status
  StatusRequest? statusRequest;

  // Select number of workers
  void selectOption(int index) {
    selectedIndex = index;
    companyworkers = options[index];
    update();
  }

  // Select company role
  void selectRole(String? role) {
    selectedRole = role;
    update();
  }

  // Pick image from the gallery
  Future<void> pickImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        logoImage = File(pickedFile.path);
        update();
      }
    } catch (e) {
      print("Error picking image: $e");
      Get.snackbar("Error", "Failed to pick image.");
    }
  }

  // Upload the image to the server
  Future<void> uploadImage() async {
    if (logoImage == null) return;

    var uri = Uri.parse(AppLink.imageStatic);
    var request = http.MultipartRequest('POST', uri);

    var stream = http.ByteStream(logoImage!.openRead());
    var length = await logoImage!.length();
    String fileExtension = logoImage!.path.split('.').last;

    var multipartFile = http.MultipartFile(
      'image',
      stream,
      length,
      filename: logoImage!.path.split('/').last,
      contentType: MediaType('image', fileExtension),
    );
    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      print('Upload successful: $responseBody');

      // Parse the response to get the image filename
      final responseJson = jsonDecode(responseBody);
      if (responseJson['status'] == 'success') {
        imageURL = responseJson[
            'filename']; // Assuming the server returns the filename
      } else {
        print('Image upload failed: ${responseJson['message']}');
        Get.snackbar("Error", "Image upload failed.");
      }
    } else {
      print('Failed to upload image: ${response.statusCode}');
    }
  }

  Future<void> updateData() async {
    if (!formstate.currentState!.validate()) {
      print("Form validation failed.");
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    try {
      print("Uploading image...");
      await uploadImage();

      print("Updating company data...");
      var response = await updateCompanyData.updateData(
        companyname.text,
        companynickid.text,
        companydescription.text,
        imageURL ?? companyData!.companyImage!,
        companyworkers ?? "",
        selectedRole ?? "",
        companyData!.companyId!,
      );
      print("Company update response: $response");

      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if (response['status'] == "success") {
          print("Company updated successfully.");
          Get.offAllNamed(AppRoute.managerhome);
        } else {
          print("Company update failed: ${response['message']}");
          Get.defaultDialog(
            title: "Warning",
            middleText: response['message'] ?? "Unable to update the company.",
          );
          statusRequest = StatusRequest.failure;
        }
      }
    } catch (e) {
      print("Error updating company: $e");
      statusRequest = StatusRequest.failure;
      Get.defaultDialog(
        title: "Error",
        middleText: "An error occurred: $e",
      );
    }

    update();
  }

  @override
  void onInit() {
    // Retrieve company data passed from previous screen
    companyData = Get.arguments['companydata'];

    // Initialize controllers with existing company data
    companyname = TextEditingController(text: companyData?.companyName ?? "");
    companynickid =
        TextEditingController(text: companyData?.companyNickID ?? "");
    companydescription =
        TextEditingController(text: companyData?.companyDescription ?? "");

    // Set selected role and workers based on the existing company data
    selectedRole = companyData?.companyJob;
    companyworkers = companyData?.companyWorkes;

    // Initialize the selectedIndex based on the company workers value
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
