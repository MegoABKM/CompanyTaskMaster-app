class SubtaskModel {
  final int id; // Unique identifier for the subtask
  String title;
  String description;

  SubtaskModel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory SubtaskModel.fromJson(Map<String, dynamic> json) {
    return SubtaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
    };
  }
}
