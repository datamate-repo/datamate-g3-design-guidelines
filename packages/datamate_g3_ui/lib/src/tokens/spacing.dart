import 'package:flutter/material.dart';

/// Defines the rigid 8px baseline grid and spacing geometry for the Datamate G3 design system.
@immutable
class DatamateSpacing extends ThemeExtension<DatamateSpacing> {
  const DatamateSpacing({
    this.xxs = 4.0,
    this.xs = 8.0,
    this.sm = 12.0,
    this.md = 16.0,
    this.lg = 24.0,
    this.xl = 32.0,
    this.xxl = 64.0,
    this.pageMarginHorizontal = 24.0,
    this.pageMarginVertical = 16.0,
    this.sectionGap = 24.0,
    this.componentGap = 16.0,
  });

  /// 4px: Helper text offset, micro separators.
  final double xxs;

  /// 8px: Label to input gap, row action button spacing.
  final double xs;

  /// 12px: Form input and grid cell horizontal interior padding.
  final double sm;

  /// 16px: Component gap, vertical page margin, meta container padding.
  final double md;

  /// 24px: Section gap, horizontal page margin.
  final double lg;

  /// 32px: Extended layout gutters and multi-pane dividers.
  final double xl;

  /// 64px: Height of header bar and sticky action footer.
  final double xxl;

  /// 24px: Left and right outer margin for document screens.
  final double pageMarginHorizontal;

  /// 16px: Top and bottom outer margin for document screens.
  final double pageMarginVertical;

  /// 24px: Explicit vertical gap between distinct screen sections.
  final double sectionGap;

  /// 16px: Horizontal and vertical gap between adjacent form elements.
  final double componentGap;

  static const fallback = DatamateSpacing();

  @override
  DatamateSpacing copyWith({
    double? xxs,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    double? pageMarginHorizontal,
    double? pageMarginVertical,
    double? sectionGap,
    double? componentGap,
  }) {
    return DatamateSpacing(
      xxs: xxs ?? this.xxs,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      pageMarginHorizontal: pageMarginHorizontal ?? this.pageMarginHorizontal,
      pageMarginVertical: pageMarginVertical ?? this.pageMarginVertical,
      sectionGap: sectionGap ?? this.sectionGap,
      componentGap: componentGap ?? this.componentGap,
    );
  }

  @override
  DatamateSpacing lerp(ThemeExtension<DatamateSpacing>? other, double t) {
    if (other is! DatamateSpacing) return this;
    return DatamateSpacing(
      xxs: _lerpDouble(xxs, other.xxs, t),
      xs: _lerpDouble(xs, other.xs, t),
      sm: _lerpDouble(sm, other.sm, t),
      md: _lerpDouble(md, other.md, t),
      lg: _lerpDouble(lg, other.lg, t),
      xl: _lerpDouble(xl, other.xl, t),
      xxl: _lerpDouble(xxl, other.xxl, t),
      pageMarginHorizontal: _lerpDouble(pageMarginHorizontal, other.pageMarginHorizontal, t),
      pageMarginVertical: _lerpDouble(pageMarginVertical, other.pageMarginVertical, t),
      sectionGap: _lerpDouble(sectionGap, other.sectionGap, t),
      componentGap: _lerpDouble(componentGap, other.componentGap, t),
    );
  }

  static double _lerpDouble(double a, double b, double t) => a + (b - a) * t;
}
