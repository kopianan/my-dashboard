// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import 'application/auth/auth_cubit.dart' as _i457;
import 'domain/repositories/auth_repository.dart' as _i716;
import 'infrastructure/datasources/auth_local_datasource.dart' as _i602;
import 'infrastructure/datasources/auth_local_datasource_impl.dart' as _i797;
import 'infrastructure/datasources/auth_remote_datasource.dart' as _i923;
import 'infrastructure/datasources/auth_remote_datasource_impl.dart' as _i129;
import 'infrastructure/modules/shared_preferences_module.dart' as _i1038;
import 'infrastructure/repositories/auth_repository_impl.dart' as _i933;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final sharedPreferencesModule = _$SharedPreferencesModule();
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => sharedPreferencesModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i923.AuthRemoteDataSource>(
      () => _i129.AuthRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i602.AuthLocalDataSource>(
      () => _i797.AuthLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i716.AuthRepository>(
      () => _i933.AuthRepositoryImpl(
        gh<_i923.AuthRemoteDataSource>(),
        gh<_i602.AuthLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i457.AuthCubit>(
      () => _i457.AuthCubit(gh<_i716.AuthRepository>()),
    );
    return this;
  }
}

class _$SharedPreferencesModule extends _i1038.SharedPreferencesModule {}
