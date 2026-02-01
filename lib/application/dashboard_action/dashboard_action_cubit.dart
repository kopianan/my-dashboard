import 'package:bloc/bloc.dart';
import 'package:dynamic_dashboard/application/news/news_cubit.dart';
import 'package:dynamic_dashboard/application/stock_price/stock_price_cubit.dart';
import 'package:dynamic_dashboard/application/weather/weather_cubit.dart';
import 'package:dynamic_dashboard/injection.dart';
import 'package:dynamic_dashboard/utils/pref_const.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'dashboard_action_state.dart';
part 'dashboard_action_cubit.freezed.dart';

@injectable
class DashboardActionCubit extends Cubit<DashboardActionState> {
  DashboardActionCubit() : super(DashboardActionState.initial());

  Future<void> loadCardOrder() async {
    final prefs = await SharedPreferences.getInstance();
    final savedOrder = prefs.getStringList(PrefConst.cardOrderKey);
    if (savedOrder != null && savedOrder.isNotEmpty) {
      emit(state.copyWith(cardOrder: savedOrder));
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
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(PrefConst.cardOrderKey, cardOrder);
  }
}
