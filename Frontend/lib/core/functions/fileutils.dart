import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasknotate/data/datasource/remote/company/filedata.dart';
import 'package:tasknotate/data/model/company/tasks/attachmentmodel.dart';
import 'package:tasknotate/data/datasource/remote/linkapi.dart';

class FileUtils {
  static final ImagePicker _picker = ImagePicker();

  Filedata fileData = Filedata(Get.find());

  static Future<void> uploadFile({
    required File file,
    required String fileType,
    required String? taskId,
    required String filename,
    required Function onSuccess,
    required Function onFailure,
  }) async {
    if (taskId == null) {
      Get.snackbar("Error", "Task ID is missing.");
      return;
    }

    try {
      var uri = Uri.parse(AppLink.fileUpload);
      var request = http.MultipartRequest('POST', uri);

      var stream = http.ByteStream(file.openRead());
      var length = await file.length();
      String fileExtension = file.path.split('.').last;

      MediaType contentType = getContentType(fileType, fileExtension);

      var multipartFile = http.MultipartFile(
        'file',
        stream,
        length,
        filename: file.path.split('/').last,
        contentType: contentType,
      );

      request.files.add(multipartFile);
      request.fields['task_id'] = taskId;

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        final responseJson = jsonDecode(responseBody);

        if (responseJson['status'] == 'success') {
          print('File uploaded: ${responseJson['filename']}');
          onSuccess(responseJson['filename']);
        } else {
          onFailure("Upload failed: ${responseJson['message']}");
        }
      } else {
        onFailure("Failed to upload file.");
      }
    } catch (error) {
      onFailure("An error occurred: $error");
    }
  }

  static Future<File?> pickFile() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  static String determineFileType(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();
    if (['jpg', 'jpeg', 'png', 'gif'].contains(extension)) return 'image';
    if (['mp4', 'avi', 'mov'].contains(extension)) return 'video';
    return 'document';
  }

  static MediaType getContentType(String fileType, String fileExtension) {
    switch (fileType) {
      case 'image':
        return MediaType('image', fileExtension);
      case 'video':
        return MediaType('video', fileExtension);
      default:
        return MediaType('application', 'octet-stream');
    }
  }

  static Future<http.MultipartRequest> buildUploadRequest({
    required Uri uri,
    required File file,
    required String fileType,
    required Map<String, String> fields,
  }) async {
    final stream = http.ByteStream(file.openRead());
    final length = await file.length();
    final fileExtension = file.path.split('.').last;
    final contentType = getContentType(fileType, fileExtension);

    final multipartFile = http.MultipartFile(
      'file',
      stream,
      length,
      filename: file.path.split('/').last,
      contentType: contentType,
    );

    final request = http.MultipartRequest('POST', uri);
    request.files.add(multipartFile);
    request.fields.addAll(fields);
    return request;
  }

  static Future<List<AttachmentModel>> fetchAttachments(String? taskId) async {
    try {
      var response = await Filedata(Get.find()).getData(taskId);
      print("Response: $response");

      if (response['status'] == "success") {
        var data = response['data'] as List<dynamic>? ?? [];
        var newAttachments = data
            .map((item) {
              try {
                return AttachmentModel.fromJson(item);
              } catch (e) {
                print("Error parsing attachment: $e");
                return null;
              }
            })
            .whereType<AttachmentModel>()
            .toList();
        return newAttachments;
      } else {
        print(
            "Failed to fetch attachments: ${response['error'] ?? 'Unknown error'}");
        return [];
      }
    } catch (e) {
      print("Error fetching attachments: $e");
      return [];
    }
  }

  void showSnackbar(String title, String message) {
    Get.snackbar(title, message);
  }

  static bool validateInputs(
      File? file, String? taskId, TextEditingController fileNameController) {
    if (file == null || taskId == null || fileNameController.text.isEmpty) {
      Get.snackbar("Error", "Missing required inputs.");
      return true;
    }
    return false;
  }

  Future<void> saveFileToDatabase(String serverFilename,
      TextEditingController fileNameController, String? taskId) async {
    final fileExtension = serverFilename.split('.').last;
    final userFilenameWithExt = '${fileNameController.text}.$fileExtension';

    try {
      final response = await http.post(
        Uri.parse(AppLink.saveattachment),
        body: {
          'taskid': taskId!,
          'filename': userFilenameWithExt,
          'url': 'upload/files/company/$serverFilename',
        },
      );

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        if (responseJson['status'] != 'success') {
          showSnackbar("Error", "Failed to save file in database.");
        }
      } else {
        showSnackbar("Error", "Failed to save file in database.");
      }
    } catch (error) {
      showSnackbar("Error", "An error occurred while saving the file: $error");
    }
  }
}
