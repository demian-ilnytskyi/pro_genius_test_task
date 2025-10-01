import 'dart:async' show FutureOr;

import 'package:flutter/material.dart' show Colors, Widget, runApp;
import 'package:flutter/services.dart';
import 'package:pro_genius_test_task/shared/helper/get_it_service_locator.dart';
import 'package:pro_genius_test_task/shared/shared.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  // Set only Vertical orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  if (PlatformEnum.getPlatform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  } else {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  configureDependencies();

  runApp(await builder());
}
