import 'package:get/get.dart';
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/core/functions/handlingdatacontroller.dart';
import 'package:tasknotate/data/datasource/remote/company/manager/company_data.dart';
import 'package:tasknotate/data/model/company/companymodel.dart';
import 'package:tasknotate/data/datasource/remote/linkapi.dart';
import 'package:tasknotate/view/screen/company/manager/company/update_company.dart';

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

  Future<void> deletecompany(String companyid) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await companyDataRequest.removedata(companyid);

    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      Get.snackbar(
        "Success",
        "Company deleted successfully.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.primaryColor,
        colorText: Get.theme.colorScheme.onPrimary,
      );
      Get.offAllNamed(AppRoute.home);
    } else {
      Get.snackbar(
        "Failure",
        "Failed to delete the company. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Get.theme.colorScheme.onError,
      );
    }
    update();
  }

  Future<void> deleteemployeecompany(String employeeId) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await companyDataRequest.removeemployee(
        employeeId, companyData!.companyId!);

    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success &&
        response['status'] == "success") {
      // Remove the employee locally
      companyData!.employees?.removeWhere((e) => e.employeeId == employeeId);
      Get.snackbar(
        "Success",
        "Employee removed successfully.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.primaryColor,
        colorText: Get.theme.colorScheme.onPrimary,
      );
      update();
    } else {
      Get.snackbar(
        "Failure",
        "Failed to remove employee. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }

  goToUpdateCompany() {
    Get.to(const UpdateCompany(), arguments: {"companydata": companyData});
  }

  goToWorkspace() {
    Get.toNamed(AppRoute.workspace, arguments: {
      "companyid": companyData!.companyId,
      "companyemployee": companyData!.employees,
    });
  }

  @override
  void onInit() {
    super.onInit();
    companyData = Get.arguments['companydata'];
  }
}
