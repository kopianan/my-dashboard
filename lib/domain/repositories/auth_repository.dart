import 'package:dartz/dartz.dart';
import 'package:dynamic_dashboard/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<String, User>> login({
    required String email,
    required String password,
  });
  
  Future<Either<String, void>> logout();
  
  Future<Either<String, User>> register({
    required String email,
    required String password,
    required String name,
  });
  
  Future<Either<String, User>> getCurrentUser();
  
  Future<Either<String, bool>> isLoggedIn();
  
  Future<Either<String, void>> forgotPassword({
    required String email,
  });
}