import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:tasknotate/controller/notes/noteview_controller.dart';
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/view/widget/notehome/crudnotes/viewnote/custom_app_bar.dart';
import 'package:tasknotate/controller/home_controller.dart';

class ViewNote extends StatelessWidget {
  const ViewNote({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NoteviewController());

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(context.scaleConfig.scale(16)),
          child: GetBuilder<NoteviewController>(
            builder: (controller) {
              if (controller.note == null) {
                return Center(
                  child: Text(
                    "170".tr,
                    style: TextStyle(
                      fontSize: context.scaleConfig.scaleText(18),
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                );
              }
              return ListView(
                children: [
                  CustomAppBarView(
                    titleController: controller.insideTitleField!,
                    onBackPressed: () {
                      controller.updateData();
                      Get.offAllNamed(AppRoute.home);
                    },
                    onTitleChanged: controller.saveTitle,
                  ),

                  // Category Dropdown
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
                      child: GetBuilder<HomeController>(
                        id: 'note-category-view',
                        builder: (homeController) {
                          return DropdownButtonFormField<int?>(
                            value: controller.selectedCategoryId,
                            decoration: InputDecoration(
                              labelText: 'Category'.tr,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: context.scaleConfig.scale(12),
                                vertical: context.scaleConfig.scale(10),
                              ),
                            ),
                            items: [
                              DropdownMenuItem<int?>(
                                value: null,
                                child: Text('None'.tr),
                              ),
                              ...homeController.noteCategories.map((category) {
                                return DropdownMenuItem<int?>(
                                  value: category.id,
                                  child: Text(category.categoryName),
                                );
                              }).toList(),
                            ],
                            onChanged: (int? newValue) {
                              controller.selectedCategoryId = newValue;
                              controller.updateData();
                            },
                            isExpanded: true,
                          );
                        },
                      ),
                    ),
                  ),

                  // Note Content
                  if (!controller.isDrawingMode)
                    Hero(
                      tag: controller.note!.id ?? "",
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: context.scaleConfig.scale(8),
                          vertical: context.scaleConfig.scale(8),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.all(context.scaleConfig.scale(16)),
                          child: TextField(
                            controller: controller.insideTextField,
                            maxLines: null,
                            minLines: 5,
                            expands: false,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "167".tr,
                              hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
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
                    )
                  else if (controller.drawingBytes != null)
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: context.scaleConfig.scale(8),
                        vertical: context.scaleConfig.scale(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(
                          controller.drawingBytes!,
                          height: context.scaleConfig.scale(300),
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                  SizedBox(height: context.scaleConfig.scale(16)),

                  // Drawing Toggle Button
                  ElevatedButton.icon(
                    onPressed: () {
                      controller.toggleDrawingMode();
                      if (!controller.isDrawingMode) {
                        controller.updateData();
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
              );
            },
          ),
        ),
      ),
    );
  }
}
