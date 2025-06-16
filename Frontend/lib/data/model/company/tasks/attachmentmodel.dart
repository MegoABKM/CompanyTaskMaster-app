class AttachmentModel {
  final int id;
  final String filename;
  final String url;
  final String uploadedAt;

  AttachmentModel({
    required this.id,
    required this.filename,
    required this.url,
    required this.uploadedAt,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) {
    return AttachmentModel(
      id: json['id'],
      filename: json['filename'],
      url: json['url'],
      uploadedAt: json['uploaded_at'],
    );
  }
}
