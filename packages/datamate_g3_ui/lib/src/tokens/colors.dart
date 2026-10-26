import 'package:flutter/material.dart';

/// Defines the semantic and functional color tokens for the Datamate G3 design system.
@immutable
class DatamateColors extends ThemeExtension<DatamateColors> {
  const DatamateColors({
    required this.primaryDarkBlue,
    required this.surfaceVariant,
    required this.inputFill,
    required this.borderLight,
    required this.semanticRed,
    required this.semanticWarning,
    required this.semanticSuccess,
    required this.totalsBand,
    required this.textPrimary,
    required this.textMuted,
    required this.textOnPrimary,
  });

  /// Dark blue for table column headers and primary footer Save actions.
  final Color primaryDarkBlue;

  /// Subtle light grey background for the Document Meta Section.
  final Color surfaceVariant;

  /// Input background fill for form fields and inline grid cells.
  final Color inputFill;

  /// Subtle grey border for inputs, containers, and sticky footer top divider.
  final Color borderLight;

  /// Semantic red for view close button, critical auto-generated IDs, and delete row actions.
  final Color semanticRed;

  /// Semantic warning for row clear/undo actions.
  final Color semanticWarning;

  /// Semantic green for row add/check actions.
  final Color semanticSuccess;

  /// Lightly tinted green background for the bottom summary/totals band.
  final Color totalsBand;

  /// Primary high-contrast text color for titles, labels, and table entries.
  final Color textPrimary;

  /// Muted secondary text color for italicized helper labels and balance indicators.
  final Color textMuted;

  /// High-contrast text on primary dark blue backgrounds.
  final Color textOnPrimary;

  static const light = DatamateColors(
    primaryDarkBlue: Color(0xFF20389B),
    surfaceVariant: Color(0xFFF5F7FA),
    inputFill: Color(0xFFECEFF2),
    borderLight: Color(0xFFDCE1E7),
    semanticRed: Color(0xFFD32F2F),
    semanticWarning: Color(0xFFED6C02),
    semanticSuccess: Color(0xFF2E7D32),
    totalsBand: Color(0xFFE8F5E9),
    textPrimary: Color(0xFF1E293B),
    textMuted: Color(0xFF64748B),
    textOnPrimary: Color(0xFFFFFFFF),
  );

  static const dark = DatamateColors(
    primaryDarkBlue: Color(0xFF133E68),
    surfaceVariant: Color(0xFF1E2633),
    inputFill: Color(0xFF273244),
    borderLight: Color(0xFF334155),
    semanticRed: Color(0xFFEF5350),
    semanticWarning: Color(0xFFFFB74D),
    semanticSuccess: Color(0xFF66BB6A),
    totalsBand: Color(0xFF1B382B),
    textPrimary: Color(0xFFF1F5F9),
    textMuted: Color(0xFF94A3B8),
    textOnPrimary: Color(0xFFFFFFFF),
  );

  static const fallback = light;

  @override
  DatamateColors copyWith({
    Color? primaryDarkBlue,
    Color? surfaceVariant,
    Color? inputFill,
    Color? borderLight,
    Color? semanticRed,
    Color? semanticWarning,
    Color? semanticSuccess,
    Color? totalsBand,
    Color? textPrimary,
    Color? textMuted,
    Color? textOnPrimary,
  }) {
    return DatamateColors(
      primaryDarkBlue: primaryDarkBlue ?? this.primaryDarkBlue,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      inputFill: inputFill ?? this.inputFill,
      borderLight: borderLight ?? this.borderLight,
      semanticRed: semanticRed ?? this.semanticRed,
      semanticWarning: semanticWarning ?? this.semanticWarning,
      semanticSuccess: semanticSuccess ?? this.semanticSuccess,
      totalsBand: totalsBand ?? this.totalsBand,
      textPrimary: textPrimary ?? this.textPrimary,
      textMuted: textMuted ?? this.textMuted,
      textOnPrimary: textOnPrimary ?? this.textOnPrimary,
    );
  }

  @override
  DatamateColors lerp(ThemeExtension<DatamateColors>? other, double t) {
    if (other is! DatamateColors) return this;
    return DatamateColors(
      primaryDarkBlue: Color.lerp(primaryDarkBlue, other.primaryDarkBlue, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      inputFill: Color.lerp(inputFill, other.inputFill, t)!,
      borderLight: Color.lerp(borderLight, other.borderLight, t)!,
      semanticRed: Color.lerp(semanticRed, other.semanticRed, t)!,
      semanticWarning: Color.lerp(semanticWarning, other.semanticWarning, t)!,
      semanticSuccess: Color.lerp(semanticSuccess, other.semanticSuccess, t)!,
      totalsBand: Color.lerp(totalsBand, other.totalsBand, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      textOnPrimary: Color.lerp(textOnPrimary, other.textOnPrimary, t)!,
    );
  }
}
