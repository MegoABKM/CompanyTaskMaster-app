import 'package:flutter/material.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';
import 'package:companymanagment/controller/company/manager/crudcompany/viewcompany_controller.dart';
import 'package:get/get.dart';

class CompanySliverAppBar extends GetView<ViewcompanyController> {
  final CompanyModel companyData;
  const CompanySliverAppBar({super.key, required this.companyData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      backgroundColor: theme.colorScheme.primary,
      actions: [
        IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: () => controller.goToUpdateCompany(),
          tooltip: 'edit_company'.tr,
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          companyData.companyName ?? 'company_details'.tr,
          style: theme.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              controller.getCompanyImageUrl(companyData.companyImage ?? ''),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: Colors.grey),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.0, 0.5),
                  end: Alignment.center,
                  colors: <Color>[
                    Color(0x60000000),
                    Color(0x00000000),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
