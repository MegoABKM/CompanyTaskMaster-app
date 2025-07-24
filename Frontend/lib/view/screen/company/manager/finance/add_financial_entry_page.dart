// lib/view/screen/company/manager/finance/add_financial_entry_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/finance/add_entry_controller.dart';
import 'package:companymanagment/core/class/handlingdataview.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_button_auth.dart';
import 'package:companymanagment/view/widget/company/manager/company/shared/build_text_filed_company.dart';

class AddFinancialEntryPage extends StatelessWidget {
  const AddFinancialEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller is initialized via Get.to() with arguments
    final AddEntryController controller = Get.put(AddEntryController());
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${'add'.tr} ${controller.entryType!.tr}'),
      ),
      body: GetBuilder<AddEntryController>(
        builder: (c) => Handlingdataview(
          statusRequest: c.statusRequest,
          widget: Form(
            key: c.formState,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                BuildTextFiledCompany(
                  controller: c.descriptionController,
                  label: 'description'.tr,
                  hint: 'enter_description'.tr,
                  icon: Icons.description_outlined,
                  validator: (val) =>
                      val!.isEmpty ? 'cannot_be_empty'.tr : null,
                ),
                const SizedBox(height: 16),
                BuildTextFiledCompany(
                  controller: c.amountController,
                  label: 'amount'.tr,
                  hint: '0.00',
                  icon: Icons.attach_money,
                  validator: (val) {
                    if (val!.isEmpty) return 'cannot_be_empty'.tr;
                    if (double.tryParse(val) == null)
                      return 'invalid_number'.tr;
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildCategoryDropdown(c, theme),
                const SizedBox(height: 16),
                TextFormField(
                  controller: c.dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'date'.tr,
                    prefixIcon: const Icon(Icons.calendar_today_outlined),
                    border: const OutlineInputBorder(),
                  ),
                  onTap: () => c.pickDate(context),
                ),
                const SizedBox(height: 24),
                CustomButtonAuth(
                  textbutton: 'submit_entry'.tr,
                  onPressed: c.submitEntry,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown(AddEntryController c, ThemeData theme) {
    List<String> categories = [];
    if (c.entryType == 'Expense') {
      categories = c.expenseCategories;
    } else if (c.entryType == 'Cost') {
      categories = c.costCategories;
    } else {
      return const SizedBox.shrink(); // No categories for Income/Revenue
    }

    return DropdownButtonFormField<String>(
      value: c.selectedCategory,
      hint: Text('select_category'.tr),
      decoration: InputDecoration(
        labelText: 'category'.tr,
        prefixIcon: const Icon(Icons.category_outlined),
        border: const OutlineInputBorder(),
      ),
      items: categories.map((String category) {
        return DropdownMenuItem<String>(
          value: category,
          child: Text(category.tr),
        );
      }).toList(),
      onChanged: (value) {
        c.selectCategory(value);
      },
    );
  }
}
