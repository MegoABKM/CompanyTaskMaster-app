import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:tasknotate/controller/notes/notecreate_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/view/widget/notehome/crudnotes/createnote/custom_app_bar.dart';
import 'package:tasknotate/controller/home_controller.dart';

class CreateNoteView extends StatelessWidget {
  const CreateNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotecreateController());

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(context.scaleConfig.scale(16)),
          child: GetBuilder<NotecreateController>(
            builder: (controller) => ListView(
              children: [
                CustomAppBar(
                  onTitleChanged: controller.saveTitle,
                ),
                SizedBox(height: context.scaleConfig.scale(16)),

                // Category Selection Card
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: context.scaleConfig.scale(8),
                    vertical: context.scaleConfig.scale(8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(context.scaleConfig.scale(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Category".tr,
                          style: TextStyle(
                            fontSize: context.scaleConfig.scaleText(16),
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        SizedBox(height: context.scaleConfig.scale(8)),
                        GetBuilder<HomeController>(
                          id: 'note-category-view',
                          builder: (homeController) {
                            final categories = [
                              DropdownMenuItem<int?>(
                                value: null,
                                child: Text("None".tr),
                              ),
                              ...homeController.noteCategories.map((category) {
                                return DropdownMenuItem<int?>(
                                  value: category.id,
                                  child: Text(category.categoryName),
                                );
                              }).toList(),
                            ];

                            return DropdownButtonFormField<int?>(
                              value: controller.selectedCategoryId,
                              items: categories,
                              onChanged: (int? newValue) {
                                controller.selectedCategoryId = newValue;
                                controller.updateNoteCategory();
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: context.scaleConfig.scale(12),
                                  vertical: context.scaleConfig.scale(10),
                                ),
                              ),
                              isExpanded: true,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Note Content Field
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: context.scaleConfig.scale(8),
                    vertical: context.scaleConfig.scale(8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(context.scaleConfig.scale(16)),
                    child: TextField(
                      controller: controller.insideTextField,
                      maxLines: null,
                      minLines: 5,
                      expands: false,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        hintText: "167".tr,
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: context.scaleConfig.scaleText(16),
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      onChanged: controller.saveContent,
                    ),
                  ),
                ),

                // Drawing Area
                if (controller.isDrawingMode)
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: context.scaleConfig.scale(8),
                      vertical: context.scaleConfig.scale(8),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Signature(
                        controller: controller.signatureController,
                        height: context.scaleConfig.scale(300),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),

                SizedBox(height: context.scaleConfig.scale(16)),

                // Drawing Toggle Button
                ElevatedButton.icon(
                  onPressed: () {
                    controller.toggleDrawingMode();
                    if (!controller.isDrawingMode) {
                      controller.uploadData();
                    }
                  },
                  icon: Icon(
                    controller.isDrawingMode ? Icons.check : Icons.edit,
                    size: context.scaleConfig.scale(20),
                  ),
                  label: Text(
                    controller.isDrawingMode ? "168".tr : "169".tr,
                    style: TextStyle(
                      fontSize: context.scaleConfig.scaleText(16),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: EdgeInsets.symmetric(
                      horizontal: context.scaleConfig.scale(20),
                      vertical: context.scaleConfig.scale(12),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                ),

                SizedBox(height: context.scaleConfig.scale(40)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
