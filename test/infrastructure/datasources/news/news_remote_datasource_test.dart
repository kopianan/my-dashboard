import 'dart:convert';
import 'dart:io';

import 'package:dynamic_dashboard/core/config/app_config.dart';
import 'package:dynamic_dashboard/infrastructure/datasources/news/news_remote_datasource_impl.dart';
import 'package:dynamic_dashboard/infrastructure/models/news/news_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Mock classes
class MockHttpClient extends Mock implements http.Client {}

class MockAppConfig extends Mock implements AppConfig {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class TestData {
  static const newsJson = {
    'status': 'ok',
    'totalResults': 2,
    'articles': [
      {
        'source': {'id': null, 'name': 'BBC News'},
        'author': 'BBC Reporter',
        'title': 'Test News Title',
        'description': 'Test news description content',
        'url': 'https://example.com/news',
        'urlToImage': 'https://example.com/image.jpg',
        'publishedAt': '2023-01-01T12:00:00Z',
        'content': 'Test news content goes here...',
      },
      {
        'source': {'id': 'cnn', 'name': 'CNN'},
        'author': 'CNN Reporter',
        'title': 'Second Test News',
        'description': 'Second test description',
        'url': 'https://example.com/news2',
        'urlToImage': 'https://example.com/image2.jpg',
        'publishedAt': '2023-01-02T15:30:00Z',
        'content': 'Second news content...',
      },
    ],
  };
}

void main() {
  late NewsRemoteDataSourceImpl datasource;
  late MockHttpClient mockHttpClient;
  late MockAppConfig mockAppConfig;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockAppConfig = MockAppConfig();
    mockSharedPreferences = MockSharedPreferences();

    when(
      () => mockAppConfig.newsApiBaseUrl,
    ).thenReturn('https://newsapi.org/v2');
    when(() => mockAppConfig.newsApiKey).thenReturn('fake-test-api-key');
    when(() => mockSharedPreferences.getString(any())).thenReturn('au');

    datasource = NewsRemoteDataSourceImpl(mockHttpClient, mockAppConfig);
  });

  group('NewsRemoteDataSource', () {
    const tUrl =
        'https://newsapi.org/v2/top-headlines?country=au&apiKey=fake-test-api-key&pageSize=3';

    test(
      'should return NewsResponseModel when the response code is 200',
      () async {
        // arrange
        when(
          () => mockHttpClient.get(
            Uri.parse(tUrl),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer(
          (_) async => http.Response(json.encode(TestData.newsJson), 200),
        );

        // act
        final result = await datasource.getTopHeadlines(country: 'au');

        // assert
        expect(result, isA<NewsResponseModel>());
        expect(result.status, 'ok');
        expect(result.totalResults, 2);
        expect(result.articles.length, 2);
        expect(result.articles.first.title, 'Test News Title');
        expect(result.articles.first.source.name, 'BBC News');
        verify(
          () => mockHttpClient.get(
            Uri.parse(tUrl),
            headers: any(named: 'headers'),
          ),
        );
      },
    );

    test('should return NewsResponseModel with custom parameters', () async {
      // arrange
      const customUrl =
          'https://newsapi.org/v2/top-headlines?country=us&apiKey=fake-test-api-key&pageSize=5';

      when(
        () => mockHttpClient.get(
          Uri.parse(customUrl),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(json.encode(TestData.newsJson), 200),
      );

      // act
      final result = await datasource.getTopHeadlines(
        country: 'us',
        pageSize: 5,
      );

      // assert
      expect(result, isA<NewsResponseModel>());
      expect(result.status, 'ok');
      verify(
        () => mockHttpClient.get(
          Uri.parse(customUrl),
          headers: any(named: 'headers'),
        ),
      );
    });

    test(
      'should throw Exception when the response code is 404 or other',
      () async {
        // arrange
        when(
          () => mockHttpClient.get(
            Uri.parse(tUrl),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => http.Response('Not found', 404));

        // act
        final call = datasource.getTopHeadlines(country: 'au');

        // assert
        expect(() => call, throwsA(isA<Exception>()));
        verify(
          () => mockHttpClient.get(
            Uri.parse(tUrl),
            headers: any(named: 'headers'),
          ),
        );
      },
    );

    test('should throw Exception when there is a network error', () async {
      // arrange
      when(
        () =>
            mockHttpClient.get(Uri.parse(tUrl), headers: any(named: 'headers')),
      ).thenThrow(const SocketException('No Internet connection'));

      // act
      final call = datasource.getTopHeadlines(country: 'au');

      // assert
      expect(() => call, throwsA(isA<SocketException>()));
      verify(
        () =>
            mockHttpClient.get(Uri.parse(tUrl), headers: any(named: 'headers')),
      );
    });

    test('should handle malformed JSON response', () async {
      // arrange
      when(
        () =>
            mockHttpClient.get(Uri.parse(tUrl), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response('invalid json', 200));

      // act
      final call = datasource.getTopHeadlines(country: 'au');

      // assert
      expect(() => call, throwsA(isA<FormatException>()));
      verify(
        () =>
            mockHttpClient.get(Uri.parse(tUrl), headers: any(named: 'headers')),
      );
    });

    test('should handle response with empty articles array', () async {
      // arrange
      final emptyNewsJson = {'status': 'ok', 'totalResults': 0, 'articles': []};

      when(
        () =>
            mockHttpClient.get(Uri.parse(tUrl), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response(json.encode(emptyNewsJson), 200));

      // act
      final result = await datasource.getTopHeadlines(country: 'au');

      // assert
      expect(result, isA<NewsResponseModel>());
      expect(result.status, 'ok');
      expect(result.totalResults, 0);
      expect(result.articles, isEmpty);
      verify(
        () =>
            mockHttpClient.get(Uri.parse(tUrl), headers: any(named: 'headers')),
      );
    });
  });
}
