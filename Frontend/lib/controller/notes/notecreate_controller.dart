import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/data/datasource/local/sqldb.dart';
import 'package:tasknotate/data/model/usernotesmodel.dart';
import 'package:tasknotate/controller/home_controller.dart';

class NotecreateController extends GetxController {
  TextEditingController? titleController;
  TextEditingController? insideTextField;
  int? selectedCategoryId;
  StatusRequest? statusRequest;
  SqlDb sqlDb = SqlDb();

  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  bool isDrawingMode = false;
  UserNotesModel? currentNote;
  int? lastInsertedId;

  void toggleDrawingMode() {
    isDrawingMode = !isDrawingMode;
    update();
  }

  Future<String?> getDrawingAsBase64() async {
    if (signatureController.isNotEmpty) {
      final bytes = await signatureController.toPngBytes();
      return bytes != null ? base64Encode(bytes) : null;
    }
    return currentNote?.drawing;
  }

  void saveTitle(String value) {
    currentNote = UserNotesModel(
      id: lastInsertedId?.toString(),
      title: value,
      content: currentNote?.content ?? '',
      date: currentNote?.date ?? DateTime.now().toIso8601String(),
      drawing: currentNote?.drawing ?? '',
      categoryId: selectedCategoryId?.toString(),
    );
    uploadData();
  }

  void saveContent(String value) {
    currentNote = UserNotesModel(
      id: lastInsertedId?.toString(),
      title: currentNote?.title ?? titleController?.text ?? '',
      content: value,
      date: currentNote?.date ?? DateTime.now().toIso8601String(),
      drawing: currentNote?.drawing ?? '',
      categoryId: selectedCategoryId?.toString(),
    );
    uploadData();
  }

  void updateNoteCategory() {
    currentNote = UserNotesModel(
      id: lastInsertedId?.toString(),
      title: currentNote?.title ?? titleController?.text ?? '',
      content: currentNote?.content ?? '',
      date: currentNote?.date ?? DateTime.now().toIso8601String(),
      drawing: currentNote?.drawing ?? '',
      categoryId: selectedCategoryId?.toString(),
    );
    uploadData();
  }

  Future<void> uploadData() async {
    if (currentNote == null) {
      statusRequest = StatusRequest.failure;
      Get.snackbar('key_error'.tr, 'key_failed_to_create_note'.tr,
          snackPosition: SnackPosition.BOTTOM);
      update();
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    final drawingBase64 = await getDrawingAsBase64();

    currentNote = UserNotesModel(
      id: lastInsertedId?.toString(),
      title: currentNote!.title!.isEmpty ? 'Untitled' : currentNote!.title,
      content: currentNote!.content,
      date: currentNote!.date,
      drawing: drawingBase64 ?? currentNote!.drawing,
      categoryId: selectedCategoryId?.toString(),
    );

    try {
      if (lastInsertedId == null) {
        final response = await sqlDb.insertData(
          "INSERT INTO notes (title, content, date, drawing, categoryId) VALUES (?, ?, ?, ?, ?)",
          [
            currentNote!.title,
            currentNote!.content,
            currentNote!.date,
            currentNote!.drawing,
            currentNote!.categoryId,
          ],
        );

        if (response > 0) {
          lastInsertedId = response;
          statusRequest = StatusRequest.success;
          Get.find<HomeController>().getNoteData();
          Get.snackbar('key_success'.tr, 'key_note_created'.tr,
              snackPosition: SnackPosition.BOTTOM);
        } else {
          statusRequest = StatusRequest.failure;
          Get.snackbar('key_error'.tr, 'key_failed_to_create_note'.tr,
              snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        final response = await sqlDb.updateData(
          "UPDATE notes SET title = ?, content = ?, drawing = ?, categoryId = ? WHERE id = ?",
          [
            currentNote!.title,
            currentNote!.content,
            currentNote!.drawing,
            currentNote!.categoryId,
            lastInsertedId,
          ],
        );

        if (response > 0) {
          statusRequest = StatusRequest.success;
          Get.find<HomeController>().getNoteData();
          Get.snackbar('key_success'.tr, 'key_note_updated'.tr,
              snackPosition: SnackPosition.BOTTOM);
        } else {
          statusRequest = StatusRequest.failure;
          Get.snackbar('key_error'.tr, 'key_failed_to_update_note'.tr,
              snackPosition: SnackPosition.BOTTOM);
        }
      }
    } catch (e) {
      print("Error uploading note: $e");
      statusRequest = StatusRequest.failure;
      Get.snackbar('key_error'.tr, 'key_failed_to_create_note'.tr,
          snackPosition: SnackPosition.BOTTOM);
    }

    update();
  }

  @override
  void onInit() {
    titleController = TextEditingController();
    insideTextField = TextEditingController();
    currentNote = UserNotesModel(
      title: '',
      content: '',
      date: DateTime.now().toIso8601String(),
      drawing: '',
    );
    super.onInit();
  }

  @override
  void onClose() {
    titleController?.dispose();
    insideTextField?.dispose();
    signatureController.dispose();
    super.onClose();
  }
}
