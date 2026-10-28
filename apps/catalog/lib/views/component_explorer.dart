import 'package:flutter/material.dart';
import 'components/buttons_view.dart';
import 'components/dropdowns_view.dart';
import 'components/text_fields_view.dart';

export 'common/showcase_card.dart';
export 'common/showcase_header.dart';
export 'common/showcase_scaffold.dart';
export 'components/buttons_view.dart';
export 'components/dropdowns_view.dart';
export 'components/text_fields_view.dart';

/// Facade delegator rendering live UI component showcases mapped to
/// corresponding markdown guidelines in `docs/guidelines/`.
///
/// Dispatches dynamically to modular component views ([TextFieldsView],
/// [ButtonsView], [DropdownsView]) based on [componentId].
class ComponentExplorer extends StatelessWidget {
  const ComponentExplorer({
    super.key,
    required this.componentId,
    this.targetItem,
  });

  final String componentId;
  final String? targetItem;

  @override
  Widget build(BuildContext context) {
    switch (componentId) {
      case TextFieldsView.componentId:
        return TextFieldsView(targetItem: targetItem);
      case ButtonsView.componentId:
        return ButtonsView(targetItem: targetItem);
      case DropdownsView.componentId:
        return DropdownsView(targetItem: targetItem);
      default:
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Text(
              'Select a component from the sidebar navigation.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        );
    }
  }
}
