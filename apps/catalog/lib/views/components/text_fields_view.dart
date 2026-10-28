import 'package:flutter/material.dart';
import 'package:datamate_g3_ui/datamate_g3_ui.dart';
import '../common/showcase_card.dart';
import '../common/showcase_header.dart';
import '../common/showcase_scaffold.dart';

/// Interactive showcase for Datamate G3 Text Field components mapped to `docs/guidelines/text-fields.md`.
class TextFieldsView extends StatelessWidget {
  const TextFieldsView({
    super.key,
    this.targetItem,
  });

  final String? targetItem;

  static const String componentId = 'text-fields';

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      componentId: componentId,
      targetItem: targetItem,
      builder: (context, keyFor, isHighlighted) => [
        const ShowcaseHeader(
          title: 'Text Fields',
          docPath: 'docs/guidelines/text-fields.md',
          summary:
              'All text inputs maintain a 40px fixed height, #ECEFF2 subtle fill, 12px interior padding, and 6px border radius. Labels sit horizontally on the left with an 8px gap.',
        ),

        // 1. Standard Input
        ShowcaseCard(
          key: keyFor('standard'),
          componentId: componentId,
          itemId: 'standard',
          isHighlighted: isHighlighted('standard'),
          title: '1. Standard Input (Editable)',
          docAnchor: 'text-fields.md#1-standard-input',
          ruleDescription:
              'Default text field with left-aligned label separated by an 8px gap. Text style: Poppins 13.5px Medium in #1E293B.',
          child: const SizedBox(
            width: 440,
            child: DatamateTextField(
              label: 'Full Name:',
              placeholder: 'e.g. Alex Morgan',
              labelWidth: 100,
            ),
          ),
        ),

        // 2. Numeric / Currency Input
        ShowcaseCard(
          key: keyFor('numeric'),
          componentId: componentId,
          itemId: 'numeric',
          isHighlighted: isHighlighted('numeric'),
          title: '2. Numeric / Currency Input',
          docAnchor: 'text-fields.md#2-numeric--currency-input',
          ruleDescription:
              'Right-aligned text with 0.00 default numerical placeholder. Preserves 40px height and 6px corner radius.',
          child: const SizedBox(
            width: 300,
            child: DatamateTextField(
              label: 'Price (\$):',
              initialValue: '1,250.00',
              textAlign: TextAlign.right,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              labelWidth: 80,
            ),
          ),
        ),

        // 3. Input with Prefix & Suffix Icons
        ShowcaseCard(
          key: keyFor('icons'),
          componentId: componentId,
          itemId: 'icons',
          isHighlighted: isHighlighted('icons'),
          title: '3. Inputs with Prefix & Suffix Icons',
          docAnchor: 'text-fields.md#3-prefix--suffix-icon-inputs',
          ruleDescription:
              'Interior icons for email addresses, calendar date triggers, or clear buttons. Preserves strict 40px fixed height in all states.',
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: const [
              SizedBox(
                width: 360,
                child: DatamateTextField(
                  label: 'Email:',
                  placeholder: 'alex.morgan@company.com',
                  prefixIcon: Icon(Icons.email_outlined, size: 18),
                  labelWidth: 80,
                ),
              ),
              SizedBox(
                width: 360,
                child: DatamateTextField(
                  label: 'Due Date:',
                  initialValue: '26-Oct-2026',
                  suffixIcon: Icon(Icons.calendar_today_outlined, size: 18),
                  labelWidth: 80,
                ),
              ),
            ],
          ),
        ),

        // 4. Disabled / Read-Only State
        ShowcaseCard(
          key: keyFor('disabled'),
          componentId: componentId,
          itemId: 'disabled',
          isHighlighted: isHighlighted('disabled'),
          title: '4. Disabled / Read-Only State',
          docAnchor: 'text-fields.md#4-read-only--disabled-input',
          ruleDescription:
              'Disabled inputs apply muted text (#64748B) and 50% opacity borders to indicate non-interactive status.',
          child: const SizedBox(
            width: 440,
            child: DatamateTextField(
              label: 'System ID:',
              initialValue: 'SYS-2026-X992',
              enabled: false,
              labelWidth: 100,
            ),
          ),
        ),

        // 5. Password / Hidden Input
        ShowcaseCard(
          key: keyFor('password'),
          componentId: componentId,
          itemId: 'password',
          isHighlighted: isHighlighted('password'),
          title: '5. Password / Masked Input',
          docAnchor: 'text-fields.md#5-password--masked-input',
          ruleDescription:
              'Obscured text entry with toggleable suffix visibility eye icon.',
          child: const SizedBox(
            width: 440,
            child: DatamateTextField(
              label: 'Master Key:',
              initialValue: 'SuperSecretToken123',
              obscureText: true,
              labelWidth: 100,
            ),
          ),
        ),

        // 6. Inline Input (Grid Cell Usage)
        ShowcaseCard(
          key: keyFor('inline'),
          componentId: componentId,
          itemId: 'inline',
          isHighlighted: isHighlighted('inline'),
          title: '6. Inline Input (Grid Cell Usage)',
          docAnchor: 'text-fields.md#6-grid-inline-input',
          ruleDescription:
              'When used inside grid cells, the label is omitted and the input fills the available column cell width.',
          child: SizedBox(
            width: 220,
            child: DatamateTextField(
              placeholder: 'Enter memo...',
              onChanged: (_) {},
            ),
          ),
        ),
      ],
    );
  }
}
