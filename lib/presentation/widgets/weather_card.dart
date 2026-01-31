import 'package:dynamic_dashboard/domain/entities/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dynamic_dashboard/application/weather/weather_cubit.dart';
import 'package:dynamic_dashboard/injection.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<WeatherCubit>()..getCurrentWeather(),
      child: Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state) {
              return state.when(
                initial: () => _buildInitialState(),
                loading: () => _buildLoadingState(),
                loaded: (weather) => _buildLoadedState(weather, context),
                error: (message) => _buildErrorState(message, context),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInitialState() {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.wb_sunny, size: 64, color: Colors.grey),
        SizedBox(height: 16),
        Text(
          'Weather',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text('Tap to load', style: TextStyle(fontSize: 18, color: Colors.grey)),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Main row skeleton (icon, city, temperature)
        Row(
          children: [
            // Skeleton icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Skeleton city name
                  Container(
                    height: 20,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Skeleton description
                  Container(
                    height: 12,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
            // Skeleton temperature
            Container(
              height: 36,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Skeleton for bottom row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Container(
                  height: 12,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  height: 16,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  height: 12,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  height: 16,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoadedState(Weather weather, BuildContext context) {
    final temp = (weather.main.temp - 273.15)
        .round(); // Convert from Kelvin to Celsius
    final weatherInfo = weather.weather.isNotEmpty ? weather.weather[0] : null;
    final description = weatherInfo?.description ?? 'Unknown';
    final main = weatherInfo?.main ?? 'Weather';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Icon, City name, and Temperature in one row
        Row(
          children: [
            Icon(
              _getWeatherIcon(weatherInfo?.main),
              size: 48,
              color: _getWeatherColor(weatherInfo?.main),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weather.name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    description.toUpperCase(),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Text(
              '${temp}°C',
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w300),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Text(
                  'Feels like',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  '${(weather.main.feelsLike - 273.15).round()}°C',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const Text(
                  'Humidity',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  '${weather.main.humidity}%',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildErrorState(String message, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.error_outline, size: 64, color: Colors.red),
        const SizedBox(height: 16),
        const Text(
          'Weather Error',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          message,
          style: const TextStyle(fontSize: 16, color: Colors.red),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            context.read<WeatherCubit>().getCurrentWeather();
          },
          child: const Text('Retry'),
        ),
      ],
    );
  }

  IconData _getWeatherIcon(String? main) {
    switch (main?.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        return Icons.wb_cloudy;
      case 'rain':
        return Icons.grain;
      case 'thunderstorm':
        return Icons.flash_on;
      case 'snow':
        return Icons.ac_unit;
      case 'mist':
      case 'fog':
        return Icons.cloud;
      default:
        return Icons.wb_sunny;
    }
  }

  Color _getWeatherColor(String? main) {
    switch (main?.toLowerCase()) {
      case 'clear':
        return Colors.orange;
      case 'clouds':
        return Colors.grey;
      case 'rain':
        return Colors.blue;
      case 'thunderstorm':
        return Colors.purple;
      case 'snow':
        return Colors.lightBlue;
      case 'mist':
      case 'fog':
        return Colors.blueGrey;
      default:
        return Colors.orange;
    }
  }
}
