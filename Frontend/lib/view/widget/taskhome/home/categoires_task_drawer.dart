import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/home_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/data/model/categorymodel.dart';
import 'package:tasknotate/data/datasource/local/sqldb.dart';

class CategoryDrawerTask extends StatelessWidget {
  final HomeController controller;
  final bool isTaskDrawer;

  const CategoryDrawerTask({
    super.key,
    required this.controller,
    required this.isTaskDrawer,
  });

  Future<List<String>> _fetchTaskTitles(
      BuildContext context, CategoryModel category) async {
    final SqlDb sqlDb = SqlDb();
    List<Map<String, dynamic>> tasksResponse;
    if (category.id == null) {
      // Handle "Home" category (categoryId IS NULL)
      tasksResponse = await sqlDb.readData(
        'SELECT title FROM tasks WHERE categoryId IS NULL',
      );
    } else {
      tasksResponse = await sqlDb.readData(
        'SELECT title FROM tasks WHERE categoryId = ?',
        [category.id],
      );
    }
    return tasksResponse.map((task) => task['title'] as String).toList();
  }

  Future<void> _addCategory(String name) async {
    await controller.addTaskCategory(name);
  }

  Future<void> _updateCategory(int? id, String name) async {
    if (id == null) {
      Get.snackbar('Error'.tr, 'Cannot update Home category'.tr,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    await controller.updateTaskCategory(id, name);
  }

  Future<void> _deleteCategory(int? id, RxBool isDeleting) async {
    if (id == null) {
      Get.snackbar('Error'.tr, 'Cannot delete Home category'.tr,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    await controller.deleteTaskCategory(id);
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final RxBool showAddField = false.obs;
    final RxBool isDeleting = false.obs;

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.appTheme.colorScheme.secondary,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories'.tr,
                  style: TextStyle(
                    color: context.appTheme.colorScheme.onSecondary,
                    fontSize: context.scaleConfig.scaleText(20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Obx(
                  () => IconButton(
                    icon: Icon(
                      showAddField.value ? Icons.close : Icons.add,
                      color: context.appTheme.colorScheme.onSecondary,
                    ),
                    onPressed: () {
                      showAddField.value = !showAddField.value;
                      if (!showAddField.value) {
                        nameController.clear();
                      }
                    },
                    tooltip:
                        showAddField.value ? 'Cancel'.tr : 'Add Category'.tr,
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => showAddField.value
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.scaleConfig.scale(16),
                      vertical: context.scaleConfig.scale(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: 'Category Name'.tr,
                              border: const OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: context.scaleConfig.scale(12),
                                vertical: context.scaleConfig.scale(8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: context.scaleConfig.scale(8)),
                        ElevatedButton(
                          onPressed: () async {
                            if (nameController.text.isNotEmpty) {
                              await _addCategory(nameController.text);
                              nameController.clear();
                              showAddField.value = false;
                            } else {
                              Get.snackbar(
                                'Error'.tr,
                                'Category name cannot be empty'.tr,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                context.appTheme.colorScheme.secondary,
                            foregroundColor:
                                context.appTheme.colorScheme.onSecondary,
                            padding: EdgeInsets.symmetric(
                              horizontal: context.scaleConfig.scale(16),
                              vertical: context.scaleConfig.scale(8),
                            ),
                          ),
                          child: Text('Add'.tr),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          Expanded(
            child: GetBuilder<HomeController>(
              id: 'task-category-view',
              builder: (controller) {
                // Create a copy of the categories list and add "Home" if needed
                final List<CategoryModel> categories =
                    List.from(controller.taskCategories);
                if (controller.taskdata.any((task) => task.category == null)) {
                  if (!categories.any((cat) => cat.categoryName == "Home")) {
                    categories.insert(
                        0, CategoryModel(id: null, categoryName: "Home"));
                  }
                }

                if (categories.isEmpty) {
                  return Center(child: Text('No categories'.tr));
                }

                return ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return ExpansionTile(
                      leading: Icon(
                        FontAwesomeIcons.folder,
                        color: context.appTheme.colorScheme.primary,
                        size: context.scaleConfig.scale(20),
                      ),
                      title: Text(
                        category.categoryName,
                        style: TextStyle(
                          fontSize: context.scaleConfig.scaleText(16),
                        ),
                      ),
                      onExpansionChanged: (expanded) {
                        if (!expanded) {
                          if (isTaskDrawer &&
                              controller.selectedTaskCategoryId.value ==
                                  category.id) {
                            controller.filterTasksByCategory(null);
                          }
                        }
                      },
                      children: [
                        if (isTaskDrawer)
                          FutureBuilder<List<String>>(
                            future: _fetchTaskTitles(context, category),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (snapshot.hasError) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Error: ${snapshot.error}'.tr),
                                );
                              }
                              final taskTitles = snapshot.data ?? [];
                              if (taskTitles.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.scaleConfig.scale(16),
                                  vertical: context.scaleConfig.scale(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Tasks".tr,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            context.scaleConfig.scaleText(14),
                                        color: context
                                            .appTheme.colorScheme.primary,
                                      ),
                                    ),
                                    SizedBox(
                                        height: context.scaleConfig.scale(4)),
                                    ...taskTitles.map((title) => Padding(
                                          padding: EdgeInsets.only(
                                            left: context.scaleConfig.scale(8),
                                            bottom:
                                                context.scaleConfig.scale(4),
                                          ),
                                          child: Text(
                                            "- $title",
                                            style: TextStyle(
                                              fontSize: context.scaleConfig
                                                  .scaleText(14),
                                              color: context.appTheme
                                                  .colorScheme.onSurface,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              );
                            },
                          ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.scaleConfig.scale(16),
                            vertical: context.scaleConfig.scale(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton.icon(
                                icon: Icon(
                                  Icons.edit,
                                  color: context.appTheme.colorScheme.primary,
                                  size: context.scaleConfig.scale(18),
                                ),
                                label: Text('Edit'.tr),
                                onPressed: () {
                                  _showEditCategoryDialog(context, category);
                                },
                              ),
                              Obx(
                                () => TextButton.icon(
                                  icon: isDeleting.value
                                      ? SizedBox(
                                          width: context.scaleConfig.scale(18),
                                          height: context.scaleConfig.scale(18),
                                          child: CircularProgressIndicator(
                                            strokeWidth:
                                                context.scaleConfig.scale(2),
                                            color: Colors.redAccent,
                                          ),
                                        )
                                      : Icon(
                                          Icons.delete,
                                          color: Colors.redAccent,
                                          size: context.scaleConfig.scale(18),
                                        ),
                                  label: Text('Delete'.tr),
                                  onPressed: isDeleting.value
                                      ? null
                                      : () {
                                          _confirmDeleteCategory(
                                              context, category, isDeleting);
                                        },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showEditCategoryDialog(BuildContext context, CategoryModel category) {
    final TextEditingController nameController =
        TextEditingController(text: category.categoryName);
    Get.dialog(
      AlertDialog(
        title: Text('Edit Category'.tr),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: 'Category Name'.tr,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'.tr),
          ),
          TextButton(
            onPressed: () async {
              if (nameController.text.isNotEmpty) {
                await _updateCategory(category.id, nameController.text);
                Get.back();
              } else {
                Get.snackbar(
                  'Error'.tr,
                  'Category name cannot be empty'.tr,
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            child: Text('Update'.tr),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteCategory(
      BuildContext context, CategoryModel category, RxBool isDeleting) async {
    Get.dialog(
      AlertDialog(
        title: Text('Delete Category'.tr),
        content: Text(
            'Are you sure you want to delete "${category.categoryName}"?'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'.tr),
          ),
          TextButton(
            onPressed: () async {
              isDeleting.value = true;
              await _deleteCategory(category.id, isDeleting);
              isDeleting.value = false;
              Navigator.of(context).pop();
            },
            child: Text('Delete'.tr),
          ),
        ],
      ),
    );
  }
}
