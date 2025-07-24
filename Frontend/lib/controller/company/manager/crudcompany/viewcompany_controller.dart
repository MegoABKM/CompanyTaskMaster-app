import 'package:companymanagment/view/screen/company/manager/company/chat_placeholder_page.dart';
import 'package:companymanagment/view/screen/company/manager/company/employee_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/constant/routes.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/data/datasource/remote/company/manager/company_data.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';
import 'package:companymanagment/data/datasource/remote/linkapi.dart';
import 'package:companymanagment/view/screen/company/manager/company/update_company.dart';

class ViewcompanyController extends GetxController {
  CompanyModel? companyData;
  CompanyData companyDataRequest = CompanyData(Get.find());
  StatusRequest? statusRequest;

  // Construct the full image URL
  String getCompanyImageUrl(String imageName) {
    return '${AppLink.imageplaceserver}$imageName';
  }

  // Construct the full image URL
  String getCompanyprofileImageUrl(String imageName) {
    return '${AppLink.imageprofileplace}$imageName';
  }

  void showEmployeeOptions(BuildContext context, Employees employee) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.visibility_outlined),
              title: Text('view_details'.tr),
              onTap: () {
                Get.back();
                Get.to(() => const EmployeeDetailsPage(),
                    arguments: {'employee': employee});
              },
            ),
            ListTile(
              leading: const Icon(Icons.message_outlined),
              title: Text('send_message'.tr),
              onTap: () {
                Get.back();
                Get.to(() => const ChatPlaceholderPage(),
                    arguments: {'employee': employee});
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.front_hand_outlined, color: Colors.amber.shade700),
              title: Text('nudge_nakez'.tr,
                  style: TextStyle(color: Colors.amber.shade700)),
              onTap: () {
                Get.back();
                nudgeEmployee(employee);
              },
            ),
            const Divider(),
            ListTile(
              leading:
                  const Icon(Icons.person_remove_outlined, color: Colors.red),
              title: Text('remove_from_company'.tr,
                  style: const TextStyle(color: Colors.red)),
              onTap: () {
                Get.back();
                deleteemployeecompany(employee.employeeId!);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deletecompany(String companyid) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await companyDataRequest.removedata(companyid);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success &&
        response['status'] == "success") {
      Get.snackbar(
        "Success",
        "Company deleted successfully.",
        snackPosition: SnackPosition.BOTTOM,
      );
      // Get.offAllNamed(AppRoute.home, arguments: {'refresh': true});
    } else {
      Get.snackbar(
        "Failure",
        "Failed to delete the company. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    update();
  }

  Future<void> deleteemployeecompany(String employeeId) async {
    Get.defaultDialog(
      title: "remove_employee_title".tr,
      middleText: "remove_employee_confirm".tr,
      textConfirm: "yes_remove".tr,
      textCancel: "cancel".tr,
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () async {
        Get.back();
        statusRequest = StatusRequest.loading;
        update();
        var response = await companyDataRequest.removeemployee(
            employeeId, companyData!.companyId!);
        statusRequest = handlingData(response);

        if (statusRequest == StatusRequest.success &&
            response['status'] == "success") {
          companyData!.employees
              ?.removeWhere((e) => e.employeeId == employeeId);
          Get.snackbar("Success", "employee_removed_success".tr);
        } else {
          Get.snackbar("Failure", "employee_removed_error".tr);
        }
        update();
      },
    );
  }

  // CORRECTED NAVIGATION TO UPDATE SCREEN
  void goToUpdateCompany() {
    // We navigate to the widget directly, passing the data.
    // This is correct as UpdateCompany screen is not a main route.
    Get.to(() => const UpdateCompany(),
        arguments: {"companydata": companyData});
  }

  void goToWorkspace() {
    Get.toNamed(AppRoute.workspace, arguments: {
      "companyid": companyData!.companyId,
      "companyemployee": companyData!.employees,
    });
  }

  Future<void> nudgeEmployee(Employees employee) async {
    Get.snackbar(
        "sending_nudge_to".trParams({'name': employee.employeeName ?? ''}),
        "...");

    var response = await companyDataRequest.nudgeEmployee(
        employee.employeeId!, companyData!.manager!.managerName!);

    if (response['status'] == 'success') {
      Get.snackbar("Success!",
          "nudge_sent_to".trParams({'name': employee.employeeName ?? ''}),
          backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      Get.snackbar("Error", "nudge_send_error".tr);
    }
  }

  @override
  void onInit() {
    super.onInit();
    // This part is correct. It receives the data when navigating to this screen.
    if (Get.arguments != null && Get.arguments['companydata'] != null) {
      companyData = Get.arguments['companydata'];
    } else {
      // Handle case where data is missing, maybe show an error or go back
      Get.back();
      Get.snackbar("Error", "Could not load company data.");
    }
  }
}
