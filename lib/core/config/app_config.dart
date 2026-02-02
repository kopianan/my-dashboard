import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AppConfig {
  AppConfig();

  // API Keys
  String get openWeatherApiKey => dotenv.env['OPENWEATHER_API_KEY'] ?? '';
  String get newsApiKey => dotenv.env['NEWS_API_KEY'] ?? '';
  String get finnhubApiKey => dotenv.env['FINNHUB_API_KEY'] ?? '';

  // API Base URLs
  String get openWeatherBaseUrl =>
      dotenv.env['OPENWEATHER_BASE_URL'] ?? 'https://api.openweathermap.org/data/2.5';
  String get newsApiBaseUrl =>
      dotenv.env['NEWS_API_BASE_URL'] ?? 'https://newsapi.org/v2';
  String get finnhubWsUrl =>
      dotenv.env['FINNHUB_WS_URL'] ?? 'wss://ws.finnhub.io';

  // App Configuration
  String get appName => dotenv.env['APP_NAME'] ?? 'Dynamic Dashboard';
  String get appVersion => dotenv.env['APP_VERSION'] ?? '1.0.0';
  bool get isDebugMode => dotenv.env['DEBUG_MODE']?.toLowerCase() == 'true';

  // Validation methods
  bool get hasValidApiKeys => 
      openWeatherApiKey.isNotEmpty && 
      newsApiKey.isNotEmpty && 
      finnhubApiKey.isNotEmpty;

  List<String> get missingApiKeys {
    final missing = <String>[];
    if (openWeatherApiKey.isEmpty) missing.add('OPENWEATHER_API_KEY');
    if (newsApiKey.isEmpty) missing.add('NEWS_API_KEY');
    if (finnhubApiKey.isEmpty) missing.add('FINNHUB_API_KEY');
    return missing;
  }

  // Constructed URLs
  String get finnhubWsUrlWithToken => '$finnhubWsUrl?token=$finnhubApiKey';

  void validateConfiguration() {
    if (!hasValidApiKeys) {
      throw Exception(
        'Missing required API keys: ${missingApiKeys.join(', ')}. '
        'Please check your .env file.',
      );
    }
  }

  @override
  String toString() {
    return 'AppConfig('
        'appName: $appName, '
        'appVersion: $appVersion, '
        'isDebugMode: $isDebugMode, '
        'hasValidApiKeys: $hasValidApiKeys'
        ')';
  }
}