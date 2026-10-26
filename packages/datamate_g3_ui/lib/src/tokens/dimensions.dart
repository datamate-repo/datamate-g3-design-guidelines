import 'package:flutter/material.dart';

/// Defines fixed component heights, paddings, and radii according to Datamate G3 standards.
@immutable
class DatamateDimensions extends ThemeExtension<DatamateDimensions> {
  const DatamateDimensions({
    this.headerHeight = 64.0,
    this.footerHeight = 64.0,
    this.inputHeight = 40.0,
    this.gridHeaderHeight = 40.0,
    this.gridRowMinHeight = 48.0,
    this.inputRadius = 6.0,
    this.containerRadius = 8.0,
    this.dividerThickness = 1.0,
  });

  /// 64px: Height of top header bar.
  final double headerHeight;

  /// 64px: Height of bottom sticky footer.
  final double footerHeight;

  /// 40px: Standard height for form and inline grid inputs.
  final double inputHeight;

  /// 40px: Fixed height of data table header rows.
  final double gridHeaderHeight;

  /// 48px: Minimum height for standard data table rows.
  final double gridRowMinHeight;

  /// 4px to 8px (default 6px): Border radius for inputs.
  final double inputRadius;

  /// 8px: Border radius for Meta Section containers.
  final double containerRadius;

  /// 1px: Standard hairline stroke for footer divider and container borders.
  final double dividerThickness;

  static const fallback = DatamateDimensions();

  @override
  DatamateDimensions copyWith({
    double? headerHeight,
    double? footerHeight,
    double? inputHeight,
    double? gridHeaderHeight,
    double? gridRowMinHeight,
    double? inputRadius,
    double? containerRadius,
    double? dividerThickness,
  }) {
    return DatamateDimensions(
      headerHeight: headerHeight ?? this.headerHeight,
      footerHeight: footerHeight ?? this.footerHeight,
      inputHeight: inputHeight ?? this.inputHeight,
      gridHeaderHeight: gridHeaderHeight ?? this.gridHeaderHeight,
      gridRowMinHeight: gridRowMinHeight ?? this.gridRowMinHeight,
      inputRadius: inputRadius ?? this.inputRadius,
      containerRadius: containerRadius ?? this.containerRadius,
      dividerThickness: dividerThickness ?? this.dividerThickness,
    );
  }

  @override
  DatamateDimensions lerp(ThemeExtension<DatamateDimensions>? other, double t) {
    if (other is! DatamateDimensions) return this;
    return DatamateDimensions(
      headerHeight: _lerp(headerHeight, other.headerHeight, t),
      footerHeight: _lerp(footerHeight, other.footerHeight, t),
      inputHeight: _lerp(inputHeight, other.inputHeight, t),
      gridHeaderHeight: _lerp(gridHeaderHeight, other.gridHeaderHeight, t),
      gridRowMinHeight: _lerp(gridRowMinHeight, other.gridRowMinHeight, t),
      inputRadius: _lerp(inputRadius, other.inputRadius, t),
      containerRadius: _lerp(containerRadius, other.containerRadius, t),
      dividerThickness: _lerp(dividerThickness, other.dividerThickness, t),
    );
  }

  static double _lerp(double a, double b, double t) => a + (b - a) * t;
}
