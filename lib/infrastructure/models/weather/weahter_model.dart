import 'package:dynamic_dashboard/domain/entities/weather.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weahter_model.freezed.dart';
part 'weahter_model.g.dart';

@freezed
abstract class WeatherModel with _$WeatherModel {
  const factory WeatherModel({
    required CoordModel coord,
    required List<WeatherInfoModel> weather,
    required MainModel main,
    required int timezone,
    required int id,
    required String name,
  }) = _WeatherModel;
  const WeatherModel._();

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  // Convert to domain entity
  Weather toDomain() {
    return Weather(
      coord: coord.toDomain(),
      weather: weather.map((w) => w.toDomain()).toList(),
      main: main.toDomain(),
      timezone: timezone,
      id: id,
      name: name,
    );
  }
}

@freezed
abstract class CoordModel with _$CoordModel {
  const factory CoordModel({required double lon, required double lat}) =
      _CoordModel;
  const CoordModel._();

  factory CoordModel.fromJson(Map<String, dynamic> json) =>
      _$CoordModelFromJson(json);

  // Convert to domain entity
  Coord toDomain() {
    return Coord(lon: lon, lat: lat);
  }
}

@freezed
abstract class WeatherInfoModel with _$WeatherInfoModel {
  const factory WeatherInfoModel({
    required int id,
    required String main,
    required String description,
    required String icon,
  }) = _WeatherInfoModel;
  const WeatherInfoModel._();

  factory WeatherInfoModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherInfoModelFromJson(json);

  // Convert to domain entity
  WeatherInfo toDomain() {
    return WeatherInfo(
      id: id,
      main: main,
      description: description,
      icon: icon,
    );
  }
}

@freezed
abstract class MainModel with _$MainModel {
  const factory MainModel({
    required double temp,
    @JsonKey(name: 'feels_like') required double feelsLike,
    @JsonKey(name: 'temp_min') required double tempMin,
    @JsonKey(name: 'temp_max') required double tempMax,
    required int pressure,
    required int humidity,
    @JsonKey(name: 'sea_level') required int seaLevel,
    @JsonKey(name: 'grnd_level') required int grndLevel,
  }) = _MainModel;
  const MainModel._();

  factory MainModel.fromJson(Map<String, dynamic> json) =>
      _$MainModelFromJson(json);

  // Convert to domain entity
  WeatherMain toDomain() {
    return WeatherMain(
      temp: temp - 273.15,
      feelsLike: feelsLike - 273.15,
      tempMin: tempMin - 273.15,
      tempMax: tempMax - 273.15,
      pressure: pressure,
      humidity: humidity,
      seaLevel: seaLevel,
      grndLevel: grndLevel,
    );
  }
}
