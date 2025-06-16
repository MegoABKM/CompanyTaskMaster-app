import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/home_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';
import 'package:tasknotate/data/model/categorymodel.dart';

class CategoryDropdown extends StatelessWidget {
  final HomeController controller;
  final ScaleConfig scale;

  const CategoryDropdown({
    super.key,
    required this.controller,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'task-category-view',
      builder: (controller) {
        // Ensure the selected category is valid
        String selectedCategory = 'Home';
        if (controller.selectedTaskCategoryId.value != null) {
          final category = controller.taskCategories.firstWhere(
            (category) =>
                category.id == controller.selectedTaskCategoryId.value,
            orElse: () => CategoryModel(id: null, categoryName: "Home"),
          );
          selectedCategory = category.categoryName;
        }

        return Container(
          constraints: const BoxConstraints(
            maxWidth: 100, // Smaller static width
          ),
          padding: const EdgeInsets.symmetric(horizontal: 6), // Static padding
          decoration: BoxDecoration(
            color: context.appTheme.colorScheme.secondary,
            borderRadius: BorderRadius.circular(6), // Static radius
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedCategory,
              icon: const Icon(
                FontAwesomeIcons.filter,
                color: Colors.white, // Assuming onSecondary is white
                size: 14, // Smaller static icon size
              ),
              style: const TextStyle(
                color: Colors.white, // Assuming onSecondary is white
                fontSize: 12, // Smaller static font size
              ),
              dropdownColor: context.appTheme.colorScheme.secondary,
              isExpanded: true,
              items: [
                DropdownMenuItem(
                  value: 'Home',
                  child: Text(
                    'Home'.tr,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ...controller.taskCategories.map((category) => DropdownMenuItem(
                      value: category.categoryName,
                      child: Text(
                        category.categoryName,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
              ],
              onChanged: (value) {
                if (value == 'Home') {
                  controller.filterTasksByCategory(null);
                } else {
                  final category = controller.taskCategories
                      .firstWhere((c) => c.categoryName == value);
                  controller.filterTasksByCategory(category.id);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
