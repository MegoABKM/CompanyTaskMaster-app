import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskDateFormatter {
  String format(String? date) {
    if (date == null || date == "Not Set" || date.isEmpty) {
      return "Not Set".tr; // Use translation for "Not Set"
    }

    try {
      // Parse ISO8601 string
      final dateTime = DateTime.parse(date);
      // Format to a readable format, e.g., "2025-05-02 at 10:30"
      final formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
      final formattedTime = DateFormat('HH:mm').format(dateTime);
      return "$formattedDate at $formattedTime";
    } catch (e) {
      print("Error formatting date: $date, error: $e");
      return "Not Set".tr; // Fallback for invalid date strings
    }
  }
}
