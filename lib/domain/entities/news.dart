import 'package:freezed_annotation/freezed_annotation.dart';

part 'news.freezed.dart';

@freezed
abstract class NewsResponse with _$NewsResponse {
  const factory NewsResponse({
    required String status,
    required int totalResults,
    required List<NewsArticle> articles,
  }) = _NewsResponse;
}

@freezed
abstract class NewsArticle with _$NewsArticle {
  const factory NewsArticle({
    required NewsSource source,
    String? author,
    required String title,
    String? description,
    required String url,
    String? urlToImage,
    required DateTime publishedAt,
    String? content,
  }) = _NewsArticle;
}

@freezed
abstract class NewsSource with _$NewsSource {
  const factory NewsSource({
    String? id,
    required String name,
  }) = _NewsSource;
}