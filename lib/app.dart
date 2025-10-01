import 'package:flutter/material.dart';
import 'package:pro_genius_test_task/l10n/l10n.dart';
import 'package:pro_genius_test_task/shared/shared.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeAnimationDuration: Duration.zero,
      theme: themeData,
      localizationsDelegates: locale,
      locale: const Locale('en'),
      supportedLocales: supportedLocales,
      routerConfig: router,
    );
  }
}
