import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../routing/catalog_registry.dart';

/// Navigation sidebar rendering catalog modules grouped by category.
class CatalogSidebar extends StatelessWidget {
  const CatalogSidebar({
    super.key,
    required this.currentPath,
  });

  final String currentPath;

  static const Color _brandBlue = Color(0xFF20389B);
  static const Color _sidebarBg = Color(0xFFF8FAFC);

  @override
  Widget build(BuildContext context) {
    final categories = CatalogRegistry.modulesByCategory;

    return Container(
      width: 260,
      color: _sidebarBg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildBrandHeader(),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                for (final entry in categories.entries) ...[
                  _buildCategoryHeader(entry.key),
                  for (final module in entry.value)
                    _buildNavTile(context, module),
                  const SizedBox(height: 8),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: _brandBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'G3',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Datamate G3',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Component Catalog',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryHeader(String categoryTitle) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 12, bottom: 8),
      child: Text(
        categoryTitle,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: Colors.grey.shade500,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildNavTile(BuildContext context, CatalogModule module) {
    final isSelected = currentPath == module.path;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Material(
        color: isSelected
            ? _brandBlue.withValues(alpha: 0.08)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => context.go(module.path),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            child: Row(
              children: [
                Icon(
                  module.icon,
                  size: 18,
                  color: isSelected ? _brandBlue : Colors.grey,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    module.label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected ? _brandBlue : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
