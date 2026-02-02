import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:dynamic_dashboard/infrastructure/repositories/weather_repository_impl.dart';
import 'package:dynamic_dashboard/infrastructure/datasources/weather/weather_remote_datasource.dart';
import 'package:dynamic_dashboard/infrastructure/models/weather/weahter_model.dart';
import 'package:dynamic_dashboard/domain/entities/weather.dart';

class MockWeatherRemoteDataSource extends Mock implements WeatherRemoteDataSource {}

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
      "humidity": 100
    },
    "timezone": -25200,
    "id": 420006353,
    "name": "Mountain View"
  };
}

void main() {
  late WeatherRepositoryImpl repository;
  late MockWeatherRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockWeatherRemoteDataSource();
    repository = WeatherRepositoryImpl(mockRemoteDataSource);
  });

  group('getCurrentWeather', () {
    final tWeatherModel = WeatherModel(
      coord: CoordModel(lon: -122.08, lat: 37.39),
      weather: [
        WeatherInfoModel(id: 800, main: "Clear", description: "clear sky", icon: "01d")
      ],
      main: MainModel(
        temp: 282.55,
        feelsLike: 281.86,
        tempMin: 280.37,
        tempMax: 284.26,
        pressure: 1023,
        humidity: 100,
        seaLevel: 1013,
        grndLevel: 1013,
      ),
      timezone: -25200,
      id: 420006353,
      name: "Mountain View",
    );

    final tWeather = Weather(
      coord: Coord(lon: -122.08, lat: 37.39),
      weather: [
        WeatherInfo(id: 800, main: "Clear", description: "clear sky", icon: "01d")
      ],
      main: WeatherMain(
        temp: 282.55,
        feelsLike: 281.86,
        tempMin: 280.37,
        tempMax: 284.26,
        pressure: 1023,
        humidity: 100,
        seaLevel: 1013,
        grndLevel: 1013,
      ),
      timezone: -25200,
      id: 420006353,
      name: "Mountain View",
    );

    test(
      'should return Weather when call to remote data source is successful',
      () async {
        // arrange
        when(() => mockRemoteDataSource.getCurrentWeather())
            .thenAnswer((_) async => tWeatherModel);

        // act
        final result = await repository.getCurrentWeather();

        // assert
        expect(result, Right(tWeather));
        verify(() => mockRemoteDataSource.getCurrentWeather());
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should return String error when call to remote data source fails',
      () async {
        // arrange
        when(() => mockRemoteDataSource.getCurrentWeather())
            .thenThrow(Exception('Server error'));

        // act
        final result = await repository.getCurrentWeather();

        // assert
        expect(result, isA<Left<String, Weather>>());
        verify(() => mockRemoteDataSource.getCurrentWeather());
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should return String error when there is no internet connection',
      () async {
        // arrange
        when(() => mockRemoteDataSource.getCurrentWeather())
            .thenThrow(Exception('No internet connection'));

        // act
        final result = await repository.getCurrentWeather();

        // assert
        expect(result, isA<Left<String, Weather>>());
        verify(() => mockRemoteDataSource.getCurrentWeather());
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );
  });
}