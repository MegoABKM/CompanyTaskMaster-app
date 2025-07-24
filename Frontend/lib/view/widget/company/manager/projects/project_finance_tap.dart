// lib/view/widget/company/manager/projects/project_finance_tab.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:companymanagment/controller/company/manager/projects/project_workspace_controller.dart';
import 'package:companymanagment/view/widget/company/manager/home/empty_state_widget.dart';
import 'package:companymanagment/data/model/company/finance_model.dart';

class ProjectFinanceTab extends GetView<ProjectWorkspaceController> {
  const ProjectFinanceTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(
            AlertDialog(
              title: Text('add_project_entry'.tr),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.add_circle, color: Colors.green),
                    title: Text('add_revenue'.tr),
                    onTap: () {
                      Get.back();
                      controller.navigateToAddProjectEntry('Revenue');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.remove_circle, color: Colors.red),
                    title: Text('add_cost'.tr),
                    onTap: () {
                      Get.back();
                      controller.navigateToAddProjectEntry('Cost');
                    },
                  ),
                ],
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'add_entry'.tr,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildProjectSummary(theme),
          const SizedBox(height: 24),
          Text('transactions'.tr, style: theme.textTheme.titleMedium),
          const Divider(),
          _buildTransactionList(theme),
        ],
      ),
    );
  }

  Widget _buildProjectSummary(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSummaryRow(
                'revenue'.tr, controller.projectRevenue, Colors.green, theme),
            const SizedBox(height: 8),
            _buildSummaryRow(
                'costs'.tr, controller.projectCost, Colors.red, theme),
            const Divider(height: 24),
            _buildSummaryRow(
                'profit'.tr,
                controller.projectProfit,
                controller.projectProfit >= 0
                    ? theme.colorScheme.primary
                    : Colors.red,
                theme,
                isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
      String label, double value, Color color, ThemeData theme,
      {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: isTotal
                ? theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)
                : theme.textTheme.bodyLarge),
        Text(
          NumberFormat.currency(symbol: '\$').format(value),
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: isTotal ? 18 : 16,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionList(ThemeData theme) {
    if (controller.projectTransactions.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: EmptyStateWidget(
            icon: Icons.receipt_long, message: 'no_transactions_yet'.tr),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.projectTransactions.length,
      itemBuilder: (context, index) {
        final ProjectFinanceModel item = controller.projectTransactions[index];
        final isRevenue = item.type == 'Revenue';
        return ListTile(
          leading: Icon(isRevenue ? Icons.arrow_upward : Icons.arrow_downward,
              color: isRevenue ? Colors.green : Colors.red),
          title: Text(item.description),
          subtitle: Text(
              "${item.category.tr} - ${DateFormat.yMMMd().format(item.date)}"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${isRevenue ? '+' : '-'}${NumberFormat.currency(symbol: '\$').format(item.amount)}',
                style: TextStyle(color: isRevenue ? Colors.green : Colors.red),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') {
                    controller.navigateToEditProjectEntry(item);
                  } else if (value == 'delete') {
                    controller.deleteProjectEntry(item.id);
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(value: 'edit', child: Text('edit'.tr)),
                  PopupMenuItem<String>(
                      value: 'delete', child: Text('delete'.tr)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
