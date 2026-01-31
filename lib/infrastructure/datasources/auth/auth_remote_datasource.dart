import 'package:dartz/dartz.dart';
import 'package:dynamic_dashboard/infrastructure/models/user/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<Either<String, UserModel>> login({
    required String email,
    required String password,
  });
  
  Future<Either<String, UserModel>> register({
    required String email,
    required String password,
    required String name,
  });
  
  Future<Either<String, void>> logout();
  
  Future<Either<String, void>> forgotPassword({
    required String email,
  });
}