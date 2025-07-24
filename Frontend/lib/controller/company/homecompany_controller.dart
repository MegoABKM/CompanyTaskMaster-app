import 'package:get/get.dart';
import 'package:companymanagment/core/constant/routes.dart';
import 'package:companymanagment/core/services/services.dart';

class CompanyHomeController extends GetxController {
  String? selectedRole;
  MyServices myServices = Get.find();

  void selectTile(String roleKey) {
    if (selectedRole == roleKey) {
      selectedRole = null;
    } else {
      selectedRole = roleKey;
    }
    update();
  }

  void goToManagerOrEmployee() {
    if (selectedRole == null) {
      Get.snackbar("Selection Required", "Please select a role to continue.");
      return;
    }

    myServices.sharedPreferences.setString("userrole", selectedRole!);
    myServices.sharedPreferences.setString("step", "3");
    print("User role saved: $selectedRole. Step set to 3.");

    // --- THE FIX IS HERE ---
    // Navigate DIRECTLY to the correct dashboard, clearing the navigation stack.
    if (selectedRole == "manager") {
      Get.offAllNamed(AppRoute.managerhome);
    } else if (selectedRole == "employee") {
      Get.offAllNamed(AppRoute.employeehome);
    }
  }
}
