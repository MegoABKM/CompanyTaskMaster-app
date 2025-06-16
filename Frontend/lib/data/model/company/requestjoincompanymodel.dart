class RequestJoinCompanyModel {
  int? employeeCompanyId;
  int? userId;
  String? daterequest;
  int? companyId;
  String? companyName;
  String? companyNickID;
  String? companyWorkes;
  String? usersName;
  String? usersEmail;
  int? usersPhone;
  String? usersImage;

  RequestJoinCompanyModel(
      {this.employeeCompanyId,
      this.userId,
      this.daterequest,
      this.companyId,
      this.companyName,
      this.companyNickID,
      this.companyWorkes,
      this.usersName,
      this.usersEmail,
      this.usersPhone,
      this.usersImage});

  RequestJoinCompanyModel.fromJson(Map<String, dynamic> json) {
    employeeCompanyId = json['employee_company_id'];
    userId = json['user_id'];
    daterequest = json['daterequest'];
    companyId = json['company_id'];
    companyName = json['company_name'];
    companyNickID = json['company_nickID'];
    companyWorkes = json['company_workes'];
    usersName = json['users_name'];
    usersEmail = json['users_email'];
    usersPhone = json['users_phone'];
    usersImage = json['users_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_company_id'] = this.employeeCompanyId;
    data['user_id'] = this.userId;
    data['daterequest'] = this.daterequest;
    data['company_id'] = this.companyId;
    data['company_name'] = this.companyName;
    data['company_nickID'] = this.companyNickID;
    data['company_workes'] = this.companyWorkes;
    data['users_name'] = this.usersName;
    data['users_email'] = this.usersEmail;
    data['users_phone'] = this.usersPhone;
    data['users_image'] = this.usersImage;
    return data;
  }
}
