import 'package:go_router/go_router.dart';

extension AppRoutes on GoRouter {
  // Route names for type safety
  static const String splash = '/splash';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
}

extension GoRouterExtension on GoRouter {
  void goToSplash() => go(AppRoutes.splash);
  void goToLogin() => go(AppRoutes.login);
  void goToDashboard() => go(AppRoutes.dashboard);
}