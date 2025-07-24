// lib/controller/company/manager/finance/add_entry_controller.dart
import 'package:companymanagment/data/datasource/remote/company/manager/add_entry_data.dart';
import 'package:companymanagment/data/datasource/remote/company/manager/finance_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:intl/intl.dart';
import 'package:companymanagment/data/model/company/finance_model.dart'; // Import models

class AddEntryController extends GetxController {
  final AddEntryData addEntryData = AddEntryData(Get.find());
  // Use the main FinanceData for updates
  final FinanceData financeData = FinanceData(Get.find());
  StatusRequest? statusRequest;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  late TextEditingController descriptionController;
  late TextEditingController amountController;
  late TextEditingController dateController;

  String? entryType; // e.g., 'Income', 'Expense', 'Revenue', 'Cost'
  String? companyId;
  String? projectId;

  // NEW: For editing
  bool isEditMode = false;
  int? editingId;

  final List<String> expenseCategories = [
    'Salaries',
    'Rent',
    'Utilities',
    'Marketing',
    'Supplies',
    'General'
  ];
  final List<String> costCategories = [
    'Materials',
    'Labor',
    'Contractor',
    'Travel',
    'Uncategorized'
  ];
  String? selectedCategory;

  @override
  void onInit() {
    super.onInit();

    // Check if we are editing an existing entry
    if (Get.arguments['entryToEdit'] != null) {
      isEditMode = true;
      var entry = Get.arguments['entryToEdit'];

      if (entry is CompanyFinanceModel) {
        editingId = entry.id;
        entryType = entry.type;
        descriptionController = TextEditingController(text: entry.description);
        amountController = TextEditingController(text: entry.amount.toString());
        dateController = TextEditingController(
            text: DateFormat('yyyy-MM-dd').format(entry.date));
        selectedCategory = entry.category;
      } else if (entry is ProjectFinanceModel) {
        editingId = entry.id;
        entryType = entry.type;
        descriptionController = TextEditingController(text: entry.description);
        amountController = TextEditingController(text: entry.amount.toString());
        dateController = TextEditingController(
            text: DateFormat('yyyy-MM-dd').format(entry.date));
        selectedCategory = entry.category;
      }
    } else {
      // We are adding a new entry
      isEditMode = false;
      descriptionController = TextEditingController();
      amountController = TextEditingController();
      dateController = TextEditingController(
          text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
      entryType = Get.arguments['entryType'];
    }

    companyId = Get.arguments['companyId'];
    projectId = Get.arguments['projectId'];
  }

  void selectCategory(String? value) {
    selectedCategory = value;
    update();
  }

  void pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(dateController.text) ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      update();
    }
  }

  Future<void> submitEntry() async {
    if (!formState.currentState!.validate()) return;

    statusRequest = StatusRequest.loading;
    update();

    if (isEditMode) {
      await _updateEntry();
    } else {
      await _addEntry();
    }
  }

  Future<void> _addEntry() async {
    Map<String, String> data = {
      'type': entryType!,
      'description': descriptionController.text,
      'amount': amountController.text,
      'date': dateController.text,
      'category': selectedCategory ??
          (entryType == 'Expense' || entryType == 'Cost' ? 'General' : ''),
      'company_id': companyId!,
    };
    if (projectId != null) {
      data['project_id'] = projectId!;
    }

    var response = await addEntryData.postData(data);
    handleResponse(response);
  }

  Future<void> _updateEntry() async {
    String typeIdentifier = (entryType == 'Income' || entryType == 'Expense')
        ? 'company'
        : 'project';

    var response = await financeData.updateEntry(
      id: editingId!,
      type: typeIdentifier,
      description: descriptionController.text,
      amount: amountController.text,
      date: dateController.text,
      category: selectedCategory ??
          (entryType == 'Expense' || entryType == 'Cost' ? 'General' : ''),
    );
    handleResponse(response);
  }

  void handleResponse(dynamic response) {
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        Get.back(result: 'success'); // Go back and signal a refresh
        Get.snackbar(
            'Success',
            isEditMode
                ? 'Entry updated successfully.'
                : 'Financial entry added successfully.');
      } else {
        Get.snackbar(
            'Error', response['message'] ?? 'Failed to process entry.');
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    amountController.dispose();
    dateController.dispose();
    super.dispose();
  }
}
