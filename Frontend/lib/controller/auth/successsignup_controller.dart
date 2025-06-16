import 'package:get/get.dart';
import 'package:tasknotate/core/constant/routes.dart';

abstract class SuccessSignupController extends GetxController {
  goToLogin();
}

class SuccessSignupControllerImp extends SuccessSignupController {
  @override
  goToLogin() {
    Get.offAllNamed(AppRoute.login);
  }
}
