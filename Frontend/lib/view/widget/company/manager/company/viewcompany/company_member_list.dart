import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/crudcompany/viewcompany_controller.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';
import 'package:companymanagment/view/widget/company/manager/home/empty_state_widget.dart';

class CompanyMemberList extends GetView<ViewcompanyController> {
  final CompanyModel companyData;

  const CompanyMemberList({super.key, required this.companyData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'key_team_members'.tr,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Divider(height: 24),
            _buildMemberTile(
              context,
              name: companyData.manager?.managerName ?? 'not_available'.tr,
              email: companyData.manager?.managerEmail ?? 'not_available'.tr,
              role: 'role_manager'.tr,
              imageUrl: controller.getCompanyprofileImageUrl(
                  companyData.manager?.managerImage ?? ''),
              isManager: true,
            ),
            if (companyData.employees?.isNotEmpty ?? false)
              ...companyData.employees!.map(
                (employee) => _buildMemberTile(
                  context,
                  name: employee.employeeName ?? 'not_available'.tr,
                  email: employee.employeeEmail ?? 'not_available'.tr,
                  role: 'role_employee'.tr,
                  imageUrl: controller
                      .getCompanyprofileImageUrl(employee.employeeImage ?? ''),
                  onTap: () => controller.showEmployeeOptions(
                      context, employee), // <-- Make tile tappable
                ),
              ),
            if (companyData.employees?.isEmpty ?? true)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: EmptyStateWidget(
                  icon: Icons.person_off_outlined,
                  message: 'no_employees_yet'.tr,
                  details: 'employees_will_appear_here'.tr,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberTile(
    BuildContext context, {
    required String name,
    required String email,
    required String role,
    required String imageUrl,
    bool isManager = false,
    VoidCallback? onTap, // Changed from onRemove
  }) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: onTap, // Use the new onTap callback
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage(imageUrl),
        onBackgroundImageError: (_, __) {},
        child: imageUrl.isEmpty
            ? Text(name.isNotEmpty ? name[0].toUpperCase() : 'U')
            : null,
      ),
      title: Text(name, style: theme.textTheme.bodyLarge),
      subtitle: Text(role, style: theme.textTheme.bodySmall),
      trailing: isManager ? null : const Icon(Icons.more_vert), // Options icon
    );
  }
}
