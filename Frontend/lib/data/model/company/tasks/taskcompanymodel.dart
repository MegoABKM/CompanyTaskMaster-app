// lib/data/model/company/tasks/taskcompanymodel.dart
class TaskCompanyModel {
  String? id;
  String? companyId;
  String? projectId;
  int? sprintId;
  String? title;
  String? description;
  String? createdOn;
  String? startDate; // <-- ADD THIS
  String? dueDate;
  String? priority;
  String? status;
  String? lastUpdated;

  TaskCompanyModel({
    this.id,
    this.companyId,
    this.projectId,
    this.sprintId,
    this.title,
    this.description,
    this.createdOn,
    this.startDate, // <-- ADD THIS
    this.dueDate,
    this.priority,
    this.status,
    this.lastUpdated,
  });

  TaskCompanyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    companyId = json['company_id'].toString();
    projectId = json['project_id']?.toString();
    sprintId = json['sprint_id'];
    title = json['title'];
    description = json['description'];
    createdOn = json['created_on'];
    startDate = json['start_date']; // <-- ADD THIS
    dueDate = json['due_date'];
    priority = json['priority'];
    status = json['status'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_id'] = companyId;
    data['project_id'] = projectId;
    data['sprint_id'] = sprintId;
    data['title'] = title;
    data['description'] = description;
    data['created_on'] = createdOn;
    data['start_date'] = startDate; // <-- ADD THIS
    data['due_date'] = dueDate;
    data['priority'] = priority;
    data['status'] = status;
    data['last_updated'] = lastUpdated;
    return data;
  }
}
