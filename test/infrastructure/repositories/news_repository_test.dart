import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:dynamic_dashboard/infrastructure/repositories/news_repository_impl.dart';
import 'package:dynamic_dashboard/infrastructure/datasources/news/news_remote_datasource.dart';
import 'package:dynamic_dashboard/infrastructure/models/news/news_model.dart';
import 'package:dynamic_dashboard/domain/entities/news.dart';

class MockNewsRemoteDataSource extends Mock implements NewsRemoteDataSource {}

void main() {
  late NewsRepositoryImpl repository;
  late MockNewsRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockNewsRemoteDataSource();
    repository = NewsRepositoryImpl(mockRemoteDataSource);
  });

  group('getTopHeadlines', () {
    final tNewsResponseModel = NewsResponseModel(
      status: 'ok',
      totalResults: 2,
      articles: [
        NewsArticleModel(
          source: NewsSourceModel(id: null, name: 'BBC News'),
          author: 'BBC Reporter',
          title: 'Test News Title',
          description: 'Test description',
          url: 'https://example.com',
          urlToImage: 'https://example.com/image.jpg',
          publishedAt: '2023-01-01T12:00:00Z',
          content: 'Test content',
        ),
      ],
    );

    final tNewsResponse = NewsResponse(
      status: 'ok',
      totalResults: 2,
      articles: [
        NewsArticle(
          source: NewsSource(id: null, name: 'BBC News'),
          author: 'BBC Reporter',
          title: 'Test News Title',
          description: 'Test description',
          url: 'https://example.com',
          urlToImage: 'https://example.com/image.jpg',
          publishedAt: DateTime.parse('2023-01-01T12:00:00Z'),
          content: 'Test content',
        ),
      ],
    );

    test(
      'should return NewsResponse when call to remote data source is successful',
      () async {
        // arrange
        when(() => mockRemoteDataSource.getTopHeadlines())
            .thenAnswer((_) async => tNewsResponseModel);

        // act
        final result = await repository.getTopHeadlines();

        // assert
        expect(result, Right(tNewsResponse));
        verify(() => mockRemoteDataSource.getTopHeadlines());
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should return NewsResponse with custom parameters',
      () async {
        // arrange
        when(() => mockRemoteDataSource.getTopHeadlines(
              country: 'us',
              pageSize: 5,
            )).thenAnswer((_) async => tNewsResponseModel);

        // act
        final result = await repository.getTopHeadlines(
          country: 'us',
          pageSize: 5,
        );

        // assert
        expect(result, isA<Right<String, NewsResponse>>());
        verify(() => mockRemoteDataSource.getTopHeadlines(
              country: 'us',
              pageSize: 5,
            ));
      },
    );

    test(
      'should return Left when API returns non-ok status',
      () async {
        // arrange
        final errorResponseModel = NewsResponseModel(
          status: 'error',
          totalResults: 0,
          articles: [],
        );
        
        when(() => mockRemoteDataSource.getTopHeadlines())
            .thenAnswer((_) async => errorResponseModel);

        // act
        final result = await repository.getTopHeadlines();

        // assert
        expect(result, const Left('News API returned error status: error'));
        verify(() => mockRemoteDataSource.getTopHeadlines());
      },
    );

    test(
      'should return Left when no articles are found',
      () async {
        // arrange
        final emptyResponseModel = NewsResponseModel(
          status: 'ok',
          totalResults: 0,
          articles: [],
        );
        
        when(() => mockRemoteDataSource.getTopHeadlines())
            .thenAnswer((_) async => emptyResponseModel);

        // act
        final result = await repository.getTopHeadlines();

        // assert
        expect(result, const Left('No news articles found for the specified criteria'));
        verify(() => mockRemoteDataSource.getTopHeadlines());
      },
    );

    test(
      'should return Left with API key error when 401 exception occurs',
      () async {
        // arrange
        when(() => mockRemoteDataSource.getTopHeadlines())
            .thenThrow(Exception('Failed to fetch news: 401'));

        // act
        final result = await repository.getTopHeadlines();

        // assert
        expect(result, const Left('Invalid API key. Please check your NewsAPI configuration.'));
        verify(() => mockRemoteDataSource.getTopHeadlines());
      },
    );

    test(
      'should return Left with rate limit error when 429 exception occurs',
      () async {
        // arrange
        when(() => mockRemoteDataSource.getTopHeadlines())
            .thenThrow(Exception('Failed to fetch news: 429'));

        // act
        final result = await repository.getTopHeadlines();

        // assert
        expect(result, const Left('API rate limit exceeded. Please try again later.'));
        verify(() => mockRemoteDataSource.getTopHeadlines());
      },
    );

    test(
      'should return Left with parameter error when 400 exception occurs',
      () async {
        // arrange
        when(() => mockRemoteDataSource.getTopHeadlines())
            .thenThrow(Exception('Failed to fetch news: 400'));

        // act
        final result = await repository.getTopHeadlines();

        // assert
        expect(result, const Left('Invalid request parameters. Please check country code and page size.'));
        verify(() => mockRemoteDataSource.getTopHeadlines());
      },
    );

    test(
      'should return Left with parse error when FormatException occurs',
      () async {
        // arrange
        when(() => mockRemoteDataSource.getTopHeadlines())
            .thenThrow(const FormatException('Invalid JSON'));

        // act
        final result = await repository.getTopHeadlines();

        // assert
        expect(result, const Left('Failed to parse news data: Invalid JSON'));
        verify(() => mockRemoteDataSource.getTopHeadlines());
      },
    );

    test(
      'should return Left with network error for general HTTP exceptions',
      () async {
        // arrange
        when(() => mockRemoteDataSource.getTopHeadlines())
            .thenThrow(Exception('Failed to fetch news: 500'));

        // act
        final result = await repository.getTopHeadlines();

        // assert
        expect(result, const Left('Network error: Unable to fetch news data.'));
        verify(() => mockRemoteDataSource.getTopHeadlines());
      },
    );

    test(
      'should return Left with unexpected error for other exceptions',
      () async {
        // arrange
        when(() => mockRemoteDataSource.getTopHeadlines())
            .thenThrow(Exception('Some unexpected error'));

        // act
        final result = await repository.getTopHeadlines();

        // assert
        expect(result, const Left('Unexpected error: Exception: Some unexpected error'));
        verify(() => mockRemoteDataSource.getTopHeadlines());
      },
    );
  });
}