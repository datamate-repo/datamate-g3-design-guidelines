import 'package:go_router/go_router.dart';
import '../shell/catalog_shell.dart';
import 'catalog_registry.dart';

/// Centralized application router configuration.
///
/// Automatically creates and binds routes based on registered [CatalogRegistry.modules],
/// preserving deep-linking query parameters and maintaining the persistent sidebar shell.
class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: CatalogRegistry.initialLocation,
    routes: [
      GoRoute(
        path: '/',
        redirect: (_, _) => CatalogRegistry.initialLocation,
      ),
      ShellRoute(
        builder: (context, state, child) {
          return CatalogShell(
            currentPath: state.uri.path,
            child: child,
          );
        },
        routes: CatalogRegistry.modules.map((module) {
          return GoRoute(
            path: module.path,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: module.builder(context, state.uri.queryParameters['item']),
            ),
          );
        }).toList(),
      ),
    ],
  );
}
