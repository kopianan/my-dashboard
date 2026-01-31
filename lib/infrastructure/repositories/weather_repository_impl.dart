import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:dynamic_dashboard/domain/entities/weather.dart';
import 'package:dynamic_dashboard/domain/repositories/weather_repository.dart';
import 'package:dynamic_dashboard/infrastructure/datasources/weather/weather_remote_datasource.dart';

@Injectable(as: WeatherRepository)
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  
  WeatherRepositoryImpl(this.remoteDataSource);
  
  @override
  Future<Either<String, Weather>> getCurrentWeather() async {
    try {
      final weatherModel = await remoteDataSource.getCurrentWeather();
      final weather = weatherModel.toDomain();
      return Right(weather);
    } catch (e) {
      return Left('Failed to get current weather: ${e.toString()}');
    }
  }
}