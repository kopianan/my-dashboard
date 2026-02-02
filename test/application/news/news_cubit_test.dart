import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:dynamic_dashboard/application/news/news_cubit.dart';
import 'package:dynamic_dashboard/domain/repositories/news_repository.dart';
import 'package:dynamic_dashboard/domain/entities/news.dart';

class MockNewsRepository extends Mock implements NewsRepository {}

void main() {
  late NewsCubit newsCubit;
  late MockNewsRepository mockNewsRepository;

  setUp(() {
    mockNewsRepository = MockNewsRepository();
    newsCubit = NewsCubit(mockNewsRepository);
  });

  tearDown(() {
    newsCubit.close();
  });

  final tNewsResponse = NewsResponse(
    status: 'ok',
    totalResults: 2,
    articles: [
      NewsArticle(
        source: const NewsSource(id: null, name: 'BBC News'),
        author: 'BBC Reporter',
        title: 'Test News Title',
        description: 'Test description',
        url: 'https://example.com',
        urlToImage: 'https://example.com/image.jpg',
        publishedAt: DateTime(1970, 1, 1),
        content: 'Test content',
      ),
    ],
  );

  group('NewsCubit', () {
    test('initial state should be NewsState.initial', () {
      expect(newsCubit.state, const NewsState.initial());
    });

    group('getTopHeadlines', () {
      blocTest<NewsCubit, NewsState>(
        'emits [loading, loaded] when getTopHeadlines is successful with default parameters',
        build: () {
          when(
            () => mockNewsRepository.getTopHeadlines(
              country: any(named: 'country'),
              pageSize: any(named: 'pageSize'),
            ),
          ).thenAnswer((_) async => Right(tNewsResponse));
          return newsCubit;
        },
        act: (cubit) => cubit.getTopHeadlines(),
        expect: () => [
          const NewsState.loading(),
          NewsState.loaded(tNewsResponse),
        ],
        verify: (_) {
          verify(
            () =>
                mockNewsRepository.getTopHeadlines(country: 'us', pageSize: 2),
          );
        },
      );

      blocTest<NewsCubit, NewsState>(
        'emits [loading, loaded] when getTopHeadlines is successful with custom parameters',
        build: () {
          when(
            () => mockNewsRepository.getTopHeadlines(
              country: any(named: 'country'),
              pageSize: any(named: 'pageSize'),
            ),
          ).thenAnswer((_) async => Right(tNewsResponse));
          return newsCubit;
        },
        act: (cubit) => cubit.getTopHeadlines(country: 'au', pageSize: 5),
        expect: () => [
          const NewsState.loading(),
          NewsState.loaded(tNewsResponse),
        ],
        verify: (_) {
          verify(
            () =>
                mockNewsRepository.getTopHeadlines(country: 'au', pageSize: 5),
          );
        },
      );

      blocTest<NewsCubit, NewsState>(
        'emits [loading, error] when getTopHeadlines fails',
        build: () {
          when(
            () => mockNewsRepository.getTopHeadlines(
              country: any(named: 'country'),
              pageSize: any(named: 'pageSize'),
            ),
          ).thenAnswer((_) async => const Left('Failed to fetch news'));
          return newsCubit;
        },
        act: (cubit) => cubit.getTopHeadlines(),
        expect: () => [
          const NewsState.loading(),
          const NewsState.error('Failed to fetch news'),
        ],
        verify: (_) {
          verify(
            () =>
                mockNewsRepository.getTopHeadlines(country: 'us', pageSize: 2),
          );
        },
      );

      blocTest<NewsCubit, NewsState>(
        'emits [loading, error] when getTopHeadlines throws an exception',
        build: () {
          when(
            () => mockNewsRepository.getTopHeadlines(
              country: any(named: 'country'),
              pageSize: any(named: 'pageSize'),
            ),
          ).thenThrow(Exception('Network error'));
          return newsCubit;
        },
        act: (cubit) => cubit.getTopHeadlines(),
        expect: () => [
          const NewsState.loading(),
          const NewsState.error('Exception: Network error'),
        ],
        verify: (_) {
          verify(
            () =>
                mockNewsRepository.getTopHeadlines(country: 'us', pageSize: 2),
          );
        },
      );
    });
  });
}
