import 'package:flutter/material.dart';
import '../tokens/theme_extensions.dart';

/// Item definition for [DatamateDropdown].
class DatamateDropdownItem<T> {
  const DatamateDropdownItem({
    required this.value,
    required this.label,
    this.icon,
  });

  final T value;
  final String label;
  final IconData? icon;
}

/// Dropdown selection field conforming to Datamate G3 specifications:
/// - Exact 40px fixed height matching [DatamateTextField]
/// - Subtle light grey fill (#ECEFF2) with rounded borders (6px radius)
/// - Optional left-aligned label separated by 8px gap
/// - Trailing chevron-down icon (#64748B)
class DatamateDropdown<T> extends StatelessWidget {
  const DatamateDropdown({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.label,
    this.labelWidth,
    this.placeholder = 'Select an option...',
    this.enabled = true,
    this.width,
  });

  /// Available options in the dropdown.
  final List<DatamateDropdownItem<T>> items;

  /// Currently selected value.
  final T? value;

  /// Callback when a new value is selected.
  final ValueChanged<T?>? onChanged;

  /// Optional label placed horizontally to the left of the dropdown field.
  final String? label;

  /// Optional fixed width for the left-hand label to allow uniform column alignment.
  final double? labelWidth;

  /// Placeholder hint shown when no item is selected.
  final String placeholder;

  /// Whether the dropdown is enabled.
  final bool enabled;

  /// Optional fixed width for the dropdown box.
  final double? width;

  @override
  Widget build(BuildContext context) {
    final colors = context.datamateColors;
    final spacing = context.datamateSpacing;
    final dimensions = context.datamateDimensions;
    final typography = context.datamateTypography;

    final dropdownWidget = SizedBox(
      height: dimensions.inputHeight, // 40px
      width: width,
      child: DropdownButtonFormField<T>(
        initialValue: value,
        onChanged: enabled ? onChanged : null,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 20,
          color: enabled ? colors.textMuted : colors.textMuted.withValues(alpha: 0.5),
        ),
        isExpanded: true,
        style: typography.body.copyWith(
          color: enabled ? colors.textPrimary : colors.textMuted,
          fontWeight: FontWeight.w500,
        ),
        dropdownColor: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(dimensions.containerRadius), // 8px menu radius
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: colors.inputFill,
          hintText: placeholder,
          hintStyle: typography.body.copyWith(
            fontSize: 13,
            color: colors.textMuted.withValues(alpha: 0.8),
            fontWeight: FontWeight.normal,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: spacing.sm, // 12px
            vertical: 10,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(dimensions.inputRadius),
            borderSide: BorderSide(color: colors.borderLight, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(dimensions.inputRadius),
            borderSide: BorderSide(color: colors.borderLight, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(dimensions.inputRadius),
            borderSide: BorderSide(color: colors.primaryDarkBlue, width: 1.5),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(dimensions.inputRadius),
            borderSide: BorderSide(
              color: colors.borderLight.withValues(alpha: 0.5),
              width: 1.0,
            ),
          ),
        ),
        items: items.map((item) {
          return DropdownMenuItem<T>(
            value: item.value,
            child: Row(
              children: [
                if (item.icon != null) ...[
                  Icon(item.icon, size: 16, color: colors.textMuted),
                  SizedBox(width: spacing.xs),
                ],
                Flexible(
                  child: Text(
                    item.label,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );

    // If no label, return field directly
    if (label == null) {
      return dropdownWidget;
    }

    // Horizontal layout with left-aligned label and 8px gap
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (labelWidth != null)
          SizedBox(
            width: labelWidth,
            child: Text(
              label!,
              style: typography.label.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        else
          Text(
            label!,
            style: typography.label.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        SizedBox(width: spacing.xs), // 8px gap
        if (width != null)
          dropdownWidget
        else
          Expanded(child: dropdownWidget),
      ],
    );
  }
}
