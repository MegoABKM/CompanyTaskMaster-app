class SprintModel {
  int? sprintId;
  int? projectId;
  String? sprintName;
  String? sprintGoal;
  String? startDate;
  String? endDate;
  String? status;

  SprintModel({
    this.sprintId,
    this.projectId,
    this.sprintName,
    this.sprintGoal,
    this.startDate,
    this.endDate,
    this.status,
  });

  SprintModel.fromJson(Map<String, dynamic> json) {
    sprintId = json['sprint_id'];
    projectId = json['project_id'];
    sprintName = json['sprint_name'];
    sprintGoal = json['sprint_goal'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sprint_id'] = sprintId;
    data['project_id'] = projectId;
    data['sprint_name'] = sprintName;
    data['sprint_goal'] = sprintGoal;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['status'] = status;
    return data;
  }
}
