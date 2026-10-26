import 'package:flutter/material.dart';
import '../tokens/theme_extensions.dart';

/// Semantic role for row-level action triggers in data grids.
enum DatamateRowActionType {
  delete,
  clear,
  add,
}

/// Primary button styled with Primary Dark Blue background and white text.
/// Used for primary workflow progression (e.g., Save Voucher in sticky footer).
class DatamatePrimaryButton extends StatelessWidget {
  const DatamatePrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colors = context.datamateColors;
    final dimensions = context.datamateDimensions;
    final spacing = context.datamateSpacing;

    return SizedBox(
      height: 40.0,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primaryDarkBlue,
          foregroundColor: colors.textOnPrimary,
          disabledBackgroundColor: colors.primaryDarkBlue.withValues(alpha: 0.6),
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: spacing.md),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(dimensions.inputRadius),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 16),
                    SizedBox(width: spacing.xs),
                  ],
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Exit / Close button styled with Semantic Red background.
/// Anchored to the far right of the top Header Bar.
class DatamateExitButton extends StatelessWidget {
  const DatamateExitButton({
    super.key,
    required this.onPressed,
    this.label = 'Close',
  });

  final VoidCallback? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.datamateColors;
    final dimensions = context.datamateDimensions;
    final spacing = context.datamateSpacing;

    return SizedBox(
      height: 36.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.semanticRed,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: spacing.sm),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(dimensions.inputRadius),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.close, size: 16),
            SizedBox(width: spacing.xxs),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Row-level action icon button for Data Grids:
/// - [DatamateRowActionType.delete]: Semantic Red trash icon
/// - [DatamateRowActionType.clear]: Warning Yellow/Orange cancel/undo icon
/// - [DatamateRowActionType.add]: Success Green add/check icon
class DatamateRowActionButton extends StatelessWidget {
  final DatamateRowActionType type;
  final VoidCallback? onPressed;
  final String? tooltip;
  final double size;

  const DatamateRowActionButton({
    super.key,
    required this.type,
    required this.onPressed,
    this.tooltip,
    this.size = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.datamateColors;

    Color color;
    IconData icon;
    String defaultTooltip;

    switch (type) {
      case DatamateRowActionType.delete:
        color = colors.semanticRed;
        icon = Icons.delete_outline_rounded;
        defaultTooltip = 'Delete';
        break;
      case DatamateRowActionType.clear:
        color = colors.semanticWarning;
        icon = Icons.refresh_rounded;
        defaultTooltip = 'Clear';
        break;
      case DatamateRowActionType.add:
        color = colors.semanticSuccess;
        icon = Icons.add_circle_outline_rounded;
        defaultTooltip = 'Add';
        break;
    }

    return IconButton(
      icon: Icon(icon, color: color, size: size),
      tooltip: tooltip ?? defaultTooltip,
      onPressed: onPressed,
      splashRadius: 18,
      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
      padding: EdgeInsets.zero,
    );
  }
}

/// Secondary action button with outlined styling.
/// Used for non-primary actions (e.g. List, Print, Export) in footers or toolbars.
class DatamateSecondaryButton extends StatelessWidget {
  const DatamateSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.datamateColors;
    final dimensions = context.datamateDimensions;
    final spacing = context.datamateSpacing;

    return SizedBox(
      height: 40.0,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.primaryDarkBlue,
          side: BorderSide(color: colors.borderLight, width: 1.0),
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: spacing.md),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(dimensions.inputRadius),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16),
              SizedBox(width: spacing.xs),
            ],
            Text(
              label,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

