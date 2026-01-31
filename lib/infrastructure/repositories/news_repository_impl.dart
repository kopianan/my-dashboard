import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:dynamic_dashboard/domain/entities/news.dart';
import 'package:dynamic_dashboard/domain/repositories/news_repository.dart';
import 'package:dynamic_dashboard/infrastructure/datasources/news/news_remote_datasource.dart';

@Injectable(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  
  NewsRepositoryImpl(this.remoteDataSource);
  
  @override
  Future<Either<String, NewsResponse>> getTopHeadlines({
    String country = 'au',
    int pageSize = 3,
  }) async {
    try {
      final newsResponseModel = await remoteDataSource.getTopHeadlines(
        country: country,
        pageSize: pageSize,
      );
      
      // Check if the API response indicates success
      if (newsResponseModel.status != 'ok') {
        return Left('News API returned error status: ${newsResponseModel.status}');
      }
      
      // Check if we have articles
      if (newsResponseModel.articles.isEmpty) {
        return Left('No news articles found for the specified criteria');
      }
      
      final newsResponse = newsResponseModel.toDomain();
      return Right(newsResponse);
    } on FormatException catch (e) {
      return Left('Failed to parse news data: ${e.message}');
    } on Exception catch (e) {
      // Handle HTTP errors and other exceptions
      final errorMessage = e.toString();
      if (errorMessage.contains('Failed to fetch news: 401')) {
        return Left('Invalid API key. Please check your NewsAPI configuration.');
      } else if (errorMessage.contains('Failed to fetch news: 429')) {
        return Left('API rate limit exceeded. Please try again later.');
      } else if (errorMessage.contains('Failed to fetch news: 400')) {
        return Left('Invalid request parameters. Please check country code and page size.');
      } else if (errorMessage.contains('Failed to fetch news:')) {
        return Left('Network error: Unable to fetch news data.');
      } else {
        return Left('Unexpected error: ${e.toString()}');
      }
    }
  }
}