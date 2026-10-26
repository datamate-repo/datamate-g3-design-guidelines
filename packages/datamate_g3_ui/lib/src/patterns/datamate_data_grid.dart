import 'package:flutter/material.dart';
import '../tokens/theme_extensions.dart';

/// Column specification for [DatamateDataGrid].
class DatamateColumn {
  const DatamateColumn({
    required this.title,
    this.width,
    this.flex = 1,
    this.alignment = Alignment.centerLeft,
    this.textAlign = TextAlign.start,
    this.totalValue,
    this.totalWidget,
  });

  /// Column title displayed in the 40px dark blue header.
  final String title;

  /// Optional fixed width. If null, uses [flex].
  final double? width;

  /// Flex weight when [width] is not set.
  final int flex;

  final Alignment alignment;
  final TextAlign textAlign;

  /// Text to render in the totals band for this column.
  final String? totalValue;

  /// Custom widget to render in the totals band for this column.
  final Widget? totalWidget;
}

/// Transaction data grid adhering to Datamate G3 standards:
/// - Primary Dark Blue header row (40px fixed height, 12px cell padding, white semi-bold text)
/// - Standard data rows with minimum 48px height
/// - Full-width lightly tinted green Totals Band anchored at bottom with vertically aligned values
/// - Trailing row action slots with 8px gaps
class DatamateDataGrid extends StatelessWidget {
  const DatamateDataGrid({
    super.key,
    required this.columns,
    required this.itemCount,
    required this.rowBuilder,
    this.actionsColumnWidth = 120.0,
    this.showTotals = true,
    this.totalsTitle = 'Total',
    this.emptyPlaceholder,
  });

  final List<DatamateColumn> columns;
  final int itemCount;

  /// Builder for each row. Returns a list of cell widgets matching the order of [columns],
  /// followed by an optional trailing action widget group.
  final Widget Function(BuildContext context, int index) rowBuilder;

  /// Width allocated to the actions column at the far right.
  final double actionsColumnWidth;

  /// Whether to render the full-width green totals band at the bottom.
  final bool showTotals;

  /// Label in the leading totals column.
  final String totalsTitle;

  final Widget? emptyPlaceholder;

  @override
  Widget build(BuildContext context) {
    final colors = context.datamateColors;
    final spacing = context.datamateSpacing;
    final dimensions = context.datamateDimensions;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(dimensions.containerRadius),
        border: Border.all(
          color: colors.borderLight,
          width: dimensions.dividerThickness,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Header Row (Primary Dark Blue, 40px height, 12px padding)
          Container(
            height: dimensions.gridHeaderHeight, // 40px
            color: colors.primaryDarkBlue,
            padding: EdgeInsets.symmetric(horizontal: spacing.sm), // 12px
            child: Row(
              children: [
                for (final col in columns) ...[
                  _wrapCell(
                    col: col,
                    child: Container(
                      alignment: col.alignment,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        col.title,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: colors.textOnPrimary,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ),
                  ),
                ],
                // Header slot for right-aligned actions
                SizedBox(
                  width: actionsColumnWidth,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Actions',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: colors.textOnPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. Data Rows
          if (itemCount == 0)
            Container(
              height: 120,
              alignment: Alignment.center,
              child: emptyPlaceholder ??
                  Text(
                    'No transaction lines added yet.',
                    style: TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      color: colors.textMuted,
                    ),
                  ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: itemCount,
              separatorBuilder: (context, _) => Divider(
                height: 1,
                thickness: dimensions.dividerThickness,
                color: colors.borderLight.withValues(alpha: 0.6),
              ),
              itemBuilder: (context, index) {
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: dimensions.gridRowMinHeight, // 48px min
                  ),
                  child: Container(
                    color: index.isEven
                        ? Colors.transparent
                        : colors.surfaceVariant.withValues(alpha: 0.3),
                    padding: EdgeInsets.symmetric(
                      horizontal: spacing.sm,
                      vertical: 6,
                    ),
                    child: rowBuilder(context, index),
                  ),
                );
              },
            ),

          // 3. Totals Band (Lightly Tinted Green, 40-44px, vertically aligned values)
          if (showTotals)
            Container(
              decoration: BoxDecoration(
                color: colors.totalsBand, // Light green tint
                border: Border(
                  top: BorderSide(
                    color: colors.semanticSuccess.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: spacing.sm, // 12px
                vertical: 10,
              ),
              child: Row(
                children: [
                  for (int i = 0; i < columns.length; i++) ...[
                    _wrapCell(
                      col: columns[i],
                      child: Container(
                        alignment: columns[i].alignment,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: columns[i].totalWidget ??
                            Text(
                              columns[i].totalValue ?? (i == 0 ? totalsTitle : ''),
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: colors.primaryDarkBlue,
                              ),
                            ),
                      ),
                    ),
                  ],
                  // Empty space to align with actions column
                  SizedBox(width: actionsColumnWidth),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _wrapCell({required DatamateColumn col, required Widget child}) {
    if (col.width != null) {
      return SizedBox(width: col.width, child: child);
    }
    return Expanded(flex: col.flex, child: child);
  }
}
