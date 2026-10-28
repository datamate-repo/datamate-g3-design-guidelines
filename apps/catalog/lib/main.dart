import 'package:flutter/material.dart';
import 'package:datamate_g3_ui/datamate_g3_ui.dart';
import 'routing/app_router.dart';

export 'routing/app_router.dart';
export 'routing/catalog_registry.dart';
export 'shell/catalog_shell.dart';

void main() {
  runApp(const DatamateCatalogApp());
}

/// Root application widget for the Datamate G3 Component Catalog.
class DatamateCatalogApp extends StatelessWidget {
  const DatamateCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Datamate G3 — Component Catalog',
      debugShowCheckedModeBanner: false,
      theme: DatamateTheme.light(),
      themeMode: ThemeMode.light,
      routerConfig: AppRouter.router,
    );
  }
}
