import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/home_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/data/model/usernotesmodel.dart';

class CardContentNote extends GetView<HomeController> {
  final UserNotesModel note;

  const CardContentNote(this.note, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () => Get.defaultDialog(
        title: "Caution",
        middleText: "Delete This Note?",
        textConfirm: "Confirm",
        textCancel: "Cancel",
        onCancel: () {
          return;
        },
        onConfirm: () async {
          await controller.deleteDataNote(note.id!);
          Navigator.of(context).pop();
        },
      ),
      onTap: () {
        controller.goToViewNote(note.content ?? "", note.title ?? "",
            note.id ?? "", note.drawing ?? "", note.categoryId ?? "Home");
      },
      child: Hero(
        tag: note.id ?? "",
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: context.scaleConfig.scale(8),
            horizontal: context.scaleConfig.scale(8),
          ),
          width: context.scaleConfig.scale(180),
          child: Card(
            color: Theme.of(context).colorScheme.surface,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.scaleConfig.scale(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: Text(
                      note.content ?? "",
                      maxLines: 9,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: context.scaleConfig.scaleText(14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
