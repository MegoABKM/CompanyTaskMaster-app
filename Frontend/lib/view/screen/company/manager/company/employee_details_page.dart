import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/view/widget/profile/profile_info_tile.dart';
import 'package:companymanagment/data/datasource/remote/linkapi.dart';

class EmployeeDetailsPage extends StatelessWidget {
  const EmployeeDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Employees employee = Get.arguments['employee'];
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(employee.employeeName ?? 'employee_details'.tr),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    "${AppLink.imageprofileplace}${employee.employeeImage}",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(color: theme.primaryColor.withOpacity(0.3)),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[Colors.transparent, Colors.black54],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.all(scale.scale(16)),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: EdgeInsets.all(scale.scale(16)),
                    child: Column(
                      children: [
                        ProfileInfoTile(
                            icon: Icons.person_outline,
                            label: 'Name',
                            value: employee.employeeName ?? 'N/A'),
                        const Divider(height: 24),
                        ProfileInfoTile(
                            icon: Icons.email_outlined,
                            label: 'Email',
                            value: employee.employeeEmail ?? 'N/A'),
                        const Divider(height: 24),
                        ProfileInfoTile(
                            icon: Icons.phone_outlined,
                            label: 'Phone',
                            value: employee.employeePhone?.toString() ?? 'N/A'),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
