import 'package:get/get.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/core/services/services.dart';
import 'package:companymanagment/data/datasource/remote/company/manager/requestjoin_data.dart';
import 'package:companymanagment/data/model/company/requestjoincompanymodel.dart';

class RequestJoinController extends GetxController {
  List<RequestJoinCompanyModel> joinRequests = [];
  StatusRequest? statusRequest;
  RequestjoinData requestjoinData = RequestjoinData(Get.find());
  String? userid;
  MyServices myServices = Get.find();

  @override
  void onInit() {
    super.onInit();

    userid = myServices.sharedPreferences.getString('id');
    fetchJoinRequests(); // Load requests initially
  }

  Future<void> fetchJoinRequests() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await requestjoinData.getData(userid);

    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success && response['data'] != null) {
      // Assuming response['data'] is a list of maps
      joinRequests = List<RequestJoinCompanyModel>.from(
        response['data'].map((e) => RequestJoinCompanyModel.fromJson(e)),
      );
    }
    update();
  }

  Future<void> accpetRequest(
      String employeeCompanyId, String employeeid) async {
    statusRequest = StatusRequest.loading;
    update();

    var response =
        await requestjoinData.acceptUser(employeeCompanyId, employeeid);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        joinRequests.removeWhere((request) =>
            request.employeeCompanyId.toString() == employeeCompanyId);
        update();
        Get.snackbar("Success", "Request accepted.");
        // Get.offAllNamed(AppRoute.home); // Navigate to home after accepting
      } else {
        Get.snackbar("Failed", "Error accepting request.");
      }
    } else {
      Get.snackbar("Failed", "Error processing request.");
    }
  }

  Future<void> rejectRequest(
      String employeeCompanyId, String employeeid) async {
    statusRequest = StatusRequest.loading;
    update();

    var response =
        await requestjoinData.rejectUser(employeeCompanyId, employeeid);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        joinRequests.removeWhere((request) =>
            request.employeeCompanyId.toString() == employeeCompanyId);
        update();
        Get.snackbar("Success", "Request rejected.");
        //     Get.offAllNamed(AppRoute.home); // Navigate to home after rejecting
      } else {
        Get.snackbar("Failed", "Error rejecting request.");
      }
    } else {
      Get.snackbar("Failed", "Error processing request.");
    }
  }
}
