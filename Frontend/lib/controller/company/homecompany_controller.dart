import 'package:get/get.dart';
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/core/services/services.dart';

class CompanyHomeController extends GetxController {
  bool? selectedindex = false;
  bool? selectedindex2 = false;
  StatusRequest? statusRequest;
  MyServices myServices = Get.find();

  selectTile(String namevalue) {
    if (namevalue == "manager") {
      selectedindex = true;
      selectedindex2 = false;
      print(" Manager  =  $selectedindex");
      print(" employee  =  $selectedindex2");
      print("--------------");

      update();
    }
    if (namevalue == "employee") {
      selectedindex2 = true;
      selectedindex = false;
      print(" employee  =  $selectedindex2");
      print(" Manager  =  $selectedindex");
      print("--------------");

      update();
    }
  }

  goToManagerOrEmployee() {
    if (selectedindex == true) {
      myServices.sharedPreferences.setString("userrole", "manager");
      Get.offAllNamed(AppRoute.home);
    }

    if (selectedindex2 == true) {
      myServices.sharedPreferences.setString("userrole", "employee");

      Get.offAllNamed(AppRoute.home);
    }
  }
}
