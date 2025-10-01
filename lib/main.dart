import 'dart:async';

import 'package:flutter/material.dart' show WidgetsFlutterBinding;
import 'package:pro_genius_test_task/app.dart';
import 'package:pro_genius_test_task/bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await bootstrap(App.new);
}
