import 'package:flutter/material.dart';
import 'package:datamate_g3_ui/datamate_g3_ui.dart';

/// Reusable guideline header displaying the component title, markdown spec badge, and summary.
class ShowcaseHeader extends StatelessWidget {
  const ShowcaseHeader({
    super.key,
    required this.title,
    required this.docPath,
    required this.summary,
  });

  final String title;
  final String docPath;
  final String summary;

  @override
  Widget build(BuildContext context) {
    final colors = context.datamateColors;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: colors.primaryDarkBlue,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: colors.borderLight),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.description_outlined,
                      size: 13,
                      color: colors.textMuted,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      docPath,
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
            ],
          ),
          const SizedBox(height: 6),
          Text(
            summary,
            style: TextStyle(
              fontSize: 13.5,
              color: colors.textMuted,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
        ],
      ),
    );
  }
}
