import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../tokens/theme_extensions.dart';

/// Callback when user types a search query to execute an asynchronous or remote API call.
typedef DatamateApiSearchCallback = void Function(String query);

/// Callback to build the display text in the trigger field.
typedef DatamateApiTitleBuilder<T> = String Function(T item);

/// Callback to build each row in the dropdown overlay list.
typedef DatamateApiItemBuilder<T> = Widget Function(T item);

/// Asynchronous searchable dropdown with API search and lazy-loading support:
/// - 40px fixed height trigger field matching [DatamateTextField]
/// - Search query debounced (default 500ms) before triggering [onSearch]
/// - Reactive loading spinner and empty state handling
/// - Anchored floating overlay with bounds-checked positioning
/// - Alphanumeric keypress on focused field auto-opens search
/// - Arrow keys navigate list, Enter selects, Escape dismisses
/// - Optional clearable (✕) trigger icon
/// - Optional left-aligned label with 8px gap
class DatamateAsyncSearchableDropdown<T> extends StatefulWidget {
  const DatamateAsyncSearchableDropdown({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.titleBuilder,
    required this.onSearch,
    required this.onChanged,
    this.selectedItem,
    this.isLoading = false,
    this.focusNode,
    this.label,
    this.labelWidth,
    this.hint = 'Select an item...',
    this.searchHint = 'Search...',
    this.dropdownWidth = 440,
    this.dropdownHeight = 420,
    this.searchDebounceDuration = const Duration(milliseconds: 500),
    this.enabled = true,
    this.clearable = false,
    this.width,
    this.prefixIcon,
    this.headerActionWidget,
    this.headerFilterWidget,
  });

  /// The list of items currently loaded (e.g. from API responses).
  final List<T> items;

  /// Builds the display widget for a row in the overlay list.
  final DatamateApiItemBuilder<T> itemBuilder;

  /// Returns the text to display in the trigger field when an item is selected.
  final DatamateApiTitleBuilder<T> titleBuilder;

  /// Called after [searchDebounceDuration] to trigger remote data fetching.
  final DatamateApiSearchCallback onSearch;

  /// Callback when an item is selected or cleared.
  final ValueChanged<T?>? onChanged;

  /// Currently selected item.
  final T? selectedItem;

  /// Whether an asynchronous fetch is currently in flight.
  final bool isLoading;

  /// Focus node for keyboard interactions.
  final FocusNode? focusNode;

  /// Optional label placed horizontally to the left of the field.
  final String? label;

  /// Optional fixed width for the left-hand label.
  final double? labelWidth;

  /// Placeholder hint inside the trigger field.
  final String hint;

  /// Placeholder hint inside the search field.
  final String searchHint;

  /// Width of the floating dropdown overlay.
  final double dropdownWidth;

  /// Height of the floating dropdown overlay.
  final double dropdownHeight;

  /// Debounce duration before invoking [onSearch].
  final Duration searchDebounceDuration;

  /// Whether the dropdown is interactive.
  final bool enabled;

  /// Whether to display a clear (✕) button when an item is selected.
  final bool clearable;

  /// Optional fixed width for the collapsed trigger field.
  final double? width;

  /// Optional prefix icon in the collapsed trigger field.
  final Widget? prefixIcon;

  /// Optional action widget in overlay header (e.g., "Add New").
  final Widget? headerActionWidget;

  /// Optional filter button in overlay header.
  final Widget? headerFilterWidget;

  @override
  State<DatamateAsyncSearchableDropdown<T>> createState() =>
      _DatamateAsyncSearchableDropdownState<T>();
}

