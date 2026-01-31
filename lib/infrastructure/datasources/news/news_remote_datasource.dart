import 'package:dynamic_dashboard/infrastructure/models/news/news_model.dart';

abstract class NewsRemoteDataSource {
  /// Fetch top headlines for Australia
  Future<NewsResponseModel> getTopHeadlines({
    String country = 'au',
    int pageSize = 3,
  });
}