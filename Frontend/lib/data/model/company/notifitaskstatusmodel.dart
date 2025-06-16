class TaskCheckModel {
  int? checktaskId;
  String? checktaskStatus;
  String? checktaskDate;
  int? taskId;
  String? taskName;
  int? employeeId;
  String? employeeName;
  String? employeeEmail;
  String? employeeImage;
  String? companyName;
  int? taskCompanyId;

  TaskCheckModel(
      {this.checktaskId,
      this.checktaskStatus,
      this.checktaskDate,
      this.taskId,
      this.taskName,
      this.employeeId,
      this.employeeName,
      this.employeeEmail,
      this.employeeImage,
      this.companyName,
      this.taskCompanyId});

  TaskCheckModel.fromJson(Map<String, dynamic> json) {
    checktaskId = json['checktask_id'];
    checktaskStatus = json['checktask_status'];
    checktaskDate = json['checktask_date'];
    taskId = json['task_id'];
    taskName = json['task_name'];
    employeeId = json['employee_id'];
    employeeName = json['employee_name'];
    employeeEmail = json['employee_email'];
    employeeEmail = json['employee_image'];
    companyName = json['company_name'];
    taskCompanyId = json['task_company_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['checktask_id'] = this.checktaskId;
    data['checktask_status'] = this.checktaskStatus;
    data['checktask_date'] = this.checktaskDate;
    data['task_id'] = this.taskId;
    data['task_name'] = this.taskName;
    data['employee_id'] = this.employeeId;
    data['employee_name'] = this.employeeName;
    data['employee_email'] = this.employeeEmail;
    data['employee_image'] = this.employeeEmail;
    data['company_name'] = this.companyName;
    data['task_company_id'] = this.taskCompanyId;
    return data;
  }
}
