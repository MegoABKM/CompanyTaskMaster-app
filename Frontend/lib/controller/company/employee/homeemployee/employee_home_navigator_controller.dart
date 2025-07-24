import 'package:companymanagment/view/screen/company/employee/projects/employee_project_workspace_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/functions/firebasetopicnotification.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/core/services/services.dart';
import 'package:companymanagment/data/datasource/remote/company/employee/employeehome_data.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';
import 'package:companymanagment/data/model/company/project_model.dart';
import 'package:companymanagment/data/model/company/tasks/newtasksmodel.dart';
import 'package:companymanagment/data/datasource/remote/linkapi.dart';
import 'package:companymanagment/view/screen/company/employee/company/view_company_details.dart';
import 'package:companymanagment/view/screen/company/employee/tasks/view_task_company_employee.dart';
import 'package:companymanagment/view/screen/company/employee/tasks/workspace_employee.dart';
// Placeholder for the new screen

class EmployeehomeController extends GetxController {
  StatusRequest? statusRequest;
  String? userid;
  List<CompanyModel> companyList = [];
  List<Newtasks> newTaskList = [];
  List<ProjectModel> projectList = []; // NEW: List to hold projects
  late TextEditingController companyid;
  EmployeehomeData employeehomeData = EmployeehomeData(Get.find());
  MyServices myServices = Get.find();
  bool statusjoin = false;

  void toggler() {
    statusjoin = !statusjoin;
    update();
  }

  Future<void> requestJoinCompany() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response =
          await employeehomeData.requestJoinToCompany(userid, companyid.text);
      statusRequest = handlingData(response);

      String message = response['message'] ?? 'unexpected_error'.tr;
      Get.defaultDialog(
        title: 'join_request_status'.tr,
        middleText: message,
        textConfirm: 'OK',
        onConfirm: Get.back,
      );
    } catch (e) {
      Get.defaultDialog(
        title: 'error'.tr,
        middleText: 'unexpected_error'.tr,
        textConfirm: 'OK',
        onConfirm: Get.back,
      );
      print("Error: $e");
    }

    companyid.clear();
    statusjoin = false; // Close the join section after request
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
      var response = await employeehomeData.getData(userid);
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        // Clear all lists before parsing new data
        companyList.clear();
        newTaskList.clear();
        projectList.clear();

        if (response['data'] != null && response['data'] is Map) {
          var data = response['data'];

          // Parse companies
          if (data['companies'] != null && data['companies'] is List) {
            companyList = (data['companies'] as List)
                .map((item) => CompanyModel.fromJson(item))
                .toList();
          }

          // Parse new tasks
          if (data['newtasks'] != null && data['newtasks'] is List) {
            newTaskList = (data['newtasks'] as List)
                .map((item) => Newtasks.fromJson(item))
                .toList();
          }

          // Parse projects
          if (data['projects'] != null && data['projects'] is List) {
            projectList = (data['projects'] as List)
                .map((item) => ProjectModel.fromJson(item))
                .toList();
          }
        }
      } else {
        companyList.clear();
        newTaskList.clear();
        projectList.clear();
      }
    } catch (e) {
      print("Error fetching data: $e");
      statusRequest = StatusRequest.failure;
      companyList.clear();
      newTaskList.clear();
      projectList.clear();
    }

    update();
  }

  String getCompanyImageUrl(String imageName) {
    return '${AppLink.imageplaceserver}$imageName';
  }

  void goToWorkSpaceEmployee(String? companyId, List<Employees>? employees) {
    Get.to(() => const WorkspaceEmployee(),
        arguments: {"companyid": companyId, "companyemployee": employees});
  }

  // NEW: Navigate to the project workspace
  // Note: For now, this navigates to the manager's workspace page as a placeholder.
  // A dedicated, simplified employee workspace page should be created for a full implementation.
  void goToProjectWorkspace(ProjectModel project) {
    Get.to(() => const EmployeeProjectWorkspacePage(),
        arguments: {'project': project});
  }

  void goToCompanyDetailsEmployee(CompanyModel companydetails) {
    Get.to(() => const ViewCompanyEmployee(),
        arguments: {"companydata": companydetails});
  }

  void goToTaskDetailsEmployee(Newtasks newtasks) {
    Get.to(() => const ViewTaskCompanyEmployee(),
        arguments: {"newtasks": newtasks, "from": "employee"});
  }

  Future<void> subscribeToAllCompanies() async {
    for (var company in companyList) {
      if (company.companyId != null) {
        await subscribeOnce(company.companyId!);
      }
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

  @override
  void onInit() {
    super.onInit();
    companyid = TextEditingController();
    userid = myServices.sharedPreferences.getString('id');

    if (userid != null) {
      subscribeToTopic(userid!);
      getData().then((_) {
        subscribeToAllCompanies();
      });
    } else {
      print("Error: No user ID found in shared preferences!");
      statusRequest = StatusRequest.failure;
    }
  }

  @override
  void dispose() {
    companyid.dispose();
    super.dispose();
  }
}
