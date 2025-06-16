class UserModel {
  String? usersName;
  String? usersEmail;
  int? usersPhone;
  String? usersImage;
  int? usersRole;

  UserModel(
      {this.usersName,
      this.usersEmail,
      this.usersPhone,
      this.usersImage,
      this.usersRole});

  UserModel.fromJson(Map<String, dynamic> json) {
    usersName = json['users_name'];
    usersEmail = json['users_email'];
    usersPhone = json['users_phone'];
    usersImage = json['users_image'];
    usersRole = json['users_role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['users_name'] = this.usersName;
    data['users_email'] = this.usersEmail;
    data['users_phone'] = this.usersPhone;
    data['users_image'] = this.usersImage;
    data['users_role'] = this.usersRole;
    return data;
  }
}
