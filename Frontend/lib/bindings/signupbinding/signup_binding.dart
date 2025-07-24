import 'package:get/get.dart';
import 'package:companymanagment/controller/auth/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignupControllerImp());
  }
}
