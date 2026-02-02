import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// Mock classes for testing
class MockHttpClient extends Mock implements http.Client {}
class MockSharedPreferences extends Mock implements SharedPreferences {}
class MockWebSocketChannel extends Mock implements WebSocketChannel {}
class MockWebSocketSink extends Mock implements WebSocketSink {}
class MockStream<T> extends Mock implements Stream<T> {}

// Test data helpers
class TestData {
  // Stock price test data
  static const stockPriceJson = {
    'data': [
      {
        'c': null,
        'p': 16824.89,
        's': 'BTCUSDT', 
        't': 1672515782136,
        'v': 0.61500000
      }
    ],
    'type': 'trade'
  };

  // Weather test data
  static const weatherJson = {
    'coord': {'lon': -122.08, 'lat': 37.39},
    'weather': [
      {'id': 800, 'main': 'Clear', 'description': 'clear sky', 'icon': '01d'}
    ],
    'base': 'stations',
    'main': {
      'temp': 282.55,
      'feels_like': 281.86,
      'temp_min': 280.37,
      'temp_max': 284.26,
      'pressure': 1023,
      'humidity': 100
    },
    'visibility': 16093,
    'wind': {'speed': 1.5, 'deg': 350},
    'clouds': {'all': 1},
    'dt': 1560350645,
    'sys': {
      'type': 1,
      'id': 5122,
      'country': 'US',
      'sunrise': 1560343627,
      'sunset': 1560396563
    },
    'timezone': -25200,
    'id': 420006353,
    'name': 'Mountain View',
    'cod': 200
  };

  // News test data
  static const newsJson = {
    'status': 'ok',
    'totalResults': 2,
    'articles': [
      {
        'source': {'id': null, 'name': 'BBC News'},
        'author': 'BBC',
        'title': 'Test News Title',
        'description': 'Test news description',
        'url': 'https://example.com',
        'urlToImage': 'https://example.com/image.jpg',
        'publishedAt': '2023-01-01T12:00:00Z',
        'content': 'Test content'
      }
    ]
  };

  // Auth test data
  static const authLoginJson = {
    'user': {
      'id': '123',
      'email': 'test@example.com',
      'name': 'Test User'
    },
    'token': 'test_token_123'
  };
}

// Helper functions
class TestHelper {
  static void setupHttpMockResponse(
    MockHttpClient mockClient,
    String url,
    Map<String, dynamic> responseBody, {
    int statusCode = 200,
  }) {
    when(() => mockClient.get(Uri.parse(url)))
        .thenAnswer((_) async => http.Response(
              responseBody.toString(),
              statusCode,
            ));
  }

  static void setupHttpMockPost(
    MockHttpClient mockClient,
    String url,
    Map<String, dynamic> responseBody, {
    int statusCode = 200,
    Map<String, String>? headers,
  }) {
    when(() => mockClient.post(
          Uri.parse(url),
          headers: headers ?? any(named: 'headers'),
          body: any(named: 'body'),
        )).thenAnswer((_) async => http.Response(
          responseBody.toString(),
          statusCode,
        ));
  }

  static void setupSharedPrefsGetString(
    MockSharedPreferences mockPrefs,
    String key,
    String? value,
  ) {
    when(() => mockPrefs.getString(key)).thenReturn(value);
  }

  static void setupSharedPrefsSetString(
    MockSharedPreferences mockPrefs,
    String key,
    bool result,
  ) {
    when(() => mockPrefs.setString(key, any())).thenAnswer((_) async => result);
  }
}