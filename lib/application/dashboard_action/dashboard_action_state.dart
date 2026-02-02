part of 'dashboard_action_cubit.dart';

@freezed
abstract class DashboardActionState with _$DashboardActionState {
  factory DashboardActionState({
    @Default('dashboard_card_order') String cardOrderKey,
    @Default(['weather', 'news', 'stock']) List<String> cardOrder,
  }) = _DashboardActionState;
  const DashboardActionState._();
  factory DashboardActionState.initial() => DashboardActionState(
  );
}
