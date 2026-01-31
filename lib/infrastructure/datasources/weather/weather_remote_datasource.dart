import 'package:dynamic_dashboard/infrastructure/models/weather/weahter_model.dart';

abstract class WeatherRemoteDataSource {

  /// Fetch current weather for current location
  Future<WeatherModel> getCurrentWeather();
}