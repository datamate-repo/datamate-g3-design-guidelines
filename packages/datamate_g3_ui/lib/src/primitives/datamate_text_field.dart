import 'package:flutter/material.dart';
import '../tokens/theme_extensions.dart';

/// Form input field implementing Datamate G3 specifications:
/// - 40px fixed height
/// - Subtle light grey fill (#ECEFF2) with rounded borders (6px radius)
/// - 12px horizontal interior padding
/// - Optional left-aligned label separated by 8px gap
/// - Poppins 13.5px Medium typography
class DatamateTextField extends StatelessWidget {
  const DatamateTextField({
    super.key,
    this.label,
    this.placeholder,
    this.initialValue,
    this.controller,
    this.onChanged,
    this.readOnly = false,
    this.enabled = true,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textAlign = TextAlign.start,
    this.textStyle,
    this.width,
    this.labelWidth,
  });

  /// Optional label placed horizontally to the left of the input field.
  final String? label;

  /// Placeholder hint inside the input box.
  final String? placeholder;

  final String? initialValue;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final bool enabled;
  final bool obscureText;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextAlign textAlign;
  final TextStyle? textStyle;

  /// Optional fixed width for the input box.
  final double? width;

  /// Optional fixed width for the left-hand label to allow uniform column alignment.
  final double? labelWidth;

  @override
  Widget build(BuildContext context) {
    final colors = context.datamateColors;
    final spacing = context.datamateSpacing;
    final dimensions = context.datamateDimensions;
    final typography = context.datamateTypography;

    final defaultTextColor = enabled ? colors.textPrimary : colors.textMuted;

    final inputWidget = SizedBox(
      height: dimensions.inputHeight, // 40px
      width: width,
      child: TextFormField(
        controller: controller,
        initialValue: controller == null ? initialValue : null,
        onChanged: onChanged,
        readOnly: readOnly,
        enabled: enabled,
        obscureText: obscureText,
        textAlign: textAlign,
        keyboardType: keyboardType,
        style: textStyle ??
            typography.body.copyWith(
              color: defaultTextColor,
              fontWeight: FontWeight.w500,
            ),
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
          contentPadding: EdgeInsets.only(
            left: prefixIcon != null ? 4 : spacing.sm,
            right: suffixIcon != null ? 4 : spacing.sm,
            top: 10,
            bottom: 10,
          ),
          prefixIcon: prefixIcon,
          prefixIconConstraints: prefixIcon != null
              ? BoxConstraints(
                  minWidth: 36,
                  maxWidth: 36,
                  minHeight: dimensions.inputHeight,
                  maxHeight: dimensions.inputHeight,
                )
              : null,
          suffixIcon: suffixIcon,
          suffixIconConstraints: suffixIcon != null
              ? BoxConstraints(
                  minWidth: 36,
                  maxWidth: 36,
                  minHeight: dimensions.inputHeight,
                  maxHeight: dimensions.inputHeight,
                )
              : null,
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
      ),
    );

    // If no label, return the input directly
    if (label == null) {
      return inputWidget;
    }

    // Assemble horizontal layout: [Label] -- 8px -- [Input Field]
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
        SizedBox(width: spacing.xs), // 8px horizontal gap
        if (width != null)
          inputWidget
        else
          Expanded(child: inputWidget),
      ],
    );
  }
}
