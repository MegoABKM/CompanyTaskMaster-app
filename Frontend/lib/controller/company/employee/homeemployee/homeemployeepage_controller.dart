import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeemployeepageController extends GetxController {
  int currentIndex = 0;

  List<BottomNavigationBarItem> itemsOfScreen = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: "Companies"),
    const BottomNavigationBarItem(icon: Icon(Icons.message), label: "Messages"),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  ];

  void onTapBottom(int index) {
    currentIndex = index;
    update(); // Notify GetBuilder to rebuild the UI
  }
}
