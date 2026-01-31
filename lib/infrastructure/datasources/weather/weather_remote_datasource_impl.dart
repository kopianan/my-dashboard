import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:dynamic_dashboard/infrastructure/datasources/weather/weather_remote_datasource.dart';
import 'package:dynamic_dashboard/infrastructure/models/weather/weahter_model.dart';

@Injectable(as: WeatherRemoteDataSource)
class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;
  
  // You'll need to add your OpenWeatherMap API key here
  static const String _apiKey = '7c3d47baddb40e54c8308f592008dbf0';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  
  WeatherRemoteDataSourceImpl(this.client);
  
  @override
  Future<WeatherModel> getCurrentWeather() async {
    // Default to Jakarta coordinates - you can update this
    // or integrate with location services later
    const double defaultLat = -6.21;
    const double defaultLon = 106.85;
    
    final url = '$_baseUrl/weather?lat=$defaultLat&lon=$defaultLon&appid=$_apiKey';
    
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return WeatherModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load weather data: ${response.statusCode}');
    }
  }
}