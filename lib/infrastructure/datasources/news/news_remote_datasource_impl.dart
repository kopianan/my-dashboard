import 'dart:convert';

import 'package:dynamic_dashboard/infrastructure/datasources/news/news_remote_datasource.dart';
import 'package:dynamic_dashboard/infrastructure/models/news/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@Injectable(as: NewsRemoteDataSource)
class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  NewsRemoteDataSourceImpl(this.client);
  final http.Client client;

  static const String _apiKey = 'c386cc39b83d4021b732dcad942f74e9';
  static const String _baseUrl = 'https://newsapi.org/v2';

  @override
  Future<NewsResponseModel> getTopHeadlines({
    String country = 'au',
    int pageSize = 3,
  }) async {
    final url =
        '$_baseUrl/top-headlines?country=$country&apiKey=$_apiKey&pageSize=$pageSize';

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
