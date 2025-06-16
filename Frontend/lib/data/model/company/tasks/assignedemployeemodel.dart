class Assignedemployeemodel {
  String? userId;
  String? usersName;
  String? usersPhone;
  String? usersEmail;

  Assignedemployeemodel(
      {this.userId, this.usersName, this.usersPhone, this.usersEmail});

  Assignedemployeemodel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id']?.toString();
    usersName = json['users_name'];
    usersPhone = json['users_phone']?.toString();
    usersEmail = json['users_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['users_name'] = this.usersName;
    data['users_phone'] = this.usersPhone;
    data['users_email'] = this.usersEmail;
    return data;
  }
}
