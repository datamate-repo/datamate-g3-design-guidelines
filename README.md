# Datamate G3 Design System

This repository has three parts:

1. **The Design Rulebook** — A plain-language guide on how every Datamate G3 screen should look and behave.
2. **The Widget Library** — Ready-to-use Flutter components that follow the rulebook automatically.
3. **The Live Catalog** — A web app where developers can browse, interact with, and copy every reusable component.

---

## 📖 The Design Rulebook

Read the full specification: [`docs/guidelines/layout_and_component_system.md`](docs/guidelines/layout_and_component_system.md)

It covers:
- How to structure a Master Creation page (header → meta section → data grid → footer)
- Exact dimensions for every element (64px header, 40px inputs, 48px grid rows)
- Where buttons go (Save on the far right, secondary on the far left)
- Which colors to use and when (dark blue for primary, red for destructive, green for additive)
- The Poppins typography scale from 28px display down to 11.5px helper text
- A checklist you can follow when building any new screen

Machine-readable token files live in [`tokens/`](tokens/) if you need exact values programmatically.

---

## 🧩 The Widget Library (`packages/datamate_g3_ui`)

A standalone Flutter package. Import it and all the rulebook's spacing, colors, typography, and components are available out of the box.

```dart
// In your pubspec.yaml
dependencies:
  datamate_g3_ui:
    path: packages/datamate_g3_ui
```

```dart
// In your app
import 'package:datamate_g3_ui/datamate_g3_ui.dart';

// Wrap your app with the Datamate theme
MaterialApp(
  theme: DatamateTheme.light(),
  darkTheme: DatamateTheme.dark(),
);

// Access design tokens anywhere
final spacing = context.datamateSpacing;
final colors = context.datamateColors;
final typography = context.datamateTypography;
```

**Available components:**
- `DatamateTextField` — Standard 40px input with left labels and helper text
- `DatamatePrimaryButton` — Dark blue save/submit button
- `DatamateExitButton` — Red close/exit button
- `DatamateRowActionButton` — Colored row action icons (add/clear/delete)
- `DatamateHeaderBar` — 64px top bar with title, badges, and close
- `DatamateMetaSection` — Light grey form container
- `DatamateDataGrid` — Transaction grid with dark blue header and green totals
- `DatamateStickyFooter` — Bottom action bar with save and secondary actions
- `DatamateDocumentScaffold` — Assembles a complete master creation page

---

## 🌐 The Live Catalog (`apps/catalog`)

An interactive Flutter Web app where you can:
- **Browse reusable components** — text fields, buttons, dropdowns, grids
- **See a full reference screen** — a Journal Voucher Entry built entirely from the component library
- **Switch themes** — toggle between light and dark mode
- **Test responsive layouts** — simulate different screen widths

To run it locally:
```bash
cd apps/catalog
flutter run -d chrome
```
