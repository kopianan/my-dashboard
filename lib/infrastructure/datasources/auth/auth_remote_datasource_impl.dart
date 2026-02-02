import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dynamic_dashboard/infrastructure/datasources/auth/auth_remote_datasource.dart';
import 'package:dynamic_dashboard/infrastructure/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<Either<String, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));

      // Basic validation
      if (email.isEmpty || password.isEmpty) {
        return const Left('Email and password are required');
      }

      if (!email.contains('@')) {
        return const Left('Please enter a valid email');
      }

      // Load users from JSON file
      final jsonString = await rootBundle.loadString('assets/json/users.json');
      final List<dynamic> usersJson = json.decode(jsonString) as List<dynamic>;

      // Find user by email
      final userMap =
          usersJson.firstWhere(
                (user) => (user as Map<String, dynamic>)['email'] == email,
                orElse: () => null,
              )
              as Map<String, dynamic>?;

      if (userMap == null) {
        return const Left('User not found. Please check your email.');
      }

      // Check password
      if (userMap['password'] != password) {
        return const Left('Incorrect password. Please try again.');
      }

      // Create UserModel from found user
      final userModel = UserModel(
        id: userMap['id']?.toString() ?? 'user_${email.hashCode}',
        email: email,
        name:
            userMap['name']?.toString() ??
            email
                .split('@')
                .first
                .replaceAll('.', ' ')
                .split(' ')
                .map((word) => word[0].toUpperCase() + word.substring(1))
                .join(' '),
      );

      return Right(userModel);
    } catch (e) {
      if (e is FlutterError) {
        return const Left('Failed to load user data. Please try again.');
      }
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
      await Future.delayed(const Duration(seconds: 1));

      // Basic validation
      if (email.isEmpty || password.isEmpty || name.isEmpty) {
        return const Left('All fields are required');
      }

      if (!email.contains('@')) {
        return const Left('Please enter a valid email');
      }

      if (password.length < 6) {
        return const Left('Password must be at least 6 characters');
      }

      // Load existing users from JSON file to check for duplicates
      try {
        final jsonString = await rootBundle.loadString(
          'assets/json/users.json',
        );
        final List<dynamic> usersJson =
            json.decode(jsonString) as List<dynamic>;

        // Check if user already exists
        final existingUser = usersJson.any(
          (user) => (user as Map<String, dynamic>)['email'] == email,
        );

        if (existingUser) {
          return const Left('User already exists with this email');
        }
      } catch (e) {
        // If JSON file doesn't exist or can't be loaded, continue with registration
      }

      // Mock successful registration response
      final userModel = UserModel(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        name: name,
      );

      return Right(userModel);
    } catch (e) {
      if (e is FlutterError) {
        return const Left('Registration failed. Please try again.');
      }
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
      return Left('Network error during logout: $e');
    }
  }

  @override
  Future<Either<String, void>> forgotPassword({required String email}) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      if (email.isEmpty || !email.contains('@')) {
        return const Left('Please enter a valid email');
      }

      // Mock successful password reset request
      return const Right(null);
    } catch (e) {
      return Left('Network error: $e');
    }
  }
}
