import 'package:flutter/material.dart';
import '../primitives/datamate_action_button.dart';
import '../tokens/theme_extensions.dart';

/// Sticky action footer anchored to the bottom edge of the viewport:
/// - Fixed height: 64px
/// - 1px solid light grey top border
/// - Secondary action buttons / utility toggles aligned to the far left (16px left padding)
/// - Primary progression action (e.g., Save Voucher) aligned to far right (16px right & bottom padding)
class DatamateStickyFooter extends StatelessWidget {
  const DatamateStickyFooter({
    super.key,
    required this.onSave,
    this.saveLabel = 'Save',
    this.isSaving = false,
    this.secondaryActions = const [],
    this.customTrailing,
  });

  /// Primary submission callback (e.g. Save Voucher).
  final VoidCallback? onSave;

  /// Label for the primary Dark Blue submission button.
  final String saveLabel;

  /// Loading state for the save button.
  final bool isSaving;

  /// Utility or navigation widgets positioned at the far left (16px padding).
  final List<Widget> secondaryActions;

  /// Optional widget displayed to the left of the Save button.
  final Widget? customTrailing;

  @override
  Widget build(BuildContext context) {
    final colors = context.datamateColors;
    final spacing = context.datamateSpacing;
    final dimensions = context.datamateDimensions;

    return Container(
      height: dimensions.footerHeight, // 64px
      padding: EdgeInsets.symmetric(horizontal: spacing.md), // 16px
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colors.borderLight,
            width: dimensions.dividerThickness, // 1px solid
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            offset: const Offset(0, -2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Far-left secondary navigation & utility buttons
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < secondaryActions.length; i++) ...[
                    if (i > 0) SizedBox(width: spacing.xs),
                    secondaryActions[i],
                  ],
                ],
              ),
            ),
          ),
          SizedBox(width: spacing.sm),

          // Far-right primary Save action
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (customTrailing != null) ...[
                customTrailing!,
                SizedBox(width: spacing.md),
              ],
              DatamatePrimaryButton(
                label: saveLabel,
                icon: Icons.check_circle_outline_rounded,
                isLoading: isSaving,
                onPressed: onSave,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
