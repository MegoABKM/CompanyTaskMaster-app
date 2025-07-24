// lib/view/screen/company/manager/finance/company_finance_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/finance/company_finance_controller.dart';
import 'package:companymanagment/core/class/handlingdataview.dart';
import 'package:companymanagment/view/widget/company/manager/home/empty_state_widget.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:companymanagment/data/model/company/finance_model.dart';

class CompanyFinancePage extends StatelessWidget {
  const CompanyFinancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CompanyFinanceController controller =
        Get.put(CompanyFinanceController());
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('company_finances'.tr),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'add_entry'.tr,
            onSelected: (value) => controller.navigateToAddEntry(value),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'Income',
                child: ListTile(
                    leading: const Icon(Icons.add, color: Colors.green),
                    title: Text('add_income'.tr)),
              ),
              PopupMenuItem<String>(
                value: 'Expense',
                child: ListTile(
                    leading: const Icon(Icons.remove, color: Colors.red),
                    title: Text('add_expense'.tr)),
              ),
            ],
          ),
        ],
      ),
      body: GetBuilder<CompanyFinanceController>(
        builder: (c) => Handlingdataview(
          statusRequest: c.statusRequest,
          widget: RefreshIndicator(
            onRefresh: () => c.fetchFinancialData(),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildSectionTitle('financial_dashboard'.tr, theme),
                _buildCompanySummaryGrid(c, theme),
                const SizedBox(height: 24),
                _buildSectionTitle('projects_profitability'.tr, theme),
                _buildProjectsSummaryList(c, theme),
                const SizedBox(height: 24),
                _buildSectionTitle('recent_company_transactions'.tr, theme),
                _buildTransactionList(c, theme),
              ]
                  .animate(interval: 80.ms)
                  .fade(duration: 300.ms)
                  .slideY(begin: 0.1),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(title, style: theme.textTheme.headlineSmall),
    );
  }

  Widget _buildCompanySummaryGrid(CompanyFinanceController c, ThemeData theme) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _summaryCard('total_revenue'.tr, c.totalRevenue, Colors.green,
            Icons.trending_up, theme,
            isCurrency: true),
        _summaryCard('total_project_costs'.tr, c.totalCost, Colors.red,
            Icons.trending_down, theme,
            isCurrency: true),
        _summaryCard('gross_profit_margin'.tr, c.grossProfitMargin,
            Colors.purple, Icons.pie_chart_outline, theme,
            isPercentage: true),
        _summaryCard('net_profit_margin'.tr, c.netProfitMargin, Colors.teal,
            Icons.account_balance_wallet_outlined, theme,
            isPercentage: true),
        _summaryCard(
            'company_overhead'.tr,
            c.companyNetOverhead,
            c.companyNetOverhead >= 0
                ? Colors.blueAccent
                : Colors.orange.shade800,
            Icons.business_center_outlined,
            theme,
            isCurrency: true),
        _summaryCard(
            'overall_net_profit'.tr,
            c.overallNetProfit,
            c.overallNetProfit >= 0
                ? theme.colorScheme.primary
                : Colors.red.shade900,
            Icons.calculate_outlined,
            theme,
            isCurrency: true),
      ],
    );
  }

  Widget _buildProjectsSummaryList(
      CompanyFinanceController c, ThemeData theme) {
    if (c.projectSummaries.isEmpty) {
      return EmptyStateWidget(
          icon: Icons.folder_off_outlined, message: 'no_project_finances'.tr);
    }
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: c.projectSummaries.values.map((summary) {
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            title: Text(summary.projectName,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(
                '${'revenue'.tr}: ${NumberFormat.currency(symbol: '\$').format(summary.revenue)} | ${'costs'.tr}: ${NumberFormat.currency(symbol: '\$').format(summary.cost)}'),
            trailing: Text(
              NumberFormat.currency(symbol: '\$').format(summary.profit),
              style: TextStyle(
                color: summary.profit >= 0 ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () => c.navigateToProjectWorkspace(summary.projectId),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTransactionList(CompanyFinanceController c, ThemeData theme) {
    if (c.companyTransactions.isEmpty) {
      return EmptyStateWidget(
          icon: Icons.receipt_long_outlined, message: 'no_transactions_yet'.tr);
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: c.companyTransactions.length,
      itemBuilder: (context, index) {
        final CompanyFinanceModel item = c.companyTransactions[index];
        final isIncome = item.type == 'Income';
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Icon(isIncome ? Icons.add_circle : Icons.remove_circle,
                color: isIncome ? Colors.green : Colors.red),
            title: Text(item.description),
            subtitle: Text(DateFormat.yMMMd().format(item.date)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${isIncome ? '+' : '-'}${NumberFormat.currency(symbol: '\$').format(item.amount)}',
                  style: TextStyle(
                      color: isIncome ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      c.navigateToEditEntry(item);
                    } else if (value == 'delete') {
                      c.deleteCompanyEntry(item.id);
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                        value: 'edit', child: Text('edit'.tr)),
                    PopupMenuItem<String>(
                        value: 'delete', child: Text('delete'.tr)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _summaryCard(
      String title, double amount, Color color, IconData icon, ThemeData theme,
      {bool isCurrency = false, bool isPercentage = false}) {
    String formattedAmount;
    if (isCurrency) {
      formattedAmount =
          NumberFormat.currency(symbol: '\$', decimalDigits: 2).format(amount);
    } else if (isPercentage) {
      formattedAmount = '${amount.toStringAsFixed(1)}%';
    } else {
      formattedAmount = amount.toString();
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(title,
                        style:
                            theme.textTheme.bodyMedium?.copyWith(height: 1.2),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis)),
                Icon(icon, color: color, size: 24),
              ],
            ),
            const Spacer(),
            Text(
              formattedAmount,
              style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold, color: color, fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
