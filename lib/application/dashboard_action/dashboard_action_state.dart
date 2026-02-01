part of 'dashboard_action_cubit.dart';

@freezed
abstract class DashboardActionState with _$DashboardActionState {
  const DashboardActionState._();
  factory DashboardActionState({
    required StockPriceCubit stockPriceCubit,
    required WeatherCubit weatherCubit,
    required NewsCubit newsCubit,
    @Default('dashboard_card_order') String cardOrderKey,
    @Default(['weather', 'news', 'stock']) List<String> cardOrder,
  }) = _DashboardActionState;
  factory DashboardActionState.initial() => DashboardActionState(
    stockPriceCubit: getIt<StockPriceCubit>(),
    weatherCubit: getIt<WeatherCubit>(),
    newsCubit: getIt<NewsCubit>(),
  );
}
