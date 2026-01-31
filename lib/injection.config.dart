// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import 'application/auth/auth_cubit.dart' as _i457;
import 'application/dashboard_action/dashboard_action_cubit.dart' as _i872;
import 'application/news/news_cubit.dart' as _i40;
import 'application/stock_price/stock_price_cubit.dart' as _i985;
import 'application/weather/weather_cubit.dart' as _i197;
import 'domain/repositories/auth_repository.dart' as _i716;
import 'domain/repositories/news_repository.dart' as _i983;
import 'domain/repositories/stock_price_repository.dart' as _i552;
import 'domain/repositories/weather_repository.dart' as _i690;
import 'infrastructure/datasources/auth/auth_local_datasource.dart' as _i190;
import 'infrastructure/datasources/auth/auth_local_datasource_impl.dart'
    as _i971;
import 'infrastructure/datasources/auth/auth_remote_datasource.dart' as _i708;
import 'infrastructure/datasources/auth/auth_remote_datasource_impl.dart'
    as _i514;
import 'infrastructure/datasources/news/news_remote_datasource.dart' as _i822;
import 'infrastructure/datasources/news/news_remote_datasource_impl.dart'
    as _i537;
import 'infrastructure/datasources/stock_price/stock_price_websocket_datasource.dart'
    as _i439;
import 'infrastructure/datasources/stock_price/stock_price_websocket_datasource_impl.dart'
    as _i789;
import 'infrastructure/datasources/weather/weather_remote_datasource.dart'
    as _i887;
import 'infrastructure/datasources/weather/weather_remote_datasource_impl.dart'
    as _i61;
import 'infrastructure/modules/http_module.dart' as _i326;
import 'infrastructure/modules/shared_preferences_module.dart' as _i1038;
import 'infrastructure/providers/stock_price_data_provider.dart' as _i517;
import 'infrastructure/repositories/auth_repository_impl.dart' as _i933;
import 'infrastructure/repositories/news_repository_impl.dart' as _i0;
import 'infrastructure/repositories/stock_price_repository_impl.dart' as _i615;
import 'infrastructure/repositories/weather_repository_impl.dart' as _i517;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final sharedPreferencesModule = _$SharedPreferencesModule();
    final httpModule = _$HttpModule();
    gh.factory<_i872.DashboardActionCubit>(() => _i872.DashboardActionCubit());
    gh.factory<_i517.StockPriceDataProvider>(
      () => _i517.StockPriceDataProvider(),
    );
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => sharedPreferencesModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i519.Client>(() => httpModule.client);
    gh.lazySingleton<_i708.AuthRemoteDataSource>(
      () => _i514.AuthRemoteDataSourceImpl(),
    );
    gh.factory<_i439.StockPriceWebSocketDataSource>(
      () => _i789.StockPriceWebSocketDataSourceImpl(),
    );
    gh.lazySingleton<_i190.AuthLocalDataSource>(
      () => _i971.AuthLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i822.NewsRemoteDataSource>(
      () => _i537.NewsRemoteDataSourceImpl(gh<_i519.Client>()),
    );
    gh.factory<_i887.WeatherRemoteDataSource>(
      () => _i61.WeatherRemoteDataSourceImpl(gh<_i519.Client>()),
    );
    gh.factory<_i690.WeatherRepository>(
      () => _i517.WeatherRepositoryImpl(gh<_i887.WeatherRemoteDataSource>()),
    );
    gh.factory<_i197.WeatherCubit>(
      () => _i197.WeatherCubit(gh<_i690.WeatherRepository>()),
    );
    gh.factory<_i552.StockPriceRepository>(
      () => _i615.StockPriceRepositoryImpl(
        gh<_i439.StockPriceWebSocketDataSource>(),
      ),
    );
    gh.lazySingleton<_i716.AuthRepository>(
      () => _i933.AuthRepositoryImpl(
        gh<_i708.AuthRemoteDataSource>(),
        gh<_i190.AuthLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i457.AuthCubit>(
      () => _i457.AuthCubit(gh<_i716.AuthRepository>()),
    );
    gh.factory<_i983.NewsRepository>(
      () => _i0.NewsRepositoryImpl(gh<_i822.NewsRemoteDataSource>()),
    );
    gh.factory<_i985.StockPriceCubit>(
      () => _i985.StockPriceCubit(
        gh<_i552.StockPriceRepository>(),
        gh<_i517.StockPriceDataProvider>(),
      ),
    );
    gh.factory<_i40.NewsCubit>(
      () => _i40.NewsCubit(gh<_i983.NewsRepository>()),
    );
    return this;
  }
}

class _$SharedPreferencesModule extends _i1038.SharedPreferencesModule {}

class _$HttpModule extends _i326.HttpModule {}
