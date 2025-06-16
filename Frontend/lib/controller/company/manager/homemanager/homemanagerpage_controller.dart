import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomemanagerpageController extends GetxController {
  int currentIndex = 0;

  List<BottomNavigationBarItem> itemsOfScreen = [
    BottomNavigationBarItem(
      icon: const Icon(Icons.business),
      label: "175".tr, // Companies
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.message),
      label: "176".tr, // Messages
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.request_page),
      label: "177".tr, // Request
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.person),
      label: "178".tr, // Profile
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.notifications),
      label: "179".tr, // Notification
    ),
  ];

  void onTapBottom(int index) {
    currentIndex = index;
    update();
  }
}
