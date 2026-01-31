import 'package:dynamic_dashboard/presentation/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dynamic_dashboard/presentation/splash/splash_page.dart';
import 'package:dynamic_dashboard/presentation/login/login_page.dart';
 
class AppRouter {
  static GoRouter get router => _router;

  static final _router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardPage(),
        routes: [
          // Nested routes can be added here for different sections of the dashboard
          // Example:
          // GoRoute(
          //   path: '/profile',
          //   name: 'profile',
          //   builder: (context, state) => const ProfilePage(),
          // ),
          // GoRoute(
          //   path: '/settings',
          //   name: 'settings',
          //   builder: (context, state) => const SettingsPage(),
          // ),
        ],
      ),
    ],
    // Optional: Handle redirects for authentication
    redirect: (context, state) {
      // This is where you can add authentication logic
      // For example:
      // final isLoggedIn = AuthService.isLoggedIn;
      // final isGoingToLogin = state.location == '/login';
      // if (!isLoggedIn && !isGoingToLogin) {
      //   return '/login';
      // }
      return null; // No redirect needed
    },
    // Optional: Error handling
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text('Path: ${state.matchedLocation}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/dashboard'),
              child: const Text('Go to Dashboard'),
            ),
          ],
        ),
      ),
    ),
  );
}