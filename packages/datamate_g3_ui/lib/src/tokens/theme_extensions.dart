import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';
import 'dimensions.dart';
import 'spacing.dart';
import 'typography.dart';

/// Extension methods on [BuildContext] providing safe, non-nullable access
/// to Datamate G3 design tokens with built-in fallbacks.
extension DatamateThemeContext on BuildContext {
  /// Access active spacing metrics according to the 8px baseline grid.
  DatamateSpacing get datamateSpacing =>
      Theme.of(this).extension<DatamateSpacing>() ?? DatamateSpacing.fallback;

  /// Access active semantic and brand colors.
  DatamateColors get datamateColors =>
      Theme.of(this).extension<DatamateColors>() ?? DatamateColors.fallback;

  /// Access fixed component dimensions and border radii.
  DatamateDimensions get datamateDimensions =>
      Theme.of(this).extension<DatamateDimensions>() ?? DatamateDimensions.fallback;

  /// Access typography scale based on Poppins font family.
  DatamateTypography get datamateTypography =>
      Theme.of(this).extension<DatamateTypography>() ?? DatamateTypography.fallback;
}

/// Factory utility to construct a standard [ThemeData] pre-configured with
/// Datamate G3 ThemeExtensions and Poppins enterprise typography.
class DatamateTheme {
  DatamateTheme._();

  static ThemeData light({
    DatamateColors colors = DatamateColors.light,
    DatamateSpacing spacing = DatamateSpacing.fallback,
    DatamateDimensions dimensions = DatamateDimensions.fallback,
    DatamateTypography? typography,
  }) {
    final effectiveTypography = typography ?? DatamateTypography.light(colors: colors);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: GoogleFonts.poppins().fontFamily,
      textTheme: GoogleFonts.poppinsTextTheme(effectiveTypography.toTextTheme()),
      scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      primaryColor: colors.primaryDarkBlue,
      colorScheme: ColorScheme.light(
        primary: colors.primaryDarkBlue,
        surface: Colors.white,
        error: colors.semanticRed,
        outline: colors.borderLight,
      ),
      extensions: [
        colors,
        spacing,
        dimensions,
        effectiveTypography,
      ],
    );
  }

  static ThemeData dark({
    DatamateColors colors = DatamateColors.dark,
    DatamateSpacing spacing = DatamateSpacing.fallback,
    DatamateDimensions dimensions = DatamateDimensions.fallback,
    DatamateTypography? typography,
  }) {
    final effectiveTypography = typography ?? DatamateTypography.dark(colors: colors);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: GoogleFonts.poppins().fontFamily,
      textTheme: GoogleFonts.poppinsTextTheme(effectiveTypography.toTextTheme()),
      scaffoldBackgroundColor: const Color(0xFF0F172A),
      primaryColor: colors.primaryDarkBlue,
      colorScheme: ColorScheme.dark(
        primary: colors.primaryDarkBlue,
        surface: const Color(0xFF1E293B),
        error: colors.semanticRed,
        outline: colors.borderLight,
      ),
      extensions: [
        colors,
        spacing,
        dimensions,
        effectiveTypography,
      ],
    );
  }
}
