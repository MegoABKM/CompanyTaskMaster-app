class CompanyModel {
  String? companyId;
  String? companyName;
  String? companyDescription;
  String? companyJob;
  String? companyImage;
  String? companyNickID;
  String? companyWorkes;
  Manager? manager;
  List<Employees>? employees;

  CompanyModel(
      {this.companyId,
      this.companyName,
      this.companyDescription,
      this.companyJob,
      this.companyImage,
      this.companyNickID,
      this.companyWorkes,
      this.manager,
      this.employees});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    companyId = json['company_id']?.toString();
    companyName = json['company_name'];
    companyDescription = json['company_description'];
    companyJob = json['company_job'];
    companyImage = json['company_image'];
    companyNickID = json['company_nickID'];
    companyWorkes = json['company_workes'];
    manager =
        json['manager'] != null ? Manager.fromJson(json['manager']) : null;
    if (json['employees'] != null) {
      employees = <Employees>[];
      json['employees'].forEach((v) {
        employees!.add(Employees.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company_id'] = companyId;
    data['company_name'] = companyName;
    data['company_description'] = companyDescription;
    data['company_job'] = companyJob;
    data['company_image'] = companyImage;
    data['company_nickID'] = companyNickID;
    data['company_workes'] = companyWorkes;
    if (manager != null) {
      data['manager'] = manager!.toJson();
    }
    if (employees != null) {
      data['employees'] = employees!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Manager {
  String? managerId;
  String? managerName;
  String? managerEmail;
  String? managerImage;

  Manager(
      {this.managerId, this.managerName, this.managerEmail, this.managerImage});

  Manager.fromJson(Map<String, dynamic> json) {
    managerId = json['manager_id']?.toString();
    managerName = json['manager_name'];
    managerEmail = json['manager_email'];
    managerImage = json['manager_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manager_id'] = managerId;
    data['manager_name'] = managerName;
    data['manager_email'] = managerEmail;
    data['manager_image'] = managerImage;
    return data;
  }
}

class Employees {
  String? employeeId;
  String? employeeName;
  String? employeeEmail;
  int? employeePhone;
  String? employeeImage;

  Employees(
      {this.employeeId,
      this.employeeName,
      this.employeeEmail,
      this.employeePhone,
      this.employeeImage});

  Employees.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id']?.toString();
    employeeName = json['employee_name'];
    employeeEmail = json['employee_email'];
    employeePhone = json['employee_phone'];
    employeeImage = json['employee_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = employeeId;
    data['employee_name'] = employeeName;
    data['employee_email'] = employeeEmail;
    data['employee_phone'] = employeePhone;
    data['employee_image'] = employeeImage;
    return data;
  }
}
