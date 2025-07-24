import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:companymanagment/core/functions/firebasetopicnotification.dart';
import 'package:companymanagment/data/datasource/local/sqldb.dart';

class MyServices extends GetxService {
  SqlDb sqlDb = SqlDb();
  late SharedPreferences sharedPreferences;

  Future<MyServices> init() async {
    await Firebase.initializeApp();
    subscribeToTopic("news");
    setupForegroundNotification();

    // Initialize SharedPreferences
    sharedPreferences = await SharedPreferences.getInstance();

    return this;
  }
}

Future<void> initialServices() async {
  await Get.putAsync(() => MyServices().init());
}

void setupForegroundNotification() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      print(
          "📩 Foreground Notification Received: ${message.notification!.title}");

      Get.snackbar(
        message.notification!.title ?? "New Notification",
        message.notification!.body ?? "",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.blue.withOpacity(0.8),
        colorText: Colors.white,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        icon: const Icon(Icons.notifications, color: Colors.white),
      );
    }

    // Handle the data payload
    if (message.data.isNotEmpty) {
      print("📩 Data Payload: ${message.data}");

      // Check for 'type' in the data
      if (message.data['type'] == 'employeeaccepted') {
        print("Employee accepted! Navigating to Home to refresh the page.");
        // Get.offAllNamed(AppRoute.home, arguments: {
        //   'refresh': true,
        // });
      } else if (message.data['type'] == 'joinrequest') {
        print("Join request received! Navigating to Home to refresh the page.");
        // Get.offAllNamed(AppRoute.home, arguments: {
        //   'refresh': true,
        //   'joinRequest': true,
        // });
      } else if (message.data['type'] == 'employeerejected') {
        print("Employee rejected! Navigating to Home to refresh the page.");
        // Get.offAllNamed(AppRoute.home, arguments: {
        //   'refresh': true,
        //   'rejected': true, // Optional: Pass a flag to indicate rejection
        // });
      }
    }
  });
}
