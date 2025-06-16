import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> subscribeToTopic(String topic) async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.subscribeToTopic(topic);
  print("Subscribed to topic: $topic");
}

Future<void> unsubscribeToTopic(String topic) async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.unsubscribeFromTopic(topic);
  print("unSubscribed to topic: $topic");
}

//for ios
Future<void> requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print("User granted permission");
  } else {
    print("User denied permission");
  }
}
