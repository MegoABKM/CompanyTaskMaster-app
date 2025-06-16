import 'dart:io';
import 'package:alarm/alarm.dart';
import 'package:get/get.dart';

Future<void> setAlarm(DateTime? selectedAlarm, int? lastTaskIdinreased,
    String titlecontroller) async {
  print("setAlarm triggered");
  if (selectedAlarm == null || lastTaskIdinreased == null) {
    print("No alarm selected or last task ID is null");
    return;
  }

  final alarmSettings = AlarmSettings(
    id: lastTaskIdinreased,
    dateTime: selectedAlarm,
    assetAudioPath: 'assets/alarm.mp3',
    loopAudio: true,
    vibrate: true,
    volume: 0.8,
    fadeDuration: 3.0,
    warningNotificationOnKill: Platform.isIOS,
    androidFullScreenIntent: true,
    notificationSettings: NotificationSettings(
      title: titlecontroller,
      body: 'It\'s time to complete your task!',
      stopButton: 'Stop',
      icon: 'notification_icon',
    ),
  );

  try {
    bool isSet = await Alarm.set(alarmSettings: alarmSettings);
    if (isSet) {
      Get.snackbar(
        "Alarm Set",
        "Your alarm is set for ${selectedAlarm.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      print("Failed to set the alarm.");
    }
  } catch (e) {
    print("Error setting alarm: $e");
    Get.snackbar(
      "Alarm Error",
      "An error occurred while setting the alarm: $e",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

Future<void> deactivateAlarm(dynamic task) async {
  await Alarm.stop(int.parse(task!.id!));
  print('Alarm with ID ${task!.id} deactivated.');
}
