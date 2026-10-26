import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catalog/main.dart';

void main() {
  testWidgets('Catalog app boots and displays navigation modules', (tester) async {
    // Set standard desktop screen resolution
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const DatamateCatalogApp());
    await tester.pumpAndSettle();

    expect(find.text('Datamate G3'), findsOneWidget);
    expect(find.text('Component Catalog'), findsOneWidget);
    expect(find.text('Text Fields'), findsWidgets);
    expect(find.text('Buttons & Actions'), findsOneWidget);
    expect(find.text('Dropdowns'), findsOneWidget);

    // Switch to Dropdowns tab
    await tester.tap(find.text('Dropdowns'));
    await tester.pumpAndSettle();

    expect(find.text('Dropdowns & Selection Fields'), findsOneWidget);
    expect(find.text('docs/guidelines/dropdowns.md'), findsOneWidget);
  });
}
