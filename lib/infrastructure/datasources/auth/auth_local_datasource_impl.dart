import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dynamic_dashboard/infrastructure/datasources/auth/auth_local_datasource.dart';
import 'package:dynamic_dashboard/infrastructure/models/user/user_model.dart';

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences _prefs;
  
  static const String _authTokenKey = 'auth_token';
  static const String _userKey = 'user_data';
  static const String _isLoggedInKey = 'is_logged_in';

  const AuthLocalDataSourceImpl(this._prefs);

  @override
  Future<Either<String, void>> saveAuthToken(String token) async {
    try {
      await _prefs.setString(_authTokenKey, token);
      await _prefs.setBool(_isLoggedInKey, true);
      return const Right(null);
    } catch (e) {
      return Left('Failed to save auth token: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, String>> getAuthToken() async {
    try {
      final token = _prefs.getString(_authTokenKey);
      
      if (token == null || token.isEmpty) {
        return const Left('No auth token found');
      }
      
      return Right(token);
    } catch (e) {
      return Left('Failed to get auth token: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> deleteAuthToken() async {
    try {
      await _prefs.remove(_authTokenKey);
      await _prefs.setBool(_isLoggedInKey, false);
      return const Right(null);
    } catch (e) {
      return Left('Failed to delete auth token: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> saveUser(UserModel user) async {
    try {
      final userJson = jsonEncode(user.toJson());
      await _prefs.setString(_userKey, userJson);
      return const Right(null);
    } catch (e) {
      return Left('Failed to save user data: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, UserModel>> getUser() async {
    try {
      final userJson = _prefs.getString(_userKey);
      
      if (userJson == null || userJson.isEmpty) {
        return const Left('No user data found');
      }
      
      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      final user = UserModel.fromJson(userMap);
      
      return Right(user);
    } catch (e) {
      return Left('Failed to get user data: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> deleteUser() async {
    try {
      await _prefs.remove(_userKey);
      return const Right(null);
    } catch (e) {
      return Left('Failed to delete user data: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, bool>> isLoggedIn() async {
    try {
      final isLoggedIn = _prefs.getBool(_isLoggedInKey) ?? false;
      
      // Additional check: verify we have both token and user data
      if (isLoggedIn) {
        final hasToken = _prefs.getString(_authTokenKey) != null;
        final hasUser = _prefs.getString(_userKey) != null;
        
        if (!hasToken || !hasUser) {
          // Data is inconsistent, clear everything
          await clearAuthData();
          return const Right(false);
        }
      }
      
      return Right(isLoggedIn);
    } catch (e) {
      return Left('Failed to check login status: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> clearAuthData() async {
    try {
      await Future.wait([
        _prefs.remove(_authTokenKey),
        _prefs.remove(_userKey),
        _prefs.setBool(_isLoggedInKey, false),
      ]);
      return const Right(null);
    } catch (e) {
      return Left('Failed to clear auth data: ${e.toString()}');
    }
  }
}