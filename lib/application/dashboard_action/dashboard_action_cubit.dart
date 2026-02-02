import 'package:bloc/bloc.dart';
import 'package:dynamic_dashboard/domain/repositories/auth_repository.dart';
import 'package:dynamic_dashboard/utils/pref_const.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'dashboard_action_state.dart';
part 'dashboard_action_cubit.freezed.dart';

@injectable
class DashboardActionCubit extends Cubit<DashboardActionState> {
  DashboardActionCubit(this._authRepository)
    : super(DashboardActionState.initial());
  final AuthRepository _authRepository;

  Future<void> loadCardOrder() async {
    try {
      final userResult = await _authRepository.getCurrentUser();
      final userEmail = userResult.fold(
        (error) => '', // If no user, use empty string (fallback)
        (user) => user.email,
      );

      if (userEmail.isEmpty) return; // Don't load if no user is logged in

      final prefs = await SharedPreferences.getInstance();
      final userSpecificKey = '${PrefConst.cardOrderKey}_$userEmail';
      final savedOrder = prefs.getStringList(userSpecificKey);
      if (savedOrder != null && savedOrder.isNotEmpty) {
        emit(state.copyWith(cardOrder: savedOrder));
      }
    } catch (e) {
      // Handle error silently, keep default order
    }
  }

  Future<void> reorderCards(int oldIndex, int newIndex) async {
    final currentOrder = List<String>.from(state.cardOrder);
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = currentOrder.removeAt(oldIndex);
    currentOrder.insert(newIndex, item);

    emit(state.copyWith(cardOrder: currentOrder));
    await saveCardOrder(currentOrder);
  }

  Future<void> saveCardOrder(List<String> cardOrder) async {
    try {
      final userResult = await _authRepository.getCurrentUser();
      final userEmail = userResult.fold(
        (error) => '', // If no user, use empty string (fallback)
        (user) => user.email,
      );

      if (userEmail.isEmpty) return; // Don't save if no user is logged in

      final prefs = await SharedPreferences.getInstance();
      final userSpecificKey = '${PrefConst.cardOrderKey}_$userEmail';
      await prefs.setStringList(userSpecificKey, cardOrder);
    } catch (e) {
      // Handle error silently
    }
  }

  /// Clear card order preferences for the current user
  Future<void> clearUserCardOrder() async {
    try {
      final userResult = await _authRepository.getCurrentUser();
      final userEmail = userResult.fold((error) => '', (user) => user.email);

      if (userEmail.isEmpty) return;

      final prefs = await SharedPreferences.getInstance();
      final userSpecificKey = '${PrefConst.cardOrderKey}_$userEmail';
      await prefs.remove(userSpecificKey);
    } catch (e) {
      // Handle error silently
    }
  }

  /// Reset card order to default for current user
  Future<void> resetCardOrder() async {
    emit(state.copyWith(cardOrder: DashboardActionState.initial().cardOrder));
    await clearUserCardOrder();
  }
}
