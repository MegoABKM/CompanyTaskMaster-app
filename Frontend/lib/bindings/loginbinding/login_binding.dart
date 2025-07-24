import 'package:get/get.dart';
import 'package:companymanagment/controller/auth/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginControllerImp());
  }
}
