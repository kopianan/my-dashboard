import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:dynamic_dashboard/domain/entities/user.dart';
import 'package:dynamic_dashboard/domain/repositories/auth_repository.dart';
import 'package:dynamic_dashboard/infrastructure/datasources/auth/auth_remote_datasource.dart';
import 'package:dynamic_dashboard/infrastructure/datasources/auth/auth_local_datasource.dart';
import 'package:dynamic_dashboard/infrastructure/models/user/user_model.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  const AuthRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<Either<String, User>> login({
    required String email,
    required String password,
  }) async {
    // 1. Call remote API
    final remoteResult = await _remoteDataSource.login(
      email: email,
      password: password,
    );

    return await remoteResult.fold(
      (error) async => Left(error),
      (userModel) async {
        // 2. Save to local storage
        final saveUserResult = await _localDataSource.saveUser(userModel);
        final saveTokenResult = await _localDataSource.saveAuthToken('mock_token_${userModel.id}');

        // Even if local save fails, we still return success since remote succeeded
        if (saveUserResult.isLeft() || saveTokenResult.isLeft()) {
          // Log warning but don't fail the login
        }

        return Right(userModel.toEntity());
      },
    );
  }

  @override
  Future<Either<String, User>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    // 1. Call remote API
    final remoteResult = await _remoteDataSource.register(
      email: email,
      password: password,
      name: name,
    );

    return await remoteResult.fold(
      (error) async => Left(error),
      (userModel) async {
        // 2. Save to local storage after successful registration
        final saveUserResult = await _localDataSource.saveUser(userModel);
        final saveTokenResult = await _localDataSource.saveAuthToken('mock_token_${userModel.id}');

        // Even if local save fails, we still return success since remote succeeded
        if (saveUserResult.isLeft() || saveTokenResult.isLeft()) {
          // Log warning but don't fail the registration
        }

        return Right(userModel.toEntity());
      },
    );
  }

  @override
  Future<Either<String, void>> logout() async {
    // 1. Clear local data first (always works)
    await _localDataSource.clearAuthData();

    // 2. Notify remote server (might fail, but that's ok)
    final remoteResult = await _remoteDataSource.logout();

    // Return success even if remote logout fails
    return const Right(null);
  }

  @override
  Future<Either<String, User>> getCurrentUser() async {
    // Get user from local storage
    final localResult = await _localDataSource.getUser();

    return localResult.fold(
      (error) => Left(error),
      (userModel) => Right(userModel.toEntity()),
    );
  }

  @override
  Future<Either<String, bool>> isLoggedIn() async {
    return await _localDataSource.isLoggedIn();
  }

  @override
  Future<Either<String, void>> forgotPassword({
    required String email,
  }) async {
    return await _remoteDataSource.forgotPassword(email: email);
  }
}