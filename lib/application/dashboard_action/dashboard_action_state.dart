part of 'dashboard_action_cubit.dart';

@freezed
abstract class DashboardActionState with _$DashboardActionState {
  const DashboardActionState._();
  factory DashboardActionState() = _DashboardActionState;
  factory DashboardActionState.initial() => DashboardActionState();
}