class _DatamateAsyncSearchableDropdownState<T>
    extends State<DatamateAsyncSearchableDropdown<T>> {
  late FocusNode _focusNode;
  late ValueNotifier<List<T>> _itemsNotifier;
  late ValueNotifier<bool> _loadingNotifier;
  late TextEditingController _displayController;
  T? _selectedItem;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _selectedItem = widget.selectedItem;
    _itemsNotifier = ValueNotifier(widget.items);
    _loadingNotifier = ValueNotifier(widget.isLoading);
    _displayController = TextEditingController(text: _displayText());
    _focusNode.addListener(_handleFocusChange);
  }

  String _displayText() {
    return _selectedItem != null ? widget.titleBuilder(_selectedItem as T) : '';
  }

  @override
  void didUpdateWidget(covariant DatamateAsyncSearchableDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items != oldWidget.items) {
      final newItems = List<T>.from(widget.items);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _itemsNotifier.value = newItems;
      });
    }
    if (widget.isLoading != oldWidget.isLoading) {
      final newLoading = widget.isLoading;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _loadingNotifier.value = newLoading;
      });
    }
    if (widget.selectedItem != oldWidget.selectedItem) {
      _selectedItem = widget.selectedItem;
      _displayController.text = _displayText();
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_handleFocusChange);
    }
    _itemsNotifier.dispose();
    _loadingNotifier.dispose();
    _displayController.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (mounted) setState(() {});
  }

  bool get _isInteractive => widget.enabled && widget.onChanged != null;

  void _showDropdown(BuildContext context, {String? initialSearchText}) {
    if (!_isInteractive) return;

    final renderBox = context.findRenderObject();
    if (renderBox is! RenderBox) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final screenSize = MediaQuery.of(context).size;

    double top = position.dy + size.height + 4;
    double left = position.dx;

    if (left + widget.dropdownWidth > screenSize.width) {
      left = screenSize.width - widget.dropdownWidth - 16;
    }
    if (top + widget.dropdownHeight > screenSize.height) {
      top = position.dy - widget.dropdownHeight - 4;
      if (top < 16) top = 16;
    }
    if (left < 16) left = 16;

    final colors = context.datamateColors;

    showGeneralDialog<T>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      transitionDuration: const Duration(milliseconds: 150),
      pageBuilder: (dialogCtx, anim1, anim2) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.of(dialogCtx).pop(),
                child: const ColoredBox(color: Colors.transparent),
              ),
            ),
            Positioned(
              top: top,
              left: left,
              child: Material(
                elevation: 6,
                color: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: colors.borderLight),
                ),
                child: SizedBox(
                  width: widget.dropdownWidth,
                  height: widget.dropdownHeight,
                  child: _AsyncOverlayContent<T>(
                    title: widget.hint,
                    itemsNotifier: _itemsNotifier,
                    loadingNotifier: _loadingNotifier,
                    itemBuilder: widget.itemBuilder,
                    onSearch: widget.onSearch,
                    searchDebounceDuration: widget.searchDebounceDuration,
                    initialSearchText: initialSearchText,
                    initialSelectedItem: _selectedItem,
                    searchHint: widget.searchHint,
                    headerActionWidget: widget.headerActionWidget,
                    headerFilterWidget: widget.headerFilterWidget,
                    onItemSelected: (item) {
                      Navigator.of(dialogCtx).pop();
                      widget.onChanged?.call(item);
                      setState(() {
                        _selectedItem = item;
                        _displayController.text = _displayText();
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  KeyEventResult _handleKeyPress(KeyEvent event, BuildContext context) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    if (_focusNode.hasFocus && _isInteractive) {
      if (HardwareKeyboard.instance.isControlPressed ||
          HardwareKeyboard.instance.isAltPressed ||
          HardwareKeyboard.instance.isMetaPressed ||
          HardwareKeyboard.instance.isShiftPressed) {
        return KeyEventResult.ignored;
      }

      final label = event.logicalKey.keyLabel;
      if (label.length == 1 && RegExp(r'^[a-zA-Z0-9]$').hasMatch(label)) {
        _showDropdown(context, initialSearchText: label);
        return KeyEventResult.handled;
      }

      if (event.logicalKey == LogicalKeyboardKey.enter ||
          event.logicalKey == LogicalKeyboardKey.arrowDown) {
        _showDropdown(context);
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.datamateColors;
    final spacing = context.datamateSpacing;
    final dimensions = context.datamateDimensions;
    final typography = context.datamateTypography;

    final showClear = widget.clearable && _selectedItem != null && _isInteractive;

    final suffixIcon = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showClear)
          IconButton(
            icon: Icon(Icons.close_rounded, size: 16, color: colors.textMuted),
            splashRadius: 14,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 40),
            tooltip: 'Clear selection',
            onPressed: () {
              widget.onChanged?.call(null);
              setState(() {
                _selectedItem = null;
                _displayController.clear();
              });
            },
          ),
        Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 20,
          color: _isInteractive ? colors.textMuted : colors.textMuted.withValues(alpha: 0.5),
        ),
        const SizedBox(width: 8),
      ],
    );

    final triggerField = Builder(
      builder: (triggerCtx) {
        return SizedBox(
          height: dimensions.inputHeight, // 40px
          width: widget.width,
          child: TextField(
            focusNode: _focusNode
              ..onKeyEvent = (node, event) => _handleKeyPress(event, triggerCtx),
            enabled: _isInteractive,
            readOnly: true,
            onTap: _isInteractive ? () => _showDropdown(triggerCtx) : null,
            controller: _displayController,
            style: typography.body.copyWith(
              color: _isInteractive ? colors.textPrimary : colors.textMuted,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: colors.inputFill,
              hintText: widget.hint,
              hintStyle: typography.body.copyWith(
                fontSize: 13,
                color: colors.textMuted.withValues(alpha: 0.8),
                fontWeight: FontWeight.normal,
              ),
              contentPadding: EdgeInsets.only(
                left: widget.prefixIcon != null ? 4 : spacing.sm,
                right: 4,
                top: 10,
                bottom: 10,
              ),
              prefixIcon: widget.prefixIcon,
              prefixIconConstraints: widget.prefixIcon != null
                  ? BoxConstraints(
                      minWidth: 36,
                      maxWidth: 36,
                      minHeight: dimensions.inputHeight,
                      maxHeight: dimensions.inputHeight,
                    )
                  : null,
              suffixIcon: suffixIcon,
              suffixIconConstraints: BoxConstraints(
                minHeight: dimensions.inputHeight,
                maxHeight: dimensions.inputHeight,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(dimensions.inputRadius),
                borderSide: BorderSide(color: colors.borderLight, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(dimensions.inputRadius),
                borderSide: BorderSide(color: colors.borderLight, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(dimensions.inputRadius),
                borderSide: BorderSide(color: colors.primaryDarkBlue, width: 1.5),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(dimensions.inputRadius),
                borderSide: BorderSide(
                  color: colors.borderLight.withValues(alpha: 0.5),
                  width: 1.0,
                ),
              ),
            ),
          ),
        );
      },
    );

    if (widget.label == null) {
      return triggerField;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.labelWidth != null)
          SizedBox(
            width: widget.labelWidth,
            child: Text(
              widget.label!,
              style: typography.label.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        else
          Text(
            widget.label!,
            style: typography.label.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        SizedBox(width: spacing.xs), // 8px horizontal gap
        if (widget.width != null)
          triggerField
        else
          Expanded(child: triggerField),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// ASYNC OVERLAY CONTENT
// ─────────────────────────────────────────────────────────────

class _AsyncOverlayContent<T> extends StatefulWidget {
  const _AsyncOverlayContent({
    required this.title,
    required this.itemsNotifier,
    required this.loadingNotifier,
    required this.itemBuilder,
    required this.onSearch,
    required this.onItemSelected,
    required this.searchHint,
    required this.searchDebounceDuration,
    this.initialSearchText,
    this.initialSelectedItem,
    this.headerActionWidget,
    this.headerFilterWidget,
  });

  final String title;
  final ValueNotifier<List<T>> itemsNotifier;
  final ValueNotifier<bool> loadingNotifier;
  final DatamateApiItemBuilder<T> itemBuilder;
  final DatamateApiSearchCallback onSearch;
  final ValueChanged<T?> onItemSelected;
  final String searchHint;
  final Duration searchDebounceDuration;
  final String? initialSearchText;
  final T? initialSelectedItem;
  final Widget? headerActionWidget;
  final Widget? headerFilterWidget;

  @override
  State<_AsyncOverlayContent<T>> createState() =>
      _AsyncOverlayContentState<T>();
}

class _AsyncOverlayContentState<T> extends State<_AsyncOverlayContent<T>> {
  final FocusNode _searchFocusNode = FocusNode();
  final FocusNode _listFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounceTimer;
  int? _highlightedIndex;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialSearchText;
    if (initial != null && initial.isNotEmpty) {
      _searchController.text = initial;
    }

    widget.itemsNotifier.addListener(_syncHighlight);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _searchFocusNode.requestFocus();
      if (_searchController.text.isNotEmpty) {
        _searchController.selection = TextSelection.collapsed(
          offset: _searchController.text.length,
        );
      }
      _syncHighlight();
      if (initial != null && initial.isNotEmpty) {
        widget.onSearch(initial);
      } else {
        widget.onSearch('');
      }
    });
  }

  @override
  void dispose() {
    widget.itemsNotifier.removeListener(_syncHighlight);
    _debounceTimer?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    _searchFocusNode.dispose();
    _listFocusNode.dispose();
    super.dispose();
  }

  void _syncHighlight() {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final items = widget.itemsNotifier.value;
      if (widget.initialSelectedItem != null && items.isNotEmpty) {
        final index = items.indexOf(widget.initialSelectedItem as T);
        setState(() {
          _highlightedIndex = index != -1 ? index : null;
        });
        if (_highlightedIndex != null) _scrollToHighlighted();
      } else {
        setState(() => _highlightedIndex = null);
      }
    });
  }

  void _scrollToHighlighted() {
    if (_highlightedIndex == null || !_scrollController.hasClients) return;
    _scrollController.animateTo(
      _highlightedIndex!.clamp(0, widget.itemsNotifier.value.length - 1) * 44.0,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeInOut,
    );
  }

  void _onSearchChanged(String query) {
    setState(() {});
    _debounceTimer?.cancel();
    if (query.trim().isEmpty) {
      widget.onSearch('');
      return;
    }
    _debounceTimer = Timer(widget.searchDebounceDuration, () {
      widget.onSearch(query);
    });
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return;
    final items = widget.itemsNotifier.value;

    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        if (_highlightedIndex == null) {
          _highlightedIndex = 0;
          _listFocusNode.requestFocus();
        } else if (_highlightedIndex! < items.length - 1) {
          _highlightedIndex = _highlightedIndex! + 1;
        }
      });
      _scrollToHighlighted();
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        if (_highlightedIndex == null || _highlightedIndex == 0) {
          _highlightedIndex = null;
          _searchFocusNode.requestFocus();
        } else {
          _highlightedIndex = _highlightedIndex! - 1;
        }
      });
      _scrollToHighlighted();
    } else if (event.logicalKey == LogicalKeyboardKey.enter) {
      if (_highlightedIndex != null && _highlightedIndex! < items.length) {
        widget.onItemSelected(items[_highlightedIndex!]);
      } else if (items.length == 1) {
        widget.onItemSelected(items.first);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.datamateColors;
    final dimensions = context.datamateDimensions;
    final typography = context.datamateTypography;

    return KeyboardListener(
      focusNode: _listFocusNode,
      onKeyEvent: _handleKeyEvent,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header bar
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: typography.title.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colors.primaryDarkBlue,
                    ),
                  ),
                ),
                if (widget.headerFilterWidget != null) widget.headerFilterWidget!,
                if (widget.headerActionWidget != null) ...[
                  const SizedBox(width: 8),
                  widget.headerActionWidget!,
                ],
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.close_rounded, size: 18),
                  splashRadius: 16,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  tooltip: 'Close',
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Search input field
            SizedBox(
              height: dimensions.inputHeight,
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                style: typography.body,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: colors.inputFill,
                  hintText: widget.searchHint,
                  hintStyle: typography.body.copyWith(
                    color: colors.textMuted,
                    fontSize: 13,
                  ),
                  prefixIcon: Icon(Icons.search_rounded, size: 18, color: colors.textMuted),
                  prefixIconConstraints: const BoxConstraints(minWidth: 36, maxWidth: 36),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, size: 16),
                          padding: EdgeInsets.zero,
                          splashRadius: 14,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            _searchController.clear();
                            _onSearchChanged('');
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(dimensions.inputRadius),
                    borderSide: BorderSide(color: colors.borderLight),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(dimensions.inputRadius),
                    borderSide: BorderSide(color: colors.borderLight),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(dimensions.inputRadius),
                    borderSide: BorderSide(color: colors.primaryDarkBlue, width: 1.5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),

            // Results list or loading indicator
            Expanded(
              child: ListenableBuilder(
                listenable: Listenable.merge([
                  widget.itemsNotifier,
                  widget.loadingNotifier,
                ]),
                builder: (context, _) {
                  final items = widget.itemsNotifier.value;
                  final isLoading = widget.loadingNotifier.value;

                  if (isLoading && items.isEmpty) {
                    return Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(colors.primaryDarkBlue),
                        ),
                      ),
                    );
                  }

                  if (items.isEmpty) {
                    return Center(
                      child: Text(
                        'No results found',
                        style: typography.body.copyWith(
                          color: colors.textMuted,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final isSelected = _highlightedIndex == index;

                      return InkWell(
                        onTap: () => widget.onItemSelected(item),
                        hoverColor: colors.primaryDarkBlue.withValues(alpha: 0.05),
                        child: Container(
                          constraints: const BoxConstraints(minHeight: 44),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? colors.primaryDarkBlue.withValues(alpha: 0.1)
                                : null,
                            border: Border(
                              bottom: BorderSide(
                                color: colors.borderLight.withValues(alpha: 0.5),
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: widget.itemBuilder(item),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
