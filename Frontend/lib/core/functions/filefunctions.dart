import 'package:http_parser/http_parser.dart';

String determineFileType(String path) {
  final extension = path.split('.').last.toLowerCase();
  if (['jpg', 'jpeg', 'png', 'gif'].contains(extension)) {
    return 'image';
  } else if (['mp4', 'mov', 'avi'].contains(extension)) {
    return 'video';
  } else if (extension == 'pdf') {
    return 'pdf';
  } else if (['doc', 'docx'].contains(extension)) {
    return 'word';
  } else if (extension == 'ppt' || extension == 'pptx') {
    return 'powerpoint';
  } else {
    return 'unknown';
  }
}

MediaType getContentType(String type, String extension) {
  switch (type) {
    case 'image':
      return MediaType('image', extension);
    case 'pdf':
      return MediaType('application', 'pdf');
    case 'powerpoint':
      return MediaType('application',
          'vnd.openxmlformats-officedocument.presentationml.presentation');
    case 'audio':
      return MediaType('audio', extension);
    case 'word':
      return MediaType('application', 'msword');
    case 'video':
      return MediaType('video', extension);
    default:
      return MediaType('application', 'octet-stream');
  }
}
