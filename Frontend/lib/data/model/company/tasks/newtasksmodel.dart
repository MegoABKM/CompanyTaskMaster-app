class Newtasks {
  int? taskId;
  String? taskTitle;
  String? taskDescription;
  String? taskCreatedOn;
  String? taskDueDate;
  String? taskPriority;
  String? taskStatus;
  String? taskUpdatedDate;
  int? companyId;
  String? companyName;
  String? companyImage;

  Newtasks(
      {this.taskId,
      this.taskTitle,
      this.taskDescription,
      this.taskCreatedOn,
      this.taskDueDate,
      this.taskPriority,
      this.taskStatus,
      this.companyId,
      this.companyName,
      this.companyImage});

  Newtasks.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'];
    taskTitle = json['task_title'];
    taskDescription = json['task_description'];
    taskCreatedOn = json['task_created_on'];
    taskDueDate = json['task_due_date'];
    taskPriority = json['task_priority'];
    taskStatus = json['task_status'];
    taskUpdatedDate = json['task_updateddate'];
    companyId = json['company_id'];
    companyName = json['company_name'];
    companyImage = json['company_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_id'] = this.taskId;
    data['task_title'] = this.taskTitle;
    data['task_description'] = this.taskDescription;
    data['task_created_on'] = this.taskCreatedOn;
    data['task_due_date'] = this.taskDueDate;
    data['task_priority'] = this.taskPriority;
    data['task_status'] = this.taskStatus;
    data['task_updateddate'] = this.taskUpdatedDate;
    data['company_id'] = this.companyId;
    data['company_name'] = this.companyName;
    data['company_image'] = this.companyImage;
    return data;
  }
}
