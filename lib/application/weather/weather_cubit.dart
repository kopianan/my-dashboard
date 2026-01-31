import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:dynamic_dashboard/domain/repositories/weather_repository.dart';
import 'package:dynamic_dashboard/domain/entities/weather.dart';

part 'weather_state.dart';
part 'weather_cubit.freezed.dart';

@injectable
class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;
  
  WeatherCubit(this._weatherRepository) : super(const WeatherState.initial());

  Future<void> getCurrentWeather() async {
    emit(const WeatherState.loading());
    
    final result = await _weatherRepository.getCurrentWeather();
    
    result.fold(
      (error) => emit(WeatherState.error(error)),
      (weather) => emit(WeatherState.loaded(weather)),
    );
  }
}
