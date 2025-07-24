import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomemanagerpageController extends GetxController {
  int currentIndex = 0;

  List<BottomNavigationBarItem> itemsOfScreen = [
    BottomNavigationBarItem(
      icon: const Icon(Icons.business_rounded),
      activeIcon: const Icon(Icons.business_rounded),
      label: "175".tr, // Companies
    ),
    // ADDED NEW ITEM
    BottomNavigationBarItem(
      icon: const Icon(Icons.folder_outlined),
      activeIcon: const Icon(Icons.folder_rounded),
      label: "381".tr, // Add "Projects" to translations if needed
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.monetization_on_outlined),
      activeIcon: const Icon(Icons.monetization_on),
      label: "finance".tr, // Add to translations
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.person_outline_rounded),
      activeIcon: const Icon(Icons.person_rounded),
      label: "178".tr, // Profile
    ),
  ];

  void onTapBottom(int index) {
    currentIndex = index;
    update();
  }
}
