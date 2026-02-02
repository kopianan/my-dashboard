import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:dynamic_dashboard/infrastructure/repositories/auth_repository_impl.dart';
import 'package:dynamic_dashboard/infrastructure/datasources/auth/auth_remote_datasource.dart';
import 'package:dynamic_dashboard/infrastructure/datasources/auth/auth_local_datasource.dart';
import 'package:dynamic_dashboard/infrastructure/models/user/user_model.dart';
import 'package:dynamic_dashboard/domain/entities/user.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}
class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

// Fake classes for mocktail
class FakeUserModel extends Fake implements UserModel {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(FakeUserModel());
  });

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(mockRemoteDataSource, mockLocalDataSource);
  });

  group('login', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    
    final tUserModel = UserModel(
      id: '123',
      email: tEmail,
      name: 'Test User',
    );
    
    final tUser = User(
      id: '123',
      email: tEmail,
      name: 'Test User',
    );

    test(
      'should return User when login is successful and data is saved locally',
      () async {
        // arrange
        when(() => mockRemoteDataSource.login(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => Right(tUserModel));
        
        when(() => mockLocalDataSource.saveUser(any()))
            .thenAnswer((_) async => const Right(null));
        when(() => mockLocalDataSource.saveAuthToken(any()))
            .thenAnswer((_) async => const Right(null));

        // act
        final result = await repository.login(email: tEmail, password: tPassword);

        // assert
        expect(result, Right(tUser));
        verify(() => mockRemoteDataSource.login(email: tEmail, password: tPassword));
        verify(() => mockLocalDataSource.saveUser(tUserModel));
        verify(() => mockLocalDataSource.saveAuthToken('mock_token_123'));
      },
    );

    test(
      'should return User when login is successful even if local save fails',
      () async {
        // arrange
        when(() => mockRemoteDataSource.login(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => Right(tUserModel));
        
        when(() => mockLocalDataSource.saveUser(any()))
            .thenAnswer((_) async => const Left('Save failed'));
        when(() => mockLocalDataSource.saveAuthToken(any()))
            .thenAnswer((_) async => const Right(null));

        // act
        final result = await repository.login(email: tEmail, password: tPassword);

        // assert
        expect(result, Right(tUser));
        verify(() => mockRemoteDataSource.login(email: tEmail, password: tPassword));
      },
    );

    test(
      'should return Left when remote login fails',
      () async {
        // arrange
        when(() => mockRemoteDataSource.login(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => const Left('Invalid credentials'));

        // act
        final result = await repository.login(email: tEmail, password: tPassword);

        // assert
        expect(result, const Left('Invalid credentials'));
        verify(() => mockRemoteDataSource.login(email: tEmail, password: tPassword));
        verifyNever(() => mockLocalDataSource.saveUser(any()));
        verifyNever(() => mockLocalDataSource.saveAuthToken(any()));
      },
    );
  });

  group('register', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    const tName = 'Test User';
    
    final tUserModel = UserModel(
      id: '123',
      email: tEmail,
      name: tName,
    );
    
    final tUser = User(
      id: '123',
      email: tEmail,
      name: tName,
    );

    test(
      'should return User when registration is successful',
      () async {
        // arrange
        when(() => mockRemoteDataSource.register(
              email: any(named: 'email'),
              password: any(named: 'password'),
              name: any(named: 'name'),
            )).thenAnswer((_) async => Right(tUserModel));
        
        when(() => mockLocalDataSource.saveUser(any()))
            .thenAnswer((_) async => const Right(null));
        when(() => mockLocalDataSource.saveAuthToken(any()))
            .thenAnswer((_) async => const Right(null));

        // act
        final result = await repository.register(
          email: tEmail,
          password: tPassword,
          name: tName,
        );

        // assert
        expect(result, Right(tUser));
        verify(() => mockRemoteDataSource.register(
              email: tEmail,
              password: tPassword,
              name: tName,
            ));
        verify(() => mockLocalDataSource.saveUser(tUserModel));
        verify(() => mockLocalDataSource.saveAuthToken('mock_token_123'));
      },
    );

    test(
      'should return Left when remote registration fails',
      () async {
        // arrange
        when(() => mockRemoteDataSource.register(
              email: any(named: 'email'),
              password: any(named: 'password'),
              name: any(named: 'name'),
            )).thenAnswer((_) async => const Left('Email already exists'));

        // act
        final result = await repository.register(
          email: tEmail,
          password: tPassword,
          name: tName,
        );

        // assert
        expect(result, const Left('Email already exists'));
        verifyNever(() => mockLocalDataSource.saveUser(any()));
      },
    );
  });

  group('logout', () {
    test(
      'should return Right when logout is successful',
      () async {
        // arrange
        when(() => mockLocalDataSource.clearAuthData())
            .thenAnswer((_) async => const Right(null));
        when(() => mockRemoteDataSource.logout())
            .thenAnswer((_) async => const Right(null));

        // act
        final result = await repository.logout();

        // assert
        expect(result, const Right(null));
        verify(() => mockLocalDataSource.clearAuthData());
        verify(() => mockRemoteDataSource.logout());
      },
    );

    test(
      'should return Right even when remote logout fails',
      () async {
        // arrange
        when(() => mockLocalDataSource.clearAuthData())
            .thenAnswer((_) async => const Right(null));
        when(() => mockRemoteDataSource.logout())
            .thenAnswer((_) async => const Left('Server error'));

        // act
        final result = await repository.logout();

        // assert
        expect(result, const Right(null));
        verify(() => mockLocalDataSource.clearAuthData());
        verify(() => mockRemoteDataSource.logout());
      },
    );
  });

  group('getCurrentUser', () {
    final tUserModel = UserModel(
      id: '123',
      email: 'test@example.com',
      name: 'Test User',
    );
    
    final tUser = User(
      id: '123',
      email: 'test@example.com',
      name: 'Test User',
    );

    test(
      'should return User when local data source has cached user',
      () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => Right(tUserModel));

        // act
        final result = await repository.getCurrentUser();

        // assert
        expect(result, Right(tUser));
        verify(() => mockLocalDataSource.getUser());
      },
    );

    test(
      'should return Left when no user is cached locally',
      () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => const Left('No user data found'));

        // act
        final result = await repository.getCurrentUser();

        // assert
        expect(result, const Left('No user data found'));
        verify(() => mockLocalDataSource.getUser());
      },
    );
  });

  group('isLoggedIn', () {
    test(
      'should return true when user is logged in',
      () async {
        // arrange
        when(() => mockLocalDataSource.isLoggedIn())
            .thenAnswer((_) async => const Right(true));

        // act
        final result = await repository.isLoggedIn();

        // assert
        expect(result, const Right(true));
        verify(() => mockLocalDataSource.isLoggedIn());
      },
    );

    test(
      'should return false when user is not logged in',
      () async {
        // arrange
        when(() => mockLocalDataSource.isLoggedIn())
            .thenAnswer((_) async => const Right(false));

        // act
        final result = await repository.isLoggedIn();

        // assert
        expect(result, const Right(false));
        verify(() => mockLocalDataSource.isLoggedIn());
      },
    );

    test(
      'should return Left when checking login status fails',
      () async {
        // arrange
        when(() => mockLocalDataSource.isLoggedIn())
            .thenAnswer((_) async => const Left('Error checking login status'));

        // act
        final result = await repository.isLoggedIn();

        // assert
        expect(result, const Left('Error checking login status'));
        verify(() => mockLocalDataSource.isLoggedIn());
      },
    );
  });

  group('forgotPassword', () {
    const tEmail = 'test@example.com';

    test(
      'should return Right when forgot password is successful',
      () async {
        // arrange
        when(() => mockRemoteDataSource.forgotPassword(email: any(named: 'email')))
            .thenAnswer((_) async => const Right(null));

        // act
        final result = await repository.forgotPassword(email: tEmail);

        // assert
        expect(result, const Right(null));
        verify(() => mockRemoteDataSource.forgotPassword(email: tEmail));
      },
    );

    test(
      'should return Left when forgot password fails',
      () async {
        // arrange
        when(() => mockRemoteDataSource.forgotPassword(email: any(named: 'email')))
            .thenAnswer((_) async => const Left('Email not found'));

        // act
        final result = await repository.forgotPassword(email: tEmail);

        // assert
        expect(result, const Left('Email not found'));
        verify(() => mockRemoteDataSource.forgotPassword(email: tEmail));
      },
    );
  });
}