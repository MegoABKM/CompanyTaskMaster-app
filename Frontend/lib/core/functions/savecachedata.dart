import 'package:companymanagment/main.dart';

Future<void> saveUserData(Map<String, dynamic> userData) async {
  await Future.wait([
    myServices.sharedPreferences
        .setString("id", userData["users_id"].toString()),
    myServices.sharedPreferences
        .setString("username", userData["users_name"] ?? ""),
    myServices.sharedPreferences
        .setString("email", userData["users_email"] ?? ""),
    myServices.sharedPreferences
        .setString("phone", userData["users_phone"]?.toString() ?? ""),
    myServices.sharedPreferences.setString("step", "2"),
  ]);
}
