class TaskCompanyModel {
  String? id;
  String? companyId;
  String? title;
  String? description;
  String? createdOn;
  String? dueDate;
  String? priority;
  String? status;
  String? lastUpdated;

  TaskCompanyModel({
    this.id,
    this.companyId,
    this.title,
    this.description,
    this.createdOn,
    this.dueDate,
    this.priority,
    this.status,
    this.lastUpdated,
  });

  TaskCompanyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    companyId = json['company_id'].toString();
    title = json['title'];
    description = json['description'];
    createdOn = json['created_on'];
    dueDate = json['due_date'];
    priority = json['priority'];
    status = json['status'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['created_on'] = this.createdOn;
    data['due_date'] = this.dueDate;
    data['priority'] = this.priority;
    data['status'] = this.status;
    data['last_updated'] = this.lastUpdated;
    return data;
  }
}
