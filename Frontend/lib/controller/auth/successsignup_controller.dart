import 'package:get/get.dart';
import 'package:companymanagment/core/constant/routes.dart';

abstract class SuccessSignupController extends GetxController {
  goToLogin();
}

class SuccessSignupControllerImp extends SuccessSignupController {
  @override
  goToLogin() {
    Get.offAllNamed(AppRoute.login);
  }
}
