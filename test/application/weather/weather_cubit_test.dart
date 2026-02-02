import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:dynamic_dashboard/application/weather/weather_cubit.dart';
import 'package:dynamic_dashboard/domain/repositories/weather_repository.dart';
import 'package:dynamic_dashboard/domain/entities/weather.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late WeatherCubit weatherCubit;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    weatherCubit = WeatherCubit(mockWeatherRepository);
  });

  tearDown(() {
    weatherCubit.close();
  });

  const tWeather = Weather(
    coord: Coord(lon: -122.08, lat: 37.39),
    weather: [
      WeatherInfo(
        id: 800,
        main: 'Clear',
        description: 'clear sky',
        icon: '01d',
      ),
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
    name: 'Mountain View',
  );

  group('WeatherCubit', () {
    test('initial state should be WeatherState.initial', () {
      expect(weatherCubit.state, const WeatherState.initial());
    });

    group('getCurrentWeather', () {
      blocTest<WeatherCubit, WeatherState>(
        'emits [loading, loaded] when getCurrentWeather is successful',
        build: () {
          when(() => mockWeatherRepository.getCurrentWeather())
              .thenAnswer((_) async => const Right(tWeather));
          return weatherCubit;
        },
        act: (cubit) => cubit.getCurrentWeather(),
        expect: () => [
          const WeatherState.loading(),
          const WeatherState.loaded(tWeather),
        ],
        verify: (_) {
          verify(() => mockWeatherRepository.getCurrentWeather());
        },
      );

      blocTest<WeatherCubit, WeatherState>(
        'emits [loading, error] when getCurrentWeather fails',
        build: () {
          when(() => mockWeatherRepository.getCurrentWeather())
              .thenAnswer((_) async => const Left('Failed to get weather data'));
          return weatherCubit;
        },
        act: (cubit) => cubit.getCurrentWeather(),
        expect: () => [
          const WeatherState.loading(),
          const WeatherState.error('Failed to get weather data'),
        ],
        verify: (_) {
          verify(() => mockWeatherRepository.getCurrentWeather());
        },
      );

      blocTest<WeatherCubit, WeatherState>(
        'emits [loading, error] when getCurrentWeather throws an exception',
        build: () {
          when(() => mockWeatherRepository.getCurrentWeather())
              .thenThrow(Exception('Network error'));
          return weatherCubit;
        },
        act: (cubit) => cubit.getCurrentWeather(),
        expect: () => [
          const WeatherState.loading(),
          const WeatherState.error('Exception: Network error'),
        ],
        verify: (_) {
          verify(() => mockWeatherRepository.getCurrentWeather());
        },
      );
    });
  });
}