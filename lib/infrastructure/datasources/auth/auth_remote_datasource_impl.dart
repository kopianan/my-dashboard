import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:dynamic_dashboard/infrastructure/datasources/auth/auth_remote_datasource.dart';
import 'package:dynamic_dashboard/infrastructure/models/user/user_model.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<Either<String, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock validation - in real app, this would be an API call
      if (email.isEmpty || password.isEmpty) {
        return const Left('Email and password are required');
      }
      
      if (password.length < 6) {
        return const Left('Password must be at least 6 characters');
      }
      
      if (!email.contains('@')) {
        return const Left('Please enter a valid email');
      }
      
      // Mock successful login response from API
      final userModel = UserModel(
        id: 'user_123',
        email: email,
        name: email.split('@').first.replaceAll('.', ' ').split(' ')
            .map((word) => word[0].toUpperCase() + word.substring(1))
            .join(' '),
      );
      
      return Right(userModel);
    } catch (e) {
      return Left('Network error: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, UserModel>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock validation
      if (email.isEmpty || password.isEmpty || name.isEmpty) {
        return const Left('All fields are required');
      }
      
      if (!email.contains('@')) {
        return const Left('Please enter a valid email');
      }
      
      if (password.length < 6) {
        return const Left('Password must be at least 6 characters');
      }
      
      // Mock successful registration response from API
      final userModel = UserModel(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        name: name,
      );
      
      return Right(userModel);
    } catch (e) {
      return Left('Network error: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> logout() async {
    try {
      // Simulate API call to notify server of logout
      await Future.delayed(const Duration(milliseconds: 500));
      
      // In real app, invalidate server-side session
      return const Right(null);
    } catch (e) {
      return Left('Network error during logout: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> forgotPassword({
    required String email,
  }) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      if (email.isEmpty || !email.contains('@')) {
        return const Left('Please enter a valid email');
      }
      
      // Mock successful password reset request
      return const Right(null);
    } catch (e) {
      return Left('Network error: ${e.toString()}');
    }
  }
}