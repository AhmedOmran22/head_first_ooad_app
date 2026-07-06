import 'package:flutter/material.dart';

import 'core/di/injector.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

void main() {
  setupInjector();
  runApp(const HeadFirstOoadApp());
}

class HeadFirstOoadApp extends StatelessWidget {
  const HeadFirstOoadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Head First OOA&D',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      routerConfig: appRouter,
    );
  }
}
