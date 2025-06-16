import 'package:alarm/alarm.dart';
import 'package:get/get.dart';
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/main.dart';

class SettingsController extends GetxController {
  var areAlarmsDisabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    areAlarmsDisabled.value = false;
  }

  Future<void> signOut() async {
    try {
      await myServices.supabase.auth.signOut();
      await myServices.sharedPreferences.clear();
      myServices.sharedPreferences.setInt("indexhome", 1);
      update();
      Get.offAllNamed(AppRoute.home);
    } catch (e) {
      Get.snackbar("key_sign_out_error".tr, e.toString());
    }
  }

  Future<void> toggleAllAlarms(bool disable) async {
    if (disable) {
      await Alarm.stopAll();
      areAlarmsDisabled.value = true;
      Get.snackbar(
        "key_alarms_disabled".tr,
        "key_all_alarms_disabled".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } else {
      areAlarmsDisabled.value = false;
      Get.snackbar(
        "key_alarms_enabled".tr,
        "key_alarms_now_enabled".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    }
  }
}
