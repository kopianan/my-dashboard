import 'package:dynamic_dashboard/domain/entities/news.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_model.freezed.dart';
part 'news_model.g.dart';

@freezed
abstract class NewsResponseModel with _$NewsResponseModel {
  const factory NewsResponseModel({
    required String status,
    required int totalResults,
    required List<NewsArticleModel> articles,
  }) = _NewsResponseModel;

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$NewsResponseModelFromJson(json);

  const NewsResponseModel._();

  NewsResponse toDomain() {
    return NewsResponse(
      status: status,
      totalResults: totalResults,
      articles: articles.map((article) => article.toDomain()).toList(),
    );
  }
}

@freezed
abstract class NewsArticleModel with _$NewsArticleModel {
  const factory NewsArticleModel({
    required NewsSourceModel source,
    String? author,
    required String title,
    String? description,
    required String url,
    String? urlToImage,
    required String publishedAt,
    String? content,
  }) = _NewsArticleModel;

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) =>
      _$NewsArticleModelFromJson(json);

  const NewsArticleModel._();

  NewsArticle toDomain() {
    return NewsArticle(
      source: source.toDomain(),
      author: author,
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      publishedAt: DateTime.parse(publishedAt),
      content: content,
    );
  }
}

@freezed
abstract class NewsSourceModel with _$NewsSourceModel {
  const factory NewsSourceModel({String? id, required String name}) =
      _NewsSourceModel;

  factory NewsSourceModel.fromJson(Map<String, dynamic> json) =>
      _$NewsSourceModelFromJson(json);

  const NewsSourceModel._();

  NewsSource toDomain() {
    return NewsSource(id: id, name: name);
  }
}
