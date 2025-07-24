import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http; // Import http package correctly
import 'package:http_parser/http_parser.dart';
import 'package:companymanagment/data/datasource/remote/linkapi.dart';

Future<void> uploadFile(File file, String fileType) async {
  // if (file == null) return;

  var uri =
      Uri.parse(AppLink.fileUpload); // Your backend endpoint for file uploads
  var request = http.MultipartRequest('POST', uri);

  var stream = http.ByteStream(file.openRead());
  var length = await file.length();
  String fileExtension = file.path.split('.').last;

  // Set the appropriate content type based on file extension
  MediaType contentType;
  switch (fileType) {
    case 'image':
      contentType = MediaType('image', fileExtension);
      break;
    case 'pdf':
      contentType = MediaType('application', 'pdf');
      break;
    case 'powerpoint':
      contentType = MediaType('application',
          'vnd.openxmlformats-officedocument.presentationml.presentation');
      break;
    case 'audio':
      contentType = MediaType('audio', fileExtension);
      break;
    case 'word':
      contentType = MediaType('application', 'msword'); // For .doc files
      break;
    case 'video':
      contentType = MediaType('video', fileExtension);
      break;
    default:
      contentType = MediaType(
          'application', 'octet-stream'); // Default for unknown file types
  }

  var multipartFile = http.MultipartFile(
    'file',
    stream,
    length,
    filename: file.path.split('/').last,
    contentType: contentType,
  );
  request.files.add(multipartFile);

  var response = await request.send();

  if (response.statusCode == 200) {
    var responseBody = await response.stream.bytesToString();
    print('Upload successful: $responseBody');

    // Parse the response to get the filename
    final responseJson = jsonDecode(responseBody);
    if (responseJson['status'] == 'success') {
      print('File uploaded: ${responseJson['filename']}');
    } else {
      print('File upload failed: ${responseJson['message']}');
      Get.snackbar("Error", "File upload failed.");
    }
  } else {
    print('Failed to upload file: ${response.statusCode}');
  }
}
