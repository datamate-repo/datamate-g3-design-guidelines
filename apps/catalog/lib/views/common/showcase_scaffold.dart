import 'package:flutter/material.dart';
import 'package:datamate_g3_ui/datamate_g3_ui.dart';

/// Reusable layout scaffold for component showcase views.
///
/// Manages GlobalKey registry, post-frame smooth scrolling when deep linking to
/// a specific target item anchor, and 2-second highlight pulse animations.
class ShowcaseScaffold extends StatefulWidget {
  const ShowcaseScaffold({
    super.key,
    required this.componentId,
    this.targetItem,
    required this.builder,
  });

  final String componentId;
  final String? targetItem;
  final List<Widget> Function(
    BuildContext context,
    GlobalKey Function(String itemId) keyFor,
    bool Function(String itemId) isHighlighted,
  ) builder;

  @override
  State<ShowcaseScaffold> createState() => _ShowcaseScaffoldState();
}

class _ShowcaseScaffoldState extends State<ShowcaseScaffold> {
  final Map<String, GlobalKey> _cardKeys = {};
  String? _highlightedItem;

  @override
  void initState() {
    super.initState();
    if (widget.targetItem != null) {
      _scheduleScrollToTarget(widget.targetItem!);
    }
  }

  @override
  void didUpdateWidget(covariant ShowcaseScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.targetItem != oldWidget.targetItem && widget.targetItem != null) {
      _scheduleScrollToTarget(widget.targetItem!);
    }
  }

  void _scheduleScrollToTarget(String itemId) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final key = _cardKeys[itemId];
      if (key?.currentContext != null) {
        Scrollable.ensureVisible(
          key!.currentContext!,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          alignment: 0.05,
        );
        setState(() => _highlightedItem = itemId);
        Future.delayed(const Duration(milliseconds: 2000), () {
          if (mounted && _highlightedItem == itemId) {
            setState(() => _highlightedItem = null);
          }
        });
      }
    });
  }

  GlobalKey _keyFor(String itemId) {
    return _cardKeys.putIfAbsent(itemId, () => GlobalKey());
  }

  bool _isHighlighted(String itemId) {
    return _highlightedItem == itemId;
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.datamateSpacing;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: spacing.lg,
        vertical: spacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.builder(context, _keyFor, _isHighlighted),
      ),
    );
  }
}
