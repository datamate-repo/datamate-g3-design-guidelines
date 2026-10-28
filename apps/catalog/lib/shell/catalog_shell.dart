import 'package:flutter/material.dart';
import 'catalog_sidebar.dart';

/// Persistent shell container hosting the sidebar navigation alongside active module views.
class CatalogShell extends StatelessWidget {
  const CatalogShell({
    super.key,
    required this.currentPath,
    required this.child,
  });

  final String currentPath;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          CatalogSidebar(currentPath: currentPath),
          const VerticalDivider(width: 1, thickness: 1),
          Expanded(child: child),
        ],
      ),
    );
  }
}
