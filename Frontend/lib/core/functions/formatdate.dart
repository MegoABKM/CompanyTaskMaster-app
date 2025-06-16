import 'package:get/get.dart';

String formatDate(String? date) {
  if (date == null || date.isEmpty) return "328".tr; // No date provided
  try {
    final parsedDate = DateTime.parse(date.trim());
    return "${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}";
  } catch (e) {
    return "329".tr; // Invalid date
  }
}
