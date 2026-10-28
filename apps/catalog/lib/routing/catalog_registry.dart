import 'package:flutter/material.dart';
import '../views/components/buttons_view.dart';
import '../views/components/dropdowns_view.dart';
import '../views/components/text_fields_view.dart';

/// Specification and descriptor for a catalog component module or standalone page.
class CatalogModule {
  const CatalogModule({
    required this.id,
    required this.label,
    required this.icon,
    this.category = 'COMPONENTS',
    required this.builder,
  });

  /// Unique identifier used for routing (e.g., 'text-fields' -> '/text-fields').
  final String id;

  /// Human-readable title displayed in navigation headers and sidebars.
  final String label;

  /// Navigation icon representing the module.
  final IconData icon;

  /// Grouping category (e.g., 'COMPONENTS', 'PATTERNS', 'FOUNDATIONS').
  final String category;

  /// Page builder constructing the view, forwarding deep-link target anchor if present.
  final Widget Function(BuildContext context, String? targetItem) builder;

  /// Full route path for GoRouter.
  String get path => '/$id';
}

/// Central registry of all catalog modules.
///
/// Adding a new component or page in the future only requires adding a single
/// [CatalogModule] definition here. Routes, deep linking, sidebar tiles, and
/// category groupings are resolved automatically.
class CatalogRegistry {
  CatalogRegistry._();

  /// Registered modules in the Datamate G3 catalog.
  static final List<CatalogModule> modules = [
    CatalogModule(
      id: TextFieldsView.componentId,
      label: 'Text Fields',
      icon: Icons.text_fields_rounded,
      category: 'COMPONENTS',
      builder: (context, targetItem) => TextFieldsView(
        targetItem: targetItem,
      ),
    ),
    CatalogModule(
      id: ButtonsView.componentId,
      label: 'Buttons & Actions',
      icon: Icons.smart_button_rounded,
      category: 'COMPONENTS',
      builder: (context, targetItem) => ButtonsView(
        targetItem: targetItem,
      ),
    ),
    CatalogModule(
      id: DropdownsView.componentId,
      label: 'Dropdowns',
      icon: Icons.arrow_drop_down_circle_outlined,
      category: 'COMPONENTS',
      builder: (context, targetItem) => DropdownsView(
        targetItem: targetItem,
      ),
    ),
  ];

  /// Initial route path when accessing root URL '/'.
  static String get initialLocation =>
      modules.isNotEmpty ? modules.first.path : '/';

  /// Resolves modules grouped by their parent category for structured sidebar layout.
  static Map<String, List<CatalogModule>> get modulesByCategory {
    final map = <String, List<CatalogModule>>{};
    for (final module in modules) {
      map.putIfAbsent(module.category, () => []).add(module);
    }
    return map;
  }

  /// Finds a registered module by its unique identifier.
  static CatalogModule? findById(String id) {
    try {
      return modules.firstWhere((m) => m.id == id);
    } catch (_) {
      return null;
    }
  }
}
