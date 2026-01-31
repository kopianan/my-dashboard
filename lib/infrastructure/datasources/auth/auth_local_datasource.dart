import 'package:dartz/dartz.dart';
import 'package:dynamic_dashboard/infrastructure/models/user/user_model.dart';

abstract class AuthLocalDataSource {
  Future<Either<String, void>> saveAuthToken(String token);
  Future<Either<String, String>> getAuthToken();
  Future<Either<String, void>> deleteAuthToken();
  
  Future<Either<String, void>> saveUser(UserModel user);
  Future<Either<String, UserModel>> getUser();
  Future<Either<String, void>> deleteUser();
  
  Future<Either<String, bool>> isLoggedIn();
  Future<Either<String, void>> clearAuthData();
}