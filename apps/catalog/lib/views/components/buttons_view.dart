import 'package:flutter/material.dart';
import 'package:datamate_g3_ui/datamate_g3_ui.dart';
import '../common/showcase_card.dart';
import '../common/showcase_header.dart';
import '../common/showcase_scaffold.dart';

/// Interactive showcase for Datamate G3 Button components mapped to `docs/guidelines/buttons.md`.
class ButtonsView extends StatefulWidget {
  const ButtonsView({
    super.key,
    this.targetItem,
  });

  final String? targetItem;

  static const String componentId = 'buttons';

  @override
  State<ButtonsView> createState() => _ButtonsViewState();
}

class _ButtonsViewState extends State<ButtonsView> {
  bool _isSaving = false;
  String? _lastActionMessage;

  void _triggerSimulatedSave() {
    setState(() {
      _isSaving = true;
      _lastActionMessage = 'Saving changes in background...';
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isSaving = false;
          _lastActionMessage = 'Changes saved successfully!';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.datamateColors;

    return ShowcaseScaffold(
      componentId: ButtonsView.componentId,
      targetItem: widget.targetItem,
      builder: (context, keyFor, isHighlighted) => [
        const ShowcaseHeader(
          title: 'Buttons & Actions',
          docPath: 'docs/guidelines/buttons.md',
          summary:
              'Standard action controls: Primary (#20389B for main progression), Exit (#D32F2F for discard/close), and Secondary (Outlined). Row-level actions use simple icon buttons in green (add), orange (clear), and red (delete).',
        ),

        // 1. Primary Button
        ShowcaseCard(
          key: keyFor('primary'),
          componentId: ButtonsView.componentId,
          itemId: 'primary',
          isHighlighted: isHighlighted('primary'),
          title: '1. Primary Button (Save / Submit / Confirm)',
          docAnchor: 'buttons.md#1-primary-button-save--submit--confirm',
          ruleDescription:
              'Height: 40px, Background: #20389B, Font: Poppins 13.5px Semi-Bold, Radius: 6px. Typically positioned on the far right of action bars.',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 16,
                runSpacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  DatamatePrimaryButton(
                    label: 'Save Changes',
                    icon: Icons.check_circle_outline_rounded,
                    isLoading: _isSaving,
                    onPressed: _triggerSimulatedSave,
                  ),
                  DatamatePrimaryButton(
                    label: 'Create Item',
                    icon: Icons.add,
                    onPressed: () {
                      setState(() => _lastActionMessage = 'Action: Create Item triggered');
                    },
                  ),
                  const DatamatePrimaryButton(
                    label: 'Disabled Action',
                    onPressed: null,
                  ),
                ],
              ),
              if (_lastActionMessage != null) ...[
                const SizedBox(height: 12),
                Text(
                  'Feedback: $_lastActionMessage',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: colors.primaryDarkBlue,
                  ),
                ),
              ],
            ],
          ),
        ),

        // 2. Exit / Discard Button
        ShowcaseCard(
          key: keyFor('exit'),
          componentId: ButtonsView.componentId,
          itemId: 'exit',
          isHighlighted: isHighlighted('exit'),
          title: '2. Exit / Discard Button',
          docAnchor: 'buttons.md#2-exit-button-close--discard',
          ruleDescription:
              'Height: 36px, Background: Semantic Red (#D32F2F), Font: Poppins 13px Semi-Bold. Anchored at the far right of top navigation bars.',
          child: Wrap(
            spacing: 16,
            children: [
              DatamateExitButton(
                label: 'Close',
                onPressed: () {
                  setState(() => _lastActionMessage = 'Action: Close triggered');
                },
              ),
              DatamateExitButton(
                label: 'Discard Changes',
                onPressed: () {
                  setState(() => _lastActionMessage = 'Action: Discard Changes triggered');
                },
              ),
            ],
          ),
        ),

        // 3. Secondary Buttons
        ShowcaseCard(
          key: keyFor('secondary'),
          componentId: ButtonsView.componentId,
          itemId: 'secondary',
          isHighlighted: isHighlighted('secondary'),
          title: '3. Secondary Action Buttons (Outlined)',
          docAnchor: 'buttons.md#3-secondary-button-outlined',
          ruleDescription:
              'Height: 40px, Transparent background with 1px #DCE1E7 border, #20389B text. Positioned on the left of action bars for utility actions.',
          child: Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              DatamateSecondaryButton(
                label: 'View All',
                icon: Icons.view_list_rounded,
                onPressed: () {
                  setState(() => _lastActionMessage = 'Secondary action: View All');
                },
              ),
              DatamateSecondaryButton(
                label: 'Export CSV',
                icon: Icons.file_download_outlined,
                onPressed: () {
                  setState(() => _lastActionMessage = 'Secondary action: Export CSV');
                },
              ),
              DatamateSecondaryButton(
                label: 'Print Report',
                icon: Icons.print_outlined,
                onPressed: () {
                  setState(() => _lastActionMessage = 'Secondary action: Print Report');
                },
              ),
            ],
          ),
        ),

        // 4. Row Action Buttons
        ShowcaseCard(
          key: keyFor('row-actions'),
          componentId: ButtonsView.componentId,
          itemId: 'row-actions',
          isHighlighted: isHighlighted('row-actions'),
          title: '4. Row Action Buttons (Simple Icon Buttons)',
          docAnchor: 'buttons.md#4-row-action-buttons-grid-inline',
          ruleDescription:
              'Clean icon buttons with no container tiles or borders. Green (#2E7D32) = Add, Orange (#ED6C02) = Clear, Red (#D32F2F) = Delete. 8px gaps between buttons.',
          child: Row(
            children: [
              DatamateRowActionButton(
                type: DatamateRowActionType.add,
                onPressed: () {
                  setState(() => _lastActionMessage = 'Row action: Add Row clicked');
                },
              ),
              const SizedBox(width: 8),
              DatamateRowActionButton(
                type: DatamateRowActionType.clear,
                onPressed: () {
                  setState(() => _lastActionMessage = 'Row action: Clear Row clicked');
                },
              ),
              const SizedBox(width: 8),
              DatamateRowActionButton(
                type: DatamateRowActionType.delete,
                onPressed: () {
                  setState(() => _lastActionMessage = 'Row action: Delete Row clicked');
                },
              ),
              const SizedBox(width: 20),
              Text(
                '← Simple icon buttons with semantic colors and 8px gaps',
                style: TextStyle(fontSize: 12, color: colors.textMuted),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
