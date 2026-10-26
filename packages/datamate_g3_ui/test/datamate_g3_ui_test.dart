import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:datamate_g3_ui/datamate_g3_ui.dart';

void main() {
  group('Datamate G3 Design Tokens', () {
    test('Spacing adheres strictly to 8px baseline grid', () {
      const spacing = DatamateSpacing.fallback;
      expect(spacing.xxs, 4.0);
      expect(spacing.xs, 8.0);
      expect(spacing.sm, 12.0);
      expect(spacing.md, 16.0);
      expect(spacing.lg, 24.0);
      expect(spacing.xl, 32.0);
      expect(spacing.xxl, 64.0);
      expect(spacing.pageMarginHorizontal, 24.0);
      expect(spacing.pageMarginVertical, 16.0);
      expect(spacing.sectionGap, 24.0);
      expect(spacing.componentGap, 16.0);
    });

    test('Colors provide valid semantic definitions', () {
      const colors = DatamateColors.light;
      expect(colors.primaryDarkBlue, const Color(0xFF20389B));
      expect(colors.semanticRed, const Color(0xFFD32F2F));
      expect(colors.semanticSuccess, const Color(0xFF2E7D32));
      expect(colors.totalsBand, const Color(0xFFE8F5E9));
    });

    test('Dimensions conform to layout specification', () {
      const dimensions = DatamateDimensions.fallback;
      expect(dimensions.headerHeight, 64.0);
      expect(dimensions.footerHeight, 64.0);
      expect(dimensions.inputHeight, 40.0);
      expect(dimensions.gridHeaderHeight, 40.0);
      expect(dimensions.gridRowMinHeight, 48.0);
    });

    testWidgets('Typography defines Poppins font hierarchy', (tester) async {
      expect(DatamateTypography.fontFamilyName, 'Poppins');
      final typography = DatamateTypography.fallback;
      expect(typography.display.fontSize, 28.0);
      expect(typography.h1.fontSize, 22.0);
      expect(typography.h2.fontSize, 18.0);
      expect(typography.title.fontSize, 15.0);
      expect(typography.subtitle.fontSize, 14.0);
      expect(typography.body.fontSize, 13.5);
      expect(typography.label.fontSize, 13.0);
      expect(typography.caption.fontSize, 12.0);
      expect(typography.helperItalic.fontSize, 11.5);
      expect(typography.helperItalic.fontStyle, FontStyle.italic);
    });
  });

  group('Datamate UI Primitives & Patterns Widget Tests', () {
    testWidgets('DatamateHeaderBar renders title, context, and close button', (tester) async {
      bool closed = false;
      await tester.pumpWidget(
        MaterialApp(
          theme: DatamateTheme.light(),
          home: Scaffold(
            appBar: DatamateHeaderBar(
              title: 'Journal Voucher Entry',
              contextBadges: const [Text('FY: 2026-27')],
              onClose: () => closed = true,
            ),
          ),
        ),
      );

      expect(find.text('Journal Voucher Entry'), findsOneWidget);
      expect(find.text('FY: 2026-27'), findsOneWidget);
      expect(find.text('Close'), findsOneWidget);

      await tester.tap(find.text('Close'));
      expect(closed, isTrue);
    });

    testWidgets('DatamateTextField renders with 40px height and label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: DatamateTheme.light(),
          home: const Scaffold(
            body: DatamateTextField(
              label: 'Full Name:',
              initialValue: 'Alex Morgan',
            ),
          ),
        ),
      );

      expect(find.text('Full Name:'), findsOneWidget);
      expect(find.text('Alex Morgan'), findsOneWidget);
    });

    testWidgets('DatamateTextField maintains strictly 40px height with and without icons', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: DatamateTheme.light(),
          home: const Scaffold(
            body: Column(
              children: [
                DatamateTextField(
                  key: Key('plain'),
                  placeholder: 'No icons',
                  width: 300,
                ),
                DatamateTextField(
                  key: Key('prefix'),
                  placeholder: 'With prefix',
                  prefixIcon: Icon(Icons.mail_outline, size: 18),
                  width: 300,
                ),
                DatamateTextField(
                  key: Key('suffix'),
                  placeholder: 'With suffix',
                  suffixIcon: Icon(Icons.calendar_today, size: 16),
                  width: 300,
                ),
                DatamateTextField(
                  key: Key('both'),
                  placeholder: 'With both icons',
                  prefixIcon: Icon(Icons.mail_outline, size: 18),
                  suffixIcon: Icon(Icons.check, size: 16),
                  width: 300,
                ),
              ],
            ),
          ),
        ),
      );

      final plainSize = tester.getSize(find.byKey(const Key('plain')));
      final prefixSize = tester.getSize(find.byKey(const Key('prefix')));
      final suffixSize = tester.getSize(find.byKey(const Key('suffix')));
      final bothSize = tester.getSize(find.byKey(const Key('both')));

      expect(plainSize.height, 40.0);
      expect(prefixSize.height, 40.0);
      expect(suffixSize.height, 40.0);
      expect(bothSize.height, 40.0);
    });

    testWidgets('DatamateSearchableDropdown opens overlay on tap without assertion errors', (tester) async {
      String? selected;
      await tester.pumpWidget(
        MaterialApp(
          theme: DatamateTheme.light(),
          home: Scaffold(
            body: DatamateSearchableDropdown<String>(
              hint: 'Select country',
              items: const ['Canada', 'Germany', 'Japan', 'United States'],
              itemBuilder: (c) => Text(c),
              titleBuilder: (c) => c,
              searchStringBuilder: (c) => c,
              onChanged: (val) => selected = val,
            ),
          ),
        ),
      );

      expect(find.text('Select country'), findsOneWidget);
      await tester.tap(find.text('Select country'));
      await tester.pumpAndSettle();

      expect(find.text('Canada'), findsOneWidget);
      expect(find.text('Germany'), findsOneWidget);

      await tester.tap(find.text('Germany'));
      await tester.pumpAndSettle();

      expect(selected, 'Germany');
    });

    testWidgets('DatamateAsyncSearchableDropdown opens overlay and renders items', (tester) async {
      String? selected;
      await tester.pumpWidget(
        MaterialApp(
          theme: DatamateTheme.light(),
          home: Scaffold(
            body: DatamateAsyncSearchableDropdown<String>(
              hint: 'Select customer',
              items: const ['Acme Corp', 'Apex Systems'],
              itemBuilder: (c) => Text(c),
              titleBuilder: (c) => c,
              onSearch: (_) {},
              onChanged: (val) => selected = val,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Select customer'));
      await tester.pumpAndSettle();

      expect(find.text('Acme Corp'), findsOneWidget);
      await tester.tap(find.text('Acme Corp'));
      await tester.pumpAndSettle();

      expect(selected, 'Acme Corp');
    });
  });
}
