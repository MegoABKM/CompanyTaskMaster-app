import 'package:get/get.dart';

class HomeemployeepageController extends GetxController {
  int currentIndex = 0;

  // The list of BottomNavigationBarItems will now be built directly in the UI
  // to allow for easy use of GetX's translation (.tr) extension.
  // This list is no longer needed here.

  void onTapBottom(int index) {
    currentIndex = index;
    update();
  }
}
