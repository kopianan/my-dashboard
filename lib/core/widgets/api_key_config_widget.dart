import 'package:dynamic_dashboard/core/config/app_config.dart';
import 'package:dynamic_dashboard/injection.dart';
import 'package:flutter/material.dart';

/// Development utility widget to display API key configuration status
/// Only shown in debug mode
class ApiKeyConfigWidget extends StatelessWidget {
  const ApiKeyConfigWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appConfig = getIt<AppConfig>();
    
    // Only show in debug mode
    if (!appConfig.isDebugMode) return const SizedBox.shrink();

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'API Configuration Status',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            _buildStatusRow(
              'OpenWeather API',
              appConfig.openWeatherApiKey.isNotEmpty,
              context,
            ),
            _buildStatusRow(
              'News API',
              appConfig.newsApiKey.isNotEmpty,
              context,
            ),
            _buildStatusRow(
              'Finnhub API',
              appConfig.finnhubApiKey.isNotEmpty,
              context,
            ),
            if (appConfig.missingApiKeys.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Missing: ${appConfig.missingApiKeys.join(', ')}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 12,
                ),
              ),
              const Text(
                'Check your .env file and ensure all API keys are configured.',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(String label, bool isConfigured, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            isConfigured ? Icons.check_circle : Icons.error,
            color: isConfigured 
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.error,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}