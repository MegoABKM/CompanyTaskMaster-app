import 'package:get/get.dart';
import 'package:tasknotate/core/class/crud.dart';
import 'package:tasknotate/core/services/app_security_service.dart';

class Initialbinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
    Get.lazyPut(() => AppSecurityService(), fenix: true);
  }
}
