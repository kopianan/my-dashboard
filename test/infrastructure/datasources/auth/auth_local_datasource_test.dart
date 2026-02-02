import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dartz/dartz.dart';

import 'package:dynamic_dashboard/infrastructure/datasources/auth/auth_local_datasource_impl.dart';
import 'package:dynamic_dashboard/infrastructure/models/user/user_model.dart';
import '../../../helpers/test_helper.dart';

void main() {
  late AuthLocalDataSourceImpl datasource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    datasource = AuthLocalDataSourceImpl(mockSharedPreferences);
  });

  group('AuthLocalDataSource', () {
    final tUserModel = UserModel(
      id: '123',
      email: 'test@example.com',
      name: 'Test User',
    );
    const tToken = 'test_token_123';

    group('saveUser', () {
      test('should call SharedPreferences to save user data', () async {
        // arrange
        when(
          () => mockSharedPreferences.setString(any(), any()),
        ).thenAnswer((_) async => true);

        // act
        final result = await datasource.saveUser(tUserModel);

        // assert
        expect(result, const Right(null));
        verify(() => mockSharedPreferences.setString('user_data', any()));
      });
    });

    group('getUser', () {
      test(
        'should return UserModel from SharedPreferences when there is cached data',
        () async {
          // arrange
          when(() => mockSharedPreferences.getString('user_data')).thenReturn(
            '{"id":"123","email":"test@example.com","name":"Test User"}',
          );

          // act
          final result = await datasource.getUser();

          // assert
          expect(result, Right(tUserModel));
          verify(() => mockSharedPreferences.getString('user_data'));
        },
      );

      test(
        'should return Left when there is no cached data',
        () async {
          // arrange
          when(
            () => mockSharedPreferences.getString('user_data'),
          ).thenReturn(null);

          // act
          final result = await datasource.getUser();

          // assert
          expect(result, const Left('No user data found'));
          verify(() => mockSharedPreferences.getString('user_data'));
        },
      );
    });

    group('saveAuthToken', () {
      test('should call SharedPreferences to save token', () async {
        // arrange
        when(
          () => mockSharedPreferences.setString(any(), any()),
        ).thenAnswer((_) async => true);
        when(
          () => mockSharedPreferences.setBool(any(), any()),
        ).thenAnswer((_) async => true);

        // act
        final result = await datasource.saveAuthToken(tToken);

        // assert
        expect(result, const Right(null));
        verify(() => mockSharedPreferences.setString('auth_token', tToken));
        verify(() => mockSharedPreferences.setBool('is_logged_in', true));
      });
    });

    group('getAuthToken', () {
      test(
        'should return token from SharedPreferences when there is cached token',
        () async {
          // arrange
          when(
            () => mockSharedPreferences.getString('auth_token'),
          ).thenReturn(tToken);

          // act
          final result = await datasource.getAuthToken();

          // assert
          expect(result, Right(tToken));
          verify(() => mockSharedPreferences.getString('auth_token'));
        },
      );

      test(
        'should return Left when there is no cached token',
        () async {
          // arrange
          when(
            () => mockSharedPreferences.getString('auth_token'),
          ).thenReturn(null);

          // act
          final result = await datasource.getAuthToken();

          // assert
          expect(result, const Left('No auth token found'));
          verify(() => mockSharedPreferences.getString('auth_token'));
        },
      );
    });

    group('clearAuthData', () {
      test('should call SharedPreferences to remove cached data', () async {
        // arrange
        when(
          () => mockSharedPreferences.remove(any()),
        ).thenAnswer((_) async => true);
        when(
          () => mockSharedPreferences.setBool(any(), any()),
        ).thenAnswer((_) async => true);

        // act
        final result = await datasource.clearAuthData();

        // assert
        expect(result, const Right(null));
        verify(() => mockSharedPreferences.remove('auth_token'));
        verify(() => mockSharedPreferences.remove('user_data'));
        verify(() => mockSharedPreferences.setBool('is_logged_in', false));
      });
    });
  });
}
