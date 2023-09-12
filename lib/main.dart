import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:test_project/presentation/theme/app_themes.dart';
import 'package:test_project/presentation/routes/app_router.dart';
import 'package:test_project/dependency_injection.dart' as di;

void main() {
  di.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppThemes.light(),
      routerDelegate:
          RoutemasterDelegate(routesBuilder: (context) => AppRouter.routes),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
