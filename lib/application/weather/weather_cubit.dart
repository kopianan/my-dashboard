import 'package:bloc/bloc.dart';
import 'package:dynamic_dashboard/domain/entities/weather.dart';
import 'package:dynamic_dashboard/domain/repositories/weather_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'weather_cubit.freezed.dart';
part 'weather_state.dart';

@injectable
class WeatherCubit extends Cubit<WeatherState> {
  
  WeatherCubit(this._weatherRepository) : super(const WeatherState.initial());
  final WeatherRepository _weatherRepository;

  Future<void> getCurrentWeather() async {
    emit(const WeatherState.loading());
    
    try {
      final result = await _weatherRepository.getCurrentWeather();
      
      result.fold(
        (error) => emit(WeatherState.error(error)),
        (weather) => emit(WeatherState.loaded(weather)),
      );
    } catch (error) {
      emit(WeatherState.error(error.toString()));
    }
  }
}
