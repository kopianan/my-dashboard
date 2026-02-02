// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NewsResponseModel _$NewsResponseModelFromJson(Map<String, dynamic> json) =>
    _NewsResponseModel(
      status: json['status'] as String,
      totalResults: (json['totalResults'] as num).toInt(),
      articles: (json['articles'] as List<dynamic>)
          .map((e) => NewsArticleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NewsResponseModelToJson(_NewsResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'articles': instance.articles,
    };

_NewsArticleModel _$NewsArticleModelFromJson(Map<String, dynamic> json) =>
    _NewsArticleModel(
      source: NewsSourceModel.fromJson(json['source'] as Map<String, dynamic>),
      title: json['title'] as String,
      url: json['url'] as String,
      publishedAt: json['publishedAt'] as String,
      author: json['author'] as String?,
      description: json['description'] as String?,
      urlToImage: json['urlToImage'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$NewsArticleModelToJson(_NewsArticleModel instance) =>
    <String, dynamic>{
      'source': instance.source,
      'title': instance.title,
      'url': instance.url,
      'publishedAt': instance.publishedAt,
      'author': instance.author,
      'description': instance.description,
      'urlToImage': instance.urlToImage,
      'content': instance.content,
    };

_NewsSourceModel _$NewsSourceModelFromJson(Map<String, dynamic> json) =>
    _NewsSourceModel(name: json['name'] as String, id: json['id'] as String?);

Map<String, dynamic> _$NewsSourceModelToJson(_NewsSourceModel instance) =>
    <String, dynamic>{'name': instance.name, 'id': instance.id};
