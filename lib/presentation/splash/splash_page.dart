import 'package:dynamic_dashboard/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dynamic_dashboard/application/auth/auth_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  void _checkAuthStatus() async {
    //add three secnd delay
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      final authCubit = getIt<AuthCubit>();
      await authCubit.checkAuthStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      bloc: getIt<AuthCubit>(),
      listener: (context, state) {
        state.maybeMap(
          orElse: () {}, // Do nothing
          authenticated: (user) {
            // User already logged in → go to dashboard
            if (mounted) context.go('/dashboard');
          },
          unauthenticated: (e) {
            // User not login -> go to loginpage
            if (mounted) context.go('/login');
          },
          error: (message) {
            // Error → go to loginpage
            if (mounted) context.go('/login');
          },
        );
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.dashboard,
                size: 100,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 20),
              const Text(
                'Dynamic Dashboard',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(),
              const SizedBox(height: 10),
              const Text(
                'Checking authentication...',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
