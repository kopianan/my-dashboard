import 'package:dynamic_dashboard/application/weather/weather_cubit.dart';
import 'package:dynamic_dashboard/domain/entities/weather.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key, required this.weatherCubit});
  final WeatherCubit weatherCubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: weatherCubit..getCurrentWeather(),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state) {
              return state.when(
                initial: _buildInitialState,
                loading: _buildLoadingState,
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
    return const Skeletonizer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Main row (icon, city, temperature)
          Row(
            children: [
              Icon(Icons.wb_sunny, size: 48, color: Colors.orange),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Loading City Name',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'LOADING WEATHER',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Text(
                '25°C',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w300),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    'Feels like',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    '23°C',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Humidity',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    '65%',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedState(Weather weather, BuildContext context) {
    final temp = (weather.main.temp.toStringAsFixed(2));
    final feelsLike = (weather.main.feelsLike.toStringAsFixed(2));

    final weatherInfo = weather.weather.isNotEmpty ? weather.weather[0] : null;
    final description = weatherInfo?.description ?? 'Unknown';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description.toUpperCase(),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Text(
              '$temp°C',
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
                  '$feelsLike°C',
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
      mainAxisAlignment: .center,
      crossAxisAlignment: .stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.error_outline, size: 64, color: Colors.red),
        const SizedBox(height: 16),
        const Text(
          'Weather Error',
          textAlign: .center,
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
