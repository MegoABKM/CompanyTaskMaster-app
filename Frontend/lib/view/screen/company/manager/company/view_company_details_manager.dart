// lib/view/screen/company/manager/company/view_company_details_manager.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/crudcompany/viewcompany_controller.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_button_auth.dart';
import 'package:companymanagment/view/widget/company/manager/company/viewcompany/company_info_card.dart';
import 'package:companymanagment/view/widget/company/manager/company/viewcompany/company_member_list.dart';
import 'package:companymanagment/view/widget/company/manager/company/viewcompany/company_sliver_app_bar.dart';

class ViewCompanyManager extends StatelessWidget {
  const ViewCompanyManager({super.key});

  @override
  Widget build(BuildContext context) {
    final ViewcompanyController controller = Get.put(ViewcompanyController());
    final CompanyModel companyData = controller.companyData!;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Dynamic App Bar that collapses
          CompanySliverAppBar(companyData: companyData),

          // The rest of the content scrolls
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 16),
                CompanyInfoCard(companyData: companyData),
                CompanyMemberList(companyData: companyData),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomButtonAuth(
                    textbutton: "Go To Workspace",
                    onPressed: controller.goToWorkspace,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.delete_forever_outlined),
                    // FIX: Use translation key for consistent casing
                    label: Text("delete_company".tr),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Confirm Deletion",
                        middleText:
                            "Are you sure you want to delete this company? This action cannot be undone.",
                        // FIX: Use translation key for consistent casing
                        textConfirm: "delete_confirm".tr,
                        textCancel: "cancel".tr,
                        confirmTextColor: Colors.white,
                        buttonColor: Colors.red,
                        onConfirm: () {
                          Get.back(); // Close dialog first
                          controller.deletecompany(companyData.companyId!);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
