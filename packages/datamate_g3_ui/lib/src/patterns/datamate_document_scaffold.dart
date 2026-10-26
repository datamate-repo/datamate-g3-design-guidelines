import 'package:flutter/material.dart';
import '../tokens/theme_extensions.dart';

/// Top-level application scaffold for Datamate G3 document and transaction screens:
/// - Fixed 64px [header] anchored to the top
/// - Outer page margins: 24px horizontal (left/right) and 16px vertical (top/bottom)
/// - Children separated by strict 24px section gaps
/// - Fixed 64px [footer] anchored to the bottom with 1px top border
class DatamateDocumentScaffold extends StatelessWidget {
  const DatamateDocumentScaffold({
    super.key,
    required this.header,
    required this.sections,
    required this.footer,
    this.backgroundColor,
  });

  /// Top 64px navigation bar (typically [DatamateHeaderBar]).
  final PreferredSizeWidget header;

  /// Ordered document sections (e.g., [DatamateMetaSection], [DatamateDataGrid]).
  /// Will be automatically separated by exact 24px vertical section gaps.
  final List<Widget> sections;

  /// Bottom sticky 64px action bar (typically [DatamateStickyFooter]).
  final Widget footer;

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final spacing = context.datamateSpacing;

    return Scaffold(
      backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      appBar: header,
      body: Column(
        children: [
          // Scrollable canvas adhering to 24px H and 16px V page margins
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: spacing.pageMarginHorizontal, // 24px
                vertical: spacing.pageMarginVertical,     // 16px
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (int i = 0; i < sections.length; i++) ...[
                    if (i > 0) SizedBox(height: spacing.sectionGap), // 24px section gap
                    sections[i],
                  ],
                ],
              ),
            ),
          ),

          // Sticky bottom footer
          footer,
        ],
      ),
    );
  }
}
