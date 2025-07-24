import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/constant/routes.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/core/services/services.dart';
import 'package:companymanagment/data/datasource/remote/company/manager/company_data.dart';

class CreatecompanyController extends GetxController {
  // --- Wizard State ---
  int currentStep = 0;
  late PageController pageController;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController companyname;
  late TextEditingController companydescription;

  // --- Data Models ---
  int selectedIndex = -1;
  final List<String> options = ["1-10", "11-50", "51-200"];

  // Use raw keys for roles, translate them in the UI
  final List<String> roles = [
    "194",
    "195",
    "196",
    "197",
    "198",
    "199",
    "200",
    "201",
    "202",
  ];

  String? companyworkers;
  String? selectedRole;
  File? logoImage;
  final ImagePicker picker = ImagePicker();
  String? imageURL;
  String? userid;

  // --- Dependencies & Status ---
  MyServices myServices = Get.find();
  CompanyData createcompanyData = CompanyData(Get.find());
  StatusRequest? statusRequest;

  // --- Wizard Navigation ---
  void nextStep() {
    if (currentStep < 2) {
      if (currentStep == 0) {
        if (!formstate.currentState!.validate()) return;
      }
      if (currentStep == 1) {
        if (selectedRole == null) {
          Get.snackbar("Incomplete", "Please select a company industry/role.");
          return;
        }
      }
      currentStep++;
      pageController.animateToPage(
        currentStep,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      update();
    } else {
      createData();
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      currentStep--;
      pageController.animateToPage(
        currentStep,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      update();
    }
  }

  // --- Data Handling ---
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
    // ... (uploadImage logic remains the same)
  }

  Future<void> createData() async {
    // Final validation before submitting
    if (companyworkers == null) {
      Get.snackbar("Incomplete", "Please select the company size.");
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    try {
      await uploadImage();

      // The companynickid is handled by the backend, so we don't send it.
      // Your backend script for createcompany.php should generate a unique ID.
      var response = await createcompanyData.insertData(
        companyname.text,
        "", // Send an empty string for nickid, let backend handle it
        companydescription.text,
        imageURL ?? 'default.png',
        companyworkers!,
        selectedRole!,
        userid!,
      );

      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success &&
          response['status'] == 'success') {
        Get.snackbar("Success", "Company created successfully!");
        Get.offAllNamed(AppRoute.home);
      } else {
        throw Exception(response['message'] ?? 'Failed to create company.');
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
    pageController = PageController();
    companyname = TextEditingController();
    companydescription = TextEditingController();
    userid = myServices.sharedPreferences.getString("id");
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    companyname.dispose();
    companydescription.dispose();
    super.dispose();
  }
}
