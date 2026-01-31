import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'dashboard_action_state.dart';
part 'dashboard_action_cubit.freezed.dart';

@injectable
class DashboardActionCubit extends Cubit<DashboardActionState> {
  DashboardActionCubit() : super(DashboardActionState.initial());
}
