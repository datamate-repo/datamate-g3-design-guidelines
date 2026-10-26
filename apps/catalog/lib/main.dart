import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:datamate_g3_ui/datamate_g3_ui.dart';
import 'views/component_explorer.dart';

void main() {
  runApp(const DatamateCatalogApp());
}

class DatamateCatalogApp extends StatefulWidget {
  const DatamateCatalogApp({super.key});

  @override
  State<DatamateCatalogApp> createState() => _DatamateCatalogAppState();
}

class _DatamateCatalogAppState extends State<DatamateCatalogApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      initialLocation: '/text-fields',
      routes: [
        GoRoute(
          path: '/',
          redirect: (_, _) => '/text-fields',
        ),
        ShellRoute(
          builder: (context, state, child) {
            return CatalogShell(
              currentPath: state.uri.path,
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: '/text-fields',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: ComponentExplorer(
                  componentId: 'text-fields',
                  targetItem: state.uri.queryParameters['item'],
                ),
              ),
            ),
            GoRoute(
              path: '/buttons',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: ComponentExplorer(
                  componentId: 'buttons',
                  targetItem: state.uri.queryParameters['item'],
                ),
              ),
            ),
            GoRoute(
              path: '/dropdowns',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: ComponentExplorer(
                  componentId: 'dropdowns',
                  targetItem: state.uri.queryParameters['item'],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Datamate G3 — Component Catalog',
      debugShowCheckedModeBanner: false,
      theme: DatamateTheme.light(),
      themeMode: ThemeMode.light,
      routerConfig: _router,
    );
  }
}

class CatalogShell extends StatelessWidget {
  const CatalogShell({
    super.key,
    required this.currentPath,
    required this.child,
  });

  final String currentPath;
  final Widget child;

  static const _navItems = <_NavItem>[
    _NavItem(
      id: 'text-fields',
      label: 'Text Fields',
      icon: Icons.text_fields_rounded,
    ),
    _NavItem(
      id: 'buttons',
      label: 'Buttons & Actions',
      icon: Icons.smart_button_rounded,
    ),
    _NavItem(
      id: 'dropdowns',
      label: 'Dropdowns',
      icon: Icons.arrow_drop_down_circle_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _buildSidebar(context),
          const VerticalDivider(width: 1, thickness: 1),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    const blue = Color(0xFF20389B);

    return Container(
      width: 260,
      color: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          // Brand header
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: blue,
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
          ),
          const Divider(height: 1),

          // Section label
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
            child: Text(
              'COMPONENTS',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade500,
                letterSpacing: 0.8,
              ),
            ),
          ),

          // Nav items
          for (final item in _navItems) _buildNavTile(context, item),

          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildNavTile(BuildContext context, _NavItem item) {
    final isSelected = currentPath == '/${item.id}';
    const blue = Color(0xFF20389B);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Material(
        color: isSelected
            ? blue.withValues(alpha: 0.08)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => context.go('/${item.id}'),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  size: 18,
                  color: isSelected ? blue : Colors.grey,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected ? blue : null,
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

class _NavItem {
  const _NavItem({
    required this.id,
    required this.label,
    required this.icon,
  });

  final String id;
  final String label;
  final IconData icon;
}
