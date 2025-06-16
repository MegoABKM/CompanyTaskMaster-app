import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tasknotate/core/services/services.dart';

class AppSecurityService extends GetxService {
  static const String _isEnabledKey = 'app_is_enabled';
  static const String _messageKey = 'app_disable_message';
  final SupabaseClient supabase = Get.find<MyServices>().supabase;
  final SharedPreferences prefs = Get.find<MyServices>().sharedPreferences;

  @override
  void onInit() {
    super.onInit();
    // Listen to connectivity changes
    Connectivity().onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        checkAppStatus(forceCheck: true); // Force check when online
      }
    });
  }

  Future<bool> checkAppStatus({bool forceCheck = false}) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    final isOnline = connectivityResult != ConnectivityResult.none;

    // If offline and not forcing a check, use cached status
    if (!isOnline && !forceCheck) {
      final isEnabled = prefs.getBool(_isEnabledKey) ?? true;
      if (!isEnabled && forceCheck) {
        final message = prefs.getString(_messageKey) ??
            'App is disabled due to unauthorized use.';
        _showDisableDialog(message);
      }
      return isEnabled;
    }

    // Online: Check Supabase
    try {
      final response = await supabase
          .from('app_config')
          .select('is_enabled, message')
          .single();

      final isEnabled = response['is_enabled'] as bool;
      final message = response['message'] as String;

      // Cache the status
      await prefs.setBool(_isEnabledKey, isEnabled);
      await prefs.setString(_messageKey, message);

      if (!isEnabled && forceCheck) {
        _showDisableDialog(message);
      }
      return isEnabled;
    } catch (e) {
      // Silently fail and use cached status
      final isEnabled = prefs.getBool(_isEnabledKey) ?? true;
      if (!isEnabled && forceCheck) {
        final message = prefs.getString(_messageKey) ??
            'App is disabled due to unauthorized use.';
        _showDisableDialog(message);
      }
      return isEnabled;
    }
  }

  void _showDisableDialog(String message) {
    Get.dialog(
      AlertDialog(
        title: Text('key_app_disabled'.tr),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('OK'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
