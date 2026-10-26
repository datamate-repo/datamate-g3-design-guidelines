import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

/// Typography specification for Datamate G3 design system anchored on the **Poppins** font family.
@immutable
class DatamateTypography extends ThemeExtension<DatamateTypography> {
  const DatamateTypography({
    required this.display,
    required this.h1,
    required this.h2,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.label,
    required this.caption,
    required this.helperItalic,
  });

  static const String fontFamilyName = 'Poppins';
  static const List<String> fontFallbacks = ['Helvetica Neue', 'Arial', 'sans-serif'];

  /// 28px Bold: Hero and splash titles
  final TextStyle display;

  /// 22px Bold: Primary page titles (Header Bar)
  final TextStyle h1;

  /// 18px Bold: Section headers (Meta Section, Data Grid titles)
  final TextStyle h2;

  /// 15px Semi-Bold: Card titles, modal titles
  final TextStyle title;

  /// 14px Medium: Subheadings and context labels
  final TextStyle subtitle;

  /// 13.5px Regular/Medium: Standard table cell data, body text, form input text
  final TextStyle body;

  /// 13px Semi-Bold: Left-aligned input field labels, button labels
  final TextStyle label;

  /// 12px Regular: Context badges, table headers, breadcrumbs
  final TextStyle caption;

  /// 11.5px Italic: Sub-input balance indicators, auto-generation notices
  final TextStyle helperItalic;

  static TextStyle _style({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? letterSpacing,
    double? height,
    FontStyle? fontStyle,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      fontStyle: fontStyle,
    );
  }

  /// Generates the standard Poppins typography specification for light themes.
  factory DatamateTypography.light({required DatamateColors colors}) {
    return DatamateTypography(
      display: _style(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: colors.primaryDarkBlue,
        letterSpacing: -0.5,
      ),
      h1: _style(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: colors.primaryDarkBlue,
        letterSpacing: -0.3,
      ),
      h2: _style(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: colors.primaryDarkBlue,
        letterSpacing: -0.2,
      ),
      title: _style(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
        letterSpacing: 0.1,
      ),
      subtitle: _style(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: colors.textMuted,
      ),
      body: _style(
        fontSize: 13.5,
        fontWeight: FontWeight.w500,
        color: colors.textPrimary,
        height: 1.4,
      ),
      label: _style(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
        letterSpacing: 0.2,
      ),
      caption: _style(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: colors.textMuted,
      ),
      helperItalic: _style(
        fontSize: 11.5,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        color: colors.textMuted,
      ),
    );
  }

  /// Generates the standard Poppins typography specification for dark themes.
  factory DatamateTypography.dark({required DatamateColors colors}) {
    return DatamateTypography(
      display: _style(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
        letterSpacing: -0.5,
      ),
      h1: _style(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
        letterSpacing: -0.3,
      ),
      h2: _style(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
        letterSpacing: -0.2,
      ),
      title: _style(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
        letterSpacing: 0.1,
      ),
      subtitle: _style(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: colors.textMuted,
      ),
      body: _style(
        fontSize: 13.5,
        fontWeight: FontWeight.w500,
        color: colors.textPrimary,
        height: 1.4,
      ),
      label: _style(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
        letterSpacing: 0.2,
      ),
      caption: _style(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: colors.textMuted,
      ),
      helperItalic: _style(
        fontSize: 11.5,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        color: colors.textMuted,
      ),
    );
  }

  static final fallback = DatamateTypography.light(colors: DatamateColors.light);

  /// Builds a Flutter [TextTheme] styled in Poppins.
  TextTheme toTextTheme() {
    return TextTheme(
      headlineLarge: display,
      headlineMedium: h1,
      titleLarge: h2,
      titleMedium: title,
      titleSmall: subtitle,
      bodyMedium: body,
      labelLarge: label,
      bodySmall: caption,
    );
  }

  @override
  DatamateTypography copyWith({
    TextStyle? display,
    TextStyle? h1,
    TextStyle? h2,
    TextStyle? title,
    TextStyle? subtitle,
    TextStyle? body,
    TextStyle? label,
    TextStyle? caption,
    TextStyle? helperItalic,
  }) {
    return DatamateTypography(
      display: display ?? this.display,
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      body: body ?? this.body,
      label: label ?? this.label,
      caption: caption ?? this.caption,
      helperItalic: helperItalic ?? this.helperItalic,
    );
  }

  @override
  DatamateTypography lerp(ThemeExtension<DatamateTypography>? other, double t) {
    if (other is! DatamateTypography) return this;
    return DatamateTypography(
      display: TextStyle.lerp(display, other.display, t)!,
      h1: TextStyle.lerp(h1, other.h1, t)!,
      h2: TextStyle.lerp(h2, other.h2, t)!,
      title: TextStyle.lerp(title, other.title, t)!,
      subtitle: TextStyle.lerp(subtitle, other.subtitle, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      label: TextStyle.lerp(label, other.label, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
      helperItalic: TextStyle.lerp(helperItalic, other.helperItalic, t)!,
    );
  }
}
