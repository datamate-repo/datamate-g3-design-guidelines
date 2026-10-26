import 'package:flutter/material.dart';
import '../primitives/datamate_action_button.dart';
import '../tokens/theme_extensions.dart';

/// Top navigation and context header bar:
/// - Fixed height: 64px
/// - 16px horizontal interior padding
/// - Screen title aligned to the far left
/// - Global context (e.g. FY/Company badges) and Semantic Red exit button aligned to the far right.
class DatamateHeaderBar extends StatelessWidget implements PreferredSizeWidget {
  const DatamateHeaderBar({
    super.key,
    required this.title,
    this.subtitle,
    this.contextBadges = const [],
    this.onClose,
    this.closeLabel = 'Close',
    this.leading,
    this.customActions,
  });

  /// The primary screen title (e.g., "Journal Voucher Entry").
  final String title;

  /// Optional contextual sub-caption.
  final String? subtitle;

  /// Right-aligned context indicators (e.g., "FY: 2026-27", "MedTech Corp").
  final List<Widget> contextBadges;

  /// Trigger for closing or discarding the current view.
  final VoidCallback? onClose;

  /// Label for the Semantic Red exit button.
  final String closeLabel;

  /// Optional leading widget before the title.
  final Widget? leading;

  /// Optional additional trailing widgets before the close button.
  final List<Widget>? customActions;

  @override
  Size get preferredSize => const Size.fromHeight(64.0);

  @override
  Widget build(BuildContext context) {
    final colors = context.datamateColors;
    final spacing = context.datamateSpacing;
    final dimensions = context.datamateDimensions;
    final typography = context.datamateTypography;

    return Container(
      height: dimensions.headerHeight, // 64px
      padding: EdgeInsets.symmetric(horizontal: spacing.md), // 16px
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colors.borderLight,
            width: dimensions.dividerThickness,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leading != null) ...[
            leading!,
            SizedBox(width: spacing.sm),
          ],
          // Title on far left
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: typography.h2.copyWith(color: colors.primaryDarkBlue),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: typography.caption.copyWith(color: colors.textMuted),
                  ),
                ],
              ],
            ),
          ),
          // Far right context badges & actions
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...contextBadges,
                  ...?customActions,
                  if (onClose != null) ...[
                    SizedBox(width: spacing.md),
                    DatamateExitButton(
                      onPressed: onClose,
                      label: closeLabel,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
