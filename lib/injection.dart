import 'package:dynamic_dashboard/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(
  preferRelativeImports: true,
)
Future<void> configureDependencies() => getIt.init();
