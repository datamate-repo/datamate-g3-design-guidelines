import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:datamate_g3_ui/datamate_g3_ui.dart';

/// Reusable showcase card displaying a single component variant with rule description,
/// markdown spec anchor badge, deep link copy action, and active pulse styling.
class ShowcaseCard extends StatelessWidget {
  const ShowcaseCard({
    super.key,
    required this.itemId,
    required this.title,
    required this.docAnchor,
    required this.ruleDescription,
    required this.componentId,
    this.isHighlighted = false,
    required this.child,
  });

  final String itemId;
  final String title;
  final String docAnchor;
  final String ruleDescription;
  final String componentId;
  final bool isHighlighted;
  final Widget child;

  void _copyDeepLink(BuildContext context) {
    final host = Uri.base.host.isNotEmpty ? Uri.base.host : 'localhost';
    final port = Uri.base.hasPort ? ':${Uri.base.port}' : '';
    final deepLink = 'http://$host$port/#/$componentId?item=$itemId';

    Clipboard.setData(ClipboardData(text: deepLink));
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Deep link copied: /#/$componentId?item=$itemId',
                style: const TextStyle(fontSize: 12.5),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        width: 440,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.datamateColors;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isHighlighted ? colors.primaryDarkBlue : colors.borderLight,
          width: isHighlighted ? 2.0 : 1.0,
        ),
        boxShadow: isHighlighted
            ? [
                BoxShadow(
                  color: colors.primaryDarkBlue.withValues(alpha: 0.18),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: colors.primaryDarkBlue,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Markdown Spec reference badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: colors.borderLight),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.menu_book_outlined,
                      size: 12,
                      color: colors.textMuted,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      docAnchor,
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: colors.textMuted,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              // Copy Deep Link Icon Button
              IconButton(
                icon: const Icon(Icons.link_rounded, size: 17),
                tooltip: 'Copy Deep Link (/#/$componentId?item=$itemId)',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
                splashRadius: 16,
                color: colors.textMuted,
                hoverColor: colors.primaryDarkBlue.withValues(alpha: 0.08),
                onPressed: () => _copyDeepLink(context),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            ruleDescription,
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: colors.textMuted,
            ),
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}
