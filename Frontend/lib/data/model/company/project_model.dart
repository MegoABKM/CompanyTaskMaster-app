import 'package:companymanagment/data/model/company/companymodel.dart';

class ProjectModel {
  int? projectId;
  String? projectName;
  String? methodologyType;
  String? projectDescription;
  String? deadline;
  String? priority;
  int? companyId;
  String? companyName; // ADD THIS FIELD
  int? managerId;
  String? status;
  String? createdAt;
  int? taskCount;
  int? memberCount;
  List<Employees>? members;

  ProjectModel({
    this.projectId,
    this.projectName,
    this.methodologyType,
    this.projectDescription,
    this.deadline,
    this.priority,
    this.companyId,
    this.companyName, // ADD TO CONSTRUCTOR
    this.managerId,
    this.status,
    this.createdAt,
    this.taskCount,
    this.memberCount,
    this.members,
  });

  ProjectModel.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];
    projectName = json['project_name'];
    methodologyType = json['methodology_type'];
    projectDescription = json['project_description'];
    deadline = json['deadline'];
    priority = json['priority'];
    companyId = json['company_id'];
    companyName = json['company_name']; // ADD PARSING LOGIC
    managerId = json['manager_id'];
    status = json['status'];
    createdAt = json['created_at'];
    taskCount = int.tryParse(json['task_count'].toString());
    memberCount = int.tryParse(json['member_count'].toString());

    if (json['members'] != null) {
      members = <Employees>[];
      json['members'].forEach((v) {
        members!.add(Employees.fromJson(v));
      });
    }
  }
}
