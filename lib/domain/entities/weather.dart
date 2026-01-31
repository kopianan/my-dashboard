import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather.freezed.dart';

@freezed
abstract class Weather with _$Weather {
  const factory Weather({
    required Coord coord,
    required List<WeatherInfo> weather,
    required WeatherMain main,
    required int timezone,
    required int id,
    required String name,
  }) = _Weather;
}

@freezed
abstract class Coord with _$Coord {
  const factory Coord({required double lon, required double lat}) = _Coord;
}

@freezed
abstract class WeatherInfo with _$WeatherInfo {
  const factory WeatherInfo({
    required int id,
    required String main,
    required String description,
    required String icon,
  }) = _WeatherInfo;
}

@freezed
abstract class WeatherMain with _$WeatherMain {
  const factory WeatherMain({
    required double temp,
    required double feelsLike,
    required double tempMin,
    required double tempMax,
    required int pressure,
    required int humidity,
    required int seaLevel,
    required int grndLevel,
  }) = _WeatherMain;
}
