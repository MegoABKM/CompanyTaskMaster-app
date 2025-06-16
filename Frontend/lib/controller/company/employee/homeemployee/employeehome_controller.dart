import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/core/functions/firebasetopicnotification.dart';
import 'package:tasknotate/core/functions/handlingdatacontroller.dart';
import 'package:tasknotate/core/services/services.dart';
import 'package:tasknotate/data/datasource/remote/company/employee/employeehome_data.dart';
import 'package:tasknotate/data/model/company/companymodel.dart';
import 'package:tasknotate/data/model/company/tasks/newtasksmodel.dart';
import 'package:tasknotate/data/datasource/remote/linkapi.dart';
import 'package:tasknotate/view/screen/company/employee/company/view_company_details.dart';
import 'package:tasknotate/view/screen/company/employee/tasks/view_task_company_employee.dart';
import 'package:tasknotate/view/screen/company/employee/tasks/workspace_employee.dart';

class EmployeehomeController extends GetxController {
  StatusRequest? statusRequest;
  String? userid;
  List<CompanyModel> companyList = [];
  List<Newtasks> newTaskList = [];
  TextEditingController? companyid;
  EmployeehomeData employeehomeData = EmployeehomeData(Get.find());
  MyServices myServices = Get.find();
  bool statusjoin = false;

  void toggler() {
    statusjoin = !statusjoin;
    update();
  }

  // Request to join a company
  Future<void> requestJoinCompany() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response =
          await employeehomeData.requestJoinToCompany(userid, companyid!.text);
      statusRequest = handlingData(response);

      String message = response['message'] ?? 'Unexpected error occurred.';
      Get.defaultDialog(
        title: 'Request Status',
        middleText: message,
        textConfirm: 'OK',
        onConfirm: Get.back,
      );
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'An unexpected error occurred.',
        textConfirm: 'OK',
        onConfirm: Get.back,
      );
      print("Error: $e");
    }

    companyid!.clear();
    update();
  }

  Future<void> getData() async {
    if (userid == null) {
      print("Error: userid is null");
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    try {
      print("Sending request with user ID: $userid");
      var response = await employeehomeData.getData(userid);
      print("Response from getData: $response");

      statusRequest = handlingData(response);
      print("Status request: $statusRequest");

      if (statusRequest == StatusRequest.success) {
        companyList.clear();
        newTaskList.clear();

        // ✅ Check if 'data' is a list, not a map
        if (response['data'] != null && response['data'] is List) {
          var data = response['data'];

          // Loop through the data and map each company and task
          for (var item in data) {
            if (item['company'] != null) {
              companyList.add(CompanyModel.fromJson(item['company']));
            }
            if (item['newtasks'] != null) {
              for (var task in item['newtasks']) {
                newTaskList.add(Newtasks.fromJson(task));
              }
            }
          }
        } else {
          print(
              "Error: 'data' field is missing or not in the expected format.");
        }

        print("Company list size: ${companyList.length}");
        print("New task list size: ${newTaskList.length}");
      } else {
        print("Status request failed: $statusRequest");
        companyList.clear();
        newTaskList.clear();
      }
    } catch (e) {
      print("Error fetching data: $e");
      statusRequest = StatusRequest.failure;
      companyList.clear();
      newTaskList.clear();
    }

    update();
  }

  // Helper method to get the company image URL
  String getCompanyImageUrl(String imageName) {
    return '${AppLink.imageplaceserver}$imageName';
  }

  // Navigate to the workspace of an employee
  void goToWorkSpaceEmployee(String? companyid) {
    Get.to(const WorkspaceEmployee(), arguments: {"companyid": companyid});
  }

  void goToCompanyDetaislEmployee(CompanyModel companydetails) {
    Get.to(const ViewCompanyEmployee(),
        arguments: {"companydata": companydetails});
  }

  void goToTaskDetaislEmployee(Newtasks newtasks) {
    Get.to(const ViewTaskCompanyEmployee(),
        arguments: {"newtasks": newtasks, "from": "employee"});
  }

  Future<void> subscribeToAllCompanies() async {
    List<String> subscribedCompanies = [];

    for (var company in companyList) {
      if (company.companyId != null) {
        bool isSubscribed = await subscribeOnce(company.companyId!);
        if (isSubscribed) {
          subscribedCompanies.add(company.companyName ?? 'Unknown Company');
        }
      }
    }

    if (subscribedCompanies.isNotEmpty) {
      print("Subscribed to the following companies:");
      for (var company in subscribedCompanies) {
        print("- $company");
      }
    } else {
      print("No companies subscribed.");
    }
  }

  Future<bool> subscribeOnce(String topic) async {
    bool isSubscribed = myServices.sharedPreferences.getBool(topic) ?? false;

    if (!isSubscribed) {
      await FirebaseMessaging.instance.subscribeToTopic(topic);
      await myServices.sharedPreferences.setBool(topic, true);
      print("Subscribed to topic: $topic");
      return true;
    }
    return false;
  }

  Future<void> checkSubscribedCompanies() async {
    List<String> subscribedCompanies = [];

    for (var company in companyList) {
      if (company.companyId != null) {
        bool isSubscribed =
            myServices.sharedPreferences.getBool(company.companyId!) ?? false;
        if (isSubscribed) {
          subscribedCompanies.add(company.companyName ?? 'Unknown Company');
        }
      }
    }

    if (subscribedCompanies.isNotEmpty) {
      print("Already subscribed to the following companies:");
      for (var company in subscribedCompanies) {
        print("- $company");
      }
    } else {
      print("No subscribed companies found.");
    }
  }

  @override
  void onInit() {
    super.onInit();
    companyid = TextEditingController();
    userid = myServices.sharedPreferences.getString('id');
    subscribeToTopic(userid!);

    if (userid == null) {
      print("Error: No user ID found in shared preferences!");
    } else {
      print("User ID loaded: $userid");
      getData().then((_) {
        checkSubscribedCompanies();
        subscribeToAllCompanies();
      });
    }
  }

  @override
  void dispose() {
    companyid!.dispose();
    super.dispose();
  }
}
