class CompanyFinanceModel {
  final int id;
  final int companyId;
  final String type; // 'Income' or 'Expense'
  final String description;
  final double amount;
  final DateTime date;
  final String category;

  CompanyFinanceModel({
    required this.id,
    required this.companyId,
    required this.type,
    required this.description,
    required this.amount,
    required this.date,
    required this.category,
  });

  factory CompanyFinanceModel.fromJson(Map<String, dynamic> json) {
    return CompanyFinanceModel(
      id: json['id'],
      companyId: json['company_id'],
      type: json['type'],
      description: json['description'],
      amount: double.parse(json['amount'].toString()),
      date: DateTime.parse(json['date']),
      category: json['category'],
    );
  }
}

class ProjectFinanceModel {
  final int id;
  final int projectId;
  final String type; // 'Revenue' or 'Cost'
  final String description;
  final double amount;
  final DateTime date;
  final String category;

  ProjectFinanceModel({
    required this.id,
    required this.projectId,
    required this.type,
    required this.description,
    required this.amount,
    required this.date,
    required this.category,
  });

  factory ProjectFinanceModel.fromJson(Map<String, dynamic> json) {
    return ProjectFinanceModel(
      id: json['id'],
      projectId: json['project_id'],
      type: json['type'],
      description: json['description'],
      amount: double.parse(json['amount'].toString()),
      date: DateTime.parse(json['date']),
      category: json['category'],
    );
  }
}
