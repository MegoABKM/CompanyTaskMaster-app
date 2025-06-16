import 'package:flutter/material.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';

/// Class for building task title row
class TaskTitleRow {
  static Widget build(
    BuildContext context,
    String taskIndex,
    String title,
    ScaleConfig scale,
  ) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(
          "$taskIndex -",
          style: theme.textTheme.titleLarge
              ?.copyWith(color: theme.colorScheme.onSurface),
        ),
        SizedBox(width: scale.scale(5)),
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.titleLarge
                ?.copyWith(color: theme.colorScheme.onSurface),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
