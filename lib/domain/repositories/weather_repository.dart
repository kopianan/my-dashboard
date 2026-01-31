import 'package:dartz/dartz.dart';
import 'package:dynamic_dashboard/domain/entities/weather.dart';

abstract class WeatherRepository {
  /// Fetch current weather for default location
  Future<Either<String, Weather>> getCurrentWeather();
}