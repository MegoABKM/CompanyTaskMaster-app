// lib/controller/company/manager/finance/company_finance_controller.dart
import 'package:companymanagment/view/screen/company/manager/projects/project_workspace_page.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/data/datasource/remote/company/manager/finance_date.dart';
import 'package:companymanagment/data/model/company/finance_model.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/homemanager/home_manager_controller.dart';
import 'package:companymanagment/data/model/company/project_model.dart';
import 'package:companymanagment/view/screen/company/manager/finance/add_financial_entry_page.dart';

class CompanyFinanceController extends GetxController {
  final FinanceData financeData = FinanceData(Get.find());
  StatusRequest? statusRequest;
  late String companyId;

  List<CompanyFinanceModel> companyTransactions = [];
  List<ProjectFinanceModel> projectTransactions = [];
  Map<int, ProjectFinanceSummary> projectSummaries = {};

  // Base Totals
  double totalIncome = 0.0;
  double totalExpense = 0.0;
  double totalRevenue = 0.0;
  double totalCost = 0.0;

  // Level 1 Calculations
  double get companyNetOverhead => totalIncome - totalExpense;
  double get totalProjectProfit => totalRevenue - totalCost;

  // Level 2 Calculations
  double get overallNetProfit =>
      (totalRevenue + totalIncome) - (totalCost + totalExpense);
  double get totalOverallIncome => totalRevenue + totalIncome;

  // --- NEW FINANCIAL METRICS (from book concepts) ---

  /// Gross Profit Margin: How profitable are the projects themselves?
  /// (Project Profit / Project Revenue) * 100
  double get grossProfitMargin {
    if (totalRevenue == 0) return 0.0; // Avoid division by zero
    return (totalProjectProfit / totalRevenue) * 100;
  }

  /// Net Profit Margin: What's the final profit margin for the whole company?
  /// (Overall Profit / Total Overall Income) * 100
  double get netProfitMargin {
    if (totalOverallIncome == 0) return 0.0; // Avoid division by zero
    return (overallNetProfit / totalOverallIncome) * 100;
  }

  // --- END OF NEW METRICS ---

  @override
  void onInit() {
    super.onInit();
    final managerController = Get.find<ManagerhomeController>();
    if (managerController.companyData.isNotEmpty) {
      companyId = managerController.companyData.first.companyId!;
      fetchFinancialData();
    } else {
      statusRequest = StatusRequest.failure;
    }
  }

  Future<void> fetchFinancialData() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await financeData.getSummary(companyId);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success &&
        response['status'] == 'success') {
      var data = response['data'];
      companyTransactions = (data['company_finances'] as List? ?? [])
          .map((e) => CompanyFinanceModel.fromJson(e))
          .toList();
      projectTransactions = (data['project_finances'] as List? ?? [])
          .map((e) => ProjectFinanceModel.fromJson(e))
          .toList();

      var projects = (data['projects'] as List? ?? [])
          .map((e) => ProjectModel.fromJson(e))
          .toList();
      _calculateTotals(projects);
    }
    update();
  }

  void _calculateTotals(List<ProjectModel> projects) {
    totalIncome = 0;
    totalExpense = 0;
    totalRevenue = 0;
    totalCost = 0;
    projectSummaries.clear();

    totalIncome = companyTransactions
        .where((e) => e.type == 'Income')
        .fold(0, (sum, item) => sum + item.amount);
    totalExpense = companyTransactions
        .where((e) => e.type == 'Expense')
        .fold(0, (sum, item) => sum + item.amount);

    for (var transaction in projectTransactions) {
      if (transaction.type == 'Revenue') {
        totalRevenue += transaction.amount;
      } else if (transaction.type == 'Cost') {
        totalCost += transaction.amount;
      }

      projectSummaries.putIfAbsent(
        transaction.projectId,
        () => ProjectFinanceSummary(
          projectId: transaction.projectId,
          projectName: projects
                  .firstWhere((p) => p.projectId == transaction.projectId,
                      orElse: () =>
                          ProjectModel(projectName: 'Unknown Project'))
                  .projectName ??
              'Unknown',
        ),
      );
      projectSummaries[transaction.projectId]!.add(transaction);
    }
    update();
  }

  void navigateToAddEntry(String type) async {
    final result =
        await Get.to(() => const AddFinancialEntryPage(), arguments: {
      'entryType': type,
      'companyId': companyId,
      'projectId': null,
      'entryToEdit': null,
    });
    if (result == 'success') {
      fetchFinancialData();
    }
  }

  void navigateToEditEntry(CompanyFinanceModel entry) async {
    final result =
        await Get.to(() => const AddFinancialEntryPage(), arguments: {
      'entryType': entry.type,
      'companyId': companyId,
      'projectId': null,
      'entryToEdit': entry,
    });
    if (result == 'success') {
      fetchFinancialData();
    }
  }

  void deleteCompanyEntry(int id) async {
    var response = await financeData.deleteEntry(id: id, type: 'company');
    if (response['status'] == 'success') {
      Get.snackbar('Success', 'Entry deleted successfully.');
      fetchFinancialData();
    } else {
      Get.snackbar('Error', 'Failed to delete entry.');
    }
  }

  void navigateToProjectWorkspace(int projectId) {
    final managerController = Get.find<ManagerhomeController>();
    final projectModel = managerController.activeProjects
        .firstWhereOrNull((p) => p.projectId == projectId);
    if (projectModel != null) {
      Get.to(() => const ProjectWorkspacePage(),
          arguments: {'project': projectModel});
    } else {
      Get.snackbar('Error', 'Project details not found.');
    }
  }
}

class ProjectFinanceSummary {
  final int projectId;
  final String projectName;
  double revenue = 0.0;
  double cost = 0.0;
  double get profit => revenue - cost;

  ProjectFinanceSummary({required this.projectId, required this.projectName});

  void add(ProjectFinanceModel transaction) {
    if (transaction.type == 'Revenue') {
      revenue += transaction.amount;
    } else if (transaction.type == 'Cost') {
      cost += transaction.amount;
    }
  }
}
