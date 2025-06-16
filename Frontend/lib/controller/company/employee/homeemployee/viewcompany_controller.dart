import 'package:get/get.dart';
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/data/datasource/remote/company/manager/company_data.dart';
import 'package:tasknotate/data/model/company/companymodel.dart';
import 'package:tasknotate/data/datasource/remote/linkapi.dart';

class ViewcompanyEmployeeController extends GetxController {
  CompanyModel? companyData;
  CompanyData companyDataRequest = CompanyData(Get.find());
  StatusRequest? statusRequest;

  @override
  void onInit() {
    super.onInit();
    // Get the company data passed from the previous screen
    var arguments = Get.arguments;
    if (arguments != null && arguments['companydata'] != null) {
      companyData = arguments['companydata'];
      update();
      print("Company data received: $companyData");
    } else {
      print("Company data not found in arguments!");
    }
  }

  // Construct the full image URL
  String getCompanyImageUrl(String imageName) {
    return '${AppLink.imageplaceserver}$imageName';
  }
}
