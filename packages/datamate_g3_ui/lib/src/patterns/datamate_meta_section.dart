import 'package:flutter/material.dart';
import '../tokens/theme_extensions.dart';

/// Document Meta Section container:
/// - Distinct Surface Variant (subtle light grey) background
/// - Strict 16px internal padding on all sides
/// - Subtle 1px border stroke and 8px border radius
/// - Houses master attributes, document headers, and entry parameters.
class DatamateMetaSection extends StatelessWidget {
  const DatamateMetaSection({
    super.key,
    required this.child,
    this.title,
    this.trailing,
  });

  final Widget child;
  final String? title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colors = context.datamateColors;
    final spacing = context.datamateSpacing;
    final dimensions = context.datamateDimensions;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spacing.md), // 16px internal padding
      decoration: BoxDecoration(
        color: colors.surfaceVariant,
        borderRadius: BorderRadius.circular(dimensions.containerRadius), // 8px
        border: Border.all(
          color: colors.borderLight,
          width: dimensions.dividerThickness,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null || trailing != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: colors.primaryDarkBlue,
                      letterSpacing: 0.2,
                    ),
                  ),
                ?trailing,
              ],
            ),
            SizedBox(height: spacing.sm),
          ],
          child,
        ],
      ),
    );
  }
}
