import 'package:get/get.dart';
import 'package:companymanagment/core/class/crud.dart';

class Initialbinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
    //Get.lazyPut(() => AppSecurityService(), fenix: true);
  }
}
