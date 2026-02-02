import 'package:dynamic_dashboard/application/auth/auth_cubit.dart';
import 'package:dynamic_dashboard/application/dashboard_action/dashboard_action_cubit.dart';
import 'package:dynamic_dashboard/core/router/app_router.dart';
import 'package:dynamic_dashboard/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthCubit>()),
        BlocProvider(
          create: (context) => getIt<DashboardActionCubit>()..loadCardOrder(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Dynamic Dashboard',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
