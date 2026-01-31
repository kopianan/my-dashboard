import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:dynamic_dashboard/infrastructure/datasources/news/news_remote_datasource.dart';
import 'package:dynamic_dashboard/infrastructure/models/news/news_model.dart';

@Injectable(as: NewsRemoteDataSource)
class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client;
  
  static const String _apiKey = 'c386cc39b83d4021b732dcad942f74e9';
  static const String _baseUrl = 'https://newsapi.org/v2';
  
  NewsRemoteDataSourceImpl(this.client);
  
  @override
  Future<NewsResponseModel> getTopHeadlines({
    String country = 'au',
    int pageSize = 3,
  }) async {
    final url = '$_baseUrl/top-headlines?country=$country&apiKey=$_apiKey&pageSize=$pageSize';
    
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return NewsResponseModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to fetch news: ${response.statusCode}');
    }
  }
}