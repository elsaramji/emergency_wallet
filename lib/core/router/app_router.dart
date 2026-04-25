import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Emergency Cash MVP')),
        ),
      ),
    ],
  );
}
