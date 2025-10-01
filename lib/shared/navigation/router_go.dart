import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_genius_test_task/components/error/view/error_view.dart';
import 'package:pro_genius_test_task/components/home/view/home_view.dart';
import 'package:pro_genius_test_task/shared/constants/route_constants.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// COMMENT: Variable for navigation in App
/// restorationId - Saves the screen state. This is useful for our mobile
/// applications.
/// For example, if a user opens our app and navigates through three screens,
/// then switches to another app, when they return to our app,
/// it opens on the last screen they accessed. This provides a seamless
/// and convenient user experience.

GoRouter router = GoRouter(
  // routerNeglect: true,
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  errorBuilder: (context, state) => const ErrorScreen(),
  initialLocation: KRoute.home.path,
  routes: [
    GoRoute(
      name: KRoute.home.name,
      path: KRoute.home.path,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        name: state.name,
        restorationId: state.pageKey.value,
        child: const HomeScreen(),
      ),
    ),
  ],
);
