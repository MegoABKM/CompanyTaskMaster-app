import 'package:alarm/alarm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Add this import
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/core/functions/firebasetopicnotification.dart';
import 'package:tasknotate/data/datasource/local/sqldb.dart';
import 'package:tasknotate/view/screen/home_navigator.dart';

class MyServices extends GetxService {
  SqlDb sqlDb = SqlDb();
  late SharedPreferences sharedPreferences;
  late final SupabaseClient supabase; // Supabase client instance

  Future<void> onAlarmActivated(AlarmSettings alarmSettings) async {
    print("Alarm with ID ${alarmSettings.id} has been triggered!");

    try {
      int response = await sqlDb.updateData(
        "UPDATE tasks SET reminder = ? WHERE id = ?",
        ["Not Set", alarmSettings.id.toString()],
      );

      if (response > 0) {
        Get.offAll(() => const HomeNavigator(),
            transition: Transition.noTransition);
        print("Reminder updated to 'Not Set' for task ID ${alarmSettings.id}.");
      } else {
        print("Failed to update the reminder for task ID ${alarmSettings.id}.");
      }
    } catch (e) {
      print("Error updating reminder for task ID ${alarmSettings.id}: $e");
    }
  }

  Future<MyServices> init() async {
    await Firebase.initializeApp();
    subscribeToTopic("news");
    setupForegroundNotification();

    // Initialize Alarm
    await Alarm.init();
    Alarm.ringStream.stream.listen((alarmSettings) {
      onAlarmActivated(alarmSettings);
    });

    // Initialize SharedPreferences
    sharedPreferences = await SharedPreferences.getInstance();

    // Initialize Supabase
    await Supabase.initialize(
      url: 'https://kymozkcwbuflexuazgsu.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt5bW96a2N3YnVmbGV4dWF6Z3N1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDMzNDc0ODksImV4cCI6MjA1ODkyMzQ4OX0.xwqhkpoKan-ZxnASfr3a2vdIKYupH5aPrtgORXZIGTM',
    );
    supabase = Supabase.instance.client; // Assign the Supabase client

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
        Get.offAllNamed(AppRoute.home, arguments: {
          'refresh': true,
        });
      } else if (message.data['type'] == 'joinrequest') {
        print("Join request received! Navigating to Home to refresh the page.");
        Get.offAllNamed(AppRoute.home, arguments: {
          'refresh': true,
          'joinRequest': true,
        });
      } else if (message.data['type'] == 'employeerejected') {
        print("Employee rejected! Navigating to Home to refresh the page.");
        Get.offAllNamed(AppRoute.home, arguments: {
          'refresh': true,
          'rejected': true, // Optional: Pass a flag to indicate rejection
        });
      }
    }
  });
}
