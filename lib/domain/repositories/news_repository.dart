import 'package:dartz/dartz.dart';
import 'package:dynamic_dashboard/domain/entities/news.dart';

abstract class NewsRepository {
  /// Fetch top headlines for specified country
  Future<Either<String, NewsResponse>> getTopHeadlines({
    required String country,
    int pageSize = 3,
  });
}
