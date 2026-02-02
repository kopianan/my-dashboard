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
    required String title, required String url, required DateTime publishedAt, String? author,
    String? description,
    String? urlToImage,
    String? content,
  }) = _NewsArticle;
}

@freezed
abstract class NewsSource with _$NewsSource {
  const factory NewsSource({
    required String name, String? id,
  }) = _NewsSource;
}