import 'dart:convert';
import 'dart:developer';

import 'package:dynamic_dashboard/core/config/app_config.dart';
import 'package:dynamic_dashboard/infrastructure/datasources/weather/weather_remote_datasource.dart';
import 'package:dynamic_dashboard/infrastructure/models/weather/weahter_model.dart';
import 'package:dynamic_dashboard/infrastructure/services/location_exception.dart';
import 'package:dynamic_dashboard/infrastructure/services/location_service.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@Injectable(as: WeatherRemoteDataSource)
class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  WeatherRemoteDataSourceImpl(
    this.client,
    this.appConfig,
    this.locationService,
  );
  final http.Client client;
  final AppConfig appConfig;
  final LocationService locationService;

  @override
  Future<WeatherModel> getCurrentWeather() async {
    try {
      // Try to get current GPS location first
      final position = await locationService.getCurrentLocation();

      if (position != null) {
        return _getWeatherForLocation(position.latitude, position.longitude);
      } else {
        // Fallback to last known location
        final lastPosition = await locationService.getLastKnownPosition();
        if (lastPosition != null) {
          return _getWeatherForLocation(
            lastPosition.latitude,
            lastPosition.longitude,
          );
        }
      }
    } on LocationPermissionException catch (e) {
      log('Location permission error: $e');
      // User denied permission, use default location
    } on LocationServiceException catch (e) {
      log('Location service error: $e');
      // Location service disabled, use default location
    } on LocationException catch (e) {
      log('Location error: $e');
      // Other location errors, use default location
    }

    // Fallback to Jakarta coordinates if GPS fails
    return _getWeatherForLocation(-6.21, 106.85);
  }

  /// Get weather data for specific coordinates
  Future<WeatherModel> _getWeatherForLocation(double lat, double lon) async {
    final url =
        '${appConfig.openWeatherBaseUrl}/weather?lat=$lat&lon=$lon&appid=${appConfig.openWeatherApiKey}';

    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      return WeatherModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load weather data: ${response.statusCode}');
    }
  }
}
