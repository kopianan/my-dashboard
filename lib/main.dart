import 'package:dynamic_dashboard/application/auth/auth_cubit.dart';
import 'package:dynamic_dashboard/core/config/app_config.dart';
import 'package:dynamic_dashboard/core/router/app_router.dart';
import 'package:dynamic_dashboard/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables
  await dotenv.load(fileName: '.env');
  
  // Configure dependencies
  await configureDependencies();

  // Validate configuration
  final appConfig = getIt<AppConfig>();
  appConfig.validateConfiguration();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => getIt<AuthCubit>())],
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
