import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:dynamic_dashboard/infrastructure/datasources/weather/weather_remote_datasource_impl.dart';
import 'package:dynamic_dashboard/infrastructure/models/weather/weahter_model.dart';

// Mock classes
class MockHttpClient extends Mock implements http.Client {}

class TestData {
  static const weatherJson = {
    "coord": {"lon": -122.08, "lat": 37.39},
    "weather": [
      {"id": 800, "main": "Clear", "description": "clear sky", "icon": "01d"}
    ],
    "main": {
      "temp": 282.55,
      "feels_like": 281.86,
      "temp_min": 280.37,
      "temp_max": 284.26,
      "pressure": 1023,
      "humidity": 100,
      "sea_level": 1013,
      "grnd_level": 1013
    },
    "timezone": -25200,
    "id": 420006353,
    "name": "Mountain View"
  };
}

void main() {
  late WeatherRemoteDataSourceImpl datasource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    datasource = WeatherRemoteDataSourceImpl(mockHttpClient);
  });

  group('WeatherRemoteDataSource', () {
    const tUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=-6.21&lon=106.85&appid=7c3d47baddb40e54c8308f592008dbf0';

    test('should return WeatherModel when the response code is 200', () async {
      // arrange
      when(() => mockHttpClient.get(Uri.parse(tUrl), headers: any(named: 'headers')))
          .thenAnswer(
        (_) async => http.Response(json.encode(TestData.weatherJson), 200),
      );

      // act
      final result = await datasource.getCurrentWeather();

      // assert
      expect(result, isA<WeatherModel>());
      verify(() => mockHttpClient.get(Uri.parse(tUrl), headers: any(named: 'headers')));
    });

    test(
      'should throw Exception when the response code is 404 or other',
      () async {
        // arrange
        when(
          () => mockHttpClient.get(Uri.parse(tUrl), headers: any(named: 'headers')),
        ).thenAnswer((_) async => http.Response('Not found', 404));

        // act
        final call = datasource.getCurrentWeather();

        // assert
        expect(() => call, throwsA(isA<Exception>()));
        verify(() => mockHttpClient.get(Uri.parse(tUrl), headers: any(named: 'headers')));
      },
    );

    test(
      'should throw Exception when there is a network error',
      () async {
        // arrange
        when(
          () => mockHttpClient.get(Uri.parse(tUrl), headers: any(named: 'headers')),
        ).thenThrow(const SocketException('No Internet connection'));

        // act
        final call = datasource.getCurrentWeather();

        // assert
        expect(() => call, throwsA(isA<SocketException>()));
        verify(() => mockHttpClient.get(Uri.parse(tUrl), headers: any(named: 'headers')));
      },
    );
  });
}
