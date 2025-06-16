// lib/data/model/usernotesmodel.dart
class UserNotesModel {
  final String? id;
  final String? title;
  final String? content;
  final String? date;
  final String? drawing;
  final String? categoryId;

  UserNotesModel(
      {this.id,
      this.title,
      this.content,
      this.date,
      this.drawing,
      this.categoryId});

  factory UserNotesModel.fromJson(Map<String, dynamic> json) {
    return UserNotesModel(
      id: json['id']?.toString(),
      title: json['title']?.toString(),
      content: json['content']?.toString(),
      date: json['Date']?.toString(),
      drawing: json['drawing']?.toString(),
      categoryId: json['categoryId']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'Date': date,
      'drawing': drawing,
      'categoryId': categoryId,
    };
  }
}
