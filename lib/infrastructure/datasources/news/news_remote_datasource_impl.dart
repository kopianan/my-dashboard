import 'dart:convert';

import 'package:dynamic_dashboard/core/config/app_config.dart';
import 'package:dynamic_dashboard/infrastructure/datasources/news/news_remote_datasource.dart';
import 'package:dynamic_dashboard/infrastructure/models/news/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@Injectable(as: NewsRemoteDataSource)
class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  NewsRemoteDataSourceImpl(this.client, this.appConfig);
  final http.Client client;
  final AppConfig appConfig;


  @override
  Future<NewsResponseModel> getTopHeadlines({
    String country = 'au',
    int pageSize = 3,
  }) async {
    final url =
        '${appConfig.newsApiBaseUrl}/top-headlines?country=$country&apiKey=${appConfig.newsApiKey}&pageSize=$pageSize';

    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      return NewsResponseModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to fetch news: ${response.statusCode}');
    }
  }
}
