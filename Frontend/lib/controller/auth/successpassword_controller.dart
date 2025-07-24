import 'package:get/get.dart';
import 'package:companymanagment/core/constant/routes.dart';

abstract class SuccessPasswordController extends GetxController {
  goToLogin();
}

class SuccessPasswordControllerImp extends SuccessPasswordController {
  @override
  goToLogin() {
    Get.offAllNamed(AppRoute.login);
  }
}
