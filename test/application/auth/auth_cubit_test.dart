import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:dynamic_dashboard/application/auth/auth_cubit.dart';
import 'package:dynamic_dashboard/domain/repositories/auth_repository.dart';
import 'package:dynamic_dashboard/domain/entities/user.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthCubit authCubit;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authCubit = AuthCubit(mockAuthRepository);
  });

  tearDown(() {
    authCubit.close();
  });

  const tUser = User(
    id: '123',
    email: 'test@example.com',
    name: 'Test User',
  );

  group('AuthCubit', () {
    test('initial state should be AuthState.initial', () {
      expect(authCubit.state, const AuthState.initial());
    });

    group('login', () {
      const tEmail = 'test@example.com';
      const tPassword = 'password123';

      blocTest<AuthCubit, AuthState>(
        'emits [loading, authenticated] when login is successful',
        build: () {
          when(() => mockAuthRepository.login(
                email: any(named: 'email'),
                password: any(named: 'password'),
              )).thenAnswer((_) async => const Right(tUser));
          return authCubit;
        },
        act: (cubit) => cubit.login(email: tEmail, password: tPassword),
        expect: () => [
          const AuthState.loading(),
          const AuthState.authenticated(user: tUser),
        ],
        verify: (_) {
          verify(() => mockAuthRepository.login(email: tEmail, password: tPassword));
        },
      );

      blocTest<AuthCubit, AuthState>(
        'emits [loading, error] when login fails',
        build: () {
          when(() => mockAuthRepository.login(
                email: any(named: 'email'),
                password: any(named: 'password'),
              )).thenAnswer((_) async => const Left('Invalid credentials'));
          return authCubit;
        },
        act: (cubit) => cubit.login(email: tEmail, password: tPassword),
        expect: () => [
          const AuthState.loading(),
          const AuthState.error(message: 'Invalid credentials'),
        ],
        verify: (_) {
          verify(() => mockAuthRepository.login(email: tEmail, password: tPassword));
        },
      );
    });

    group('register', () {
      const tEmail = 'test@example.com';
      const tPassword = 'password123';
      const tName = 'Test User';

      blocTest<AuthCubit, AuthState>(
        'emits [loading, authenticated] when registration is successful',
        build: () {
          when(() => mockAuthRepository.register(
                email: any(named: 'email'),
                password: any(named: 'password'),
                name: any(named: 'name'),
              )).thenAnswer((_) async => const Right(tUser));
          return authCubit;
        },
        act: (cubit) => cubit.register(
          email: tEmail,
          password: tPassword,
          name: tName,
        ),
        expect: () => [
          const AuthState.loading(),
          const AuthState.authenticated(user: tUser),
        ],
        verify: (_) {
          verify(() => mockAuthRepository.register(
                email: tEmail,
                password: tPassword,
                name: tName,
              ));
        },
      );

      blocTest<AuthCubit, AuthState>(
        'emits [loading, error] when registration fails',
        build: () {
          when(() => mockAuthRepository.register(
                email: any(named: 'email'),
                password: any(named: 'password'),
                name: any(named: 'name'),
              )).thenAnswer((_) async => const Left('Email already exists'));
          return authCubit;
        },
        act: (cubit) => cubit.register(
          email: tEmail,
          password: tPassword,
          name: tName,
        ),
        expect: () => [
          const AuthState.loading(),
          const AuthState.error(message: 'Email already exists'),
        ],
        verify: (_) {
          verify(() => mockAuthRepository.register(
                email: tEmail,
                password: tPassword,
                name: tName,
              ));
        },
      );
    });

    group('logout', () {
      blocTest<AuthCubit, AuthState>(
        'emits [loading, unauthenticated] when logout is successful',
        build: () {
          when(() => mockAuthRepository.logout())
              .thenAnswer((_) async => const Right(null));
          return authCubit;
        },
        act: (cubit) => cubit.logout(),
        expect: () => [
          const AuthState.loading(),
          const AuthState.unauthenticated(),
        ],
        verify: (_) {
          verify(() => mockAuthRepository.logout());
        },
      );

      blocTest<AuthCubit, AuthState>(
        'emits [loading, error] when logout fails',
        build: () {
          when(() => mockAuthRepository.logout())
              .thenAnswer((_) async => const Left('Logout failed'));
          return authCubit;
        },
        act: (cubit) => cubit.logout(),
        expect: () => [
          const AuthState.loading(),
          const AuthState.error(message: 'Logout failed'),
        ],
        verify: (_) {
          verify(() => mockAuthRepository.logout());
        },
      );
    });

    group('checkAuthStatus', () {
      blocTest<AuthCubit, AuthState>(
        'emits [loading, authenticated] when user is logged in and user data exists',
        build: () {
          when(() => mockAuthRepository.isLoggedIn())
              .thenAnswer((_) async => const Right(true));
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => const Right(tUser));
          return authCubit;
        },
        act: (cubit) => cubit.checkAuthStatus(),
        expect: () => [
          const AuthState.loading(),
          const AuthState.authenticated(user: tUser),
        ],
        verify: (_) {
          verify(() => mockAuthRepository.isLoggedIn());
          verify(() => mockAuthRepository.getCurrentUser());
        },
      );

      blocTest<AuthCubit, AuthState>(
        'emits [loading, unauthenticated] when user is not logged in',
        build: () {
          when(() => mockAuthRepository.isLoggedIn())
              .thenAnswer((_) async => const Right(false));
          return authCubit;
        },
        act: (cubit) => cubit.checkAuthStatus(),
        expect: () => [
          const AuthState.loading(),
          const AuthState.unauthenticated(),
        ],
        verify: (_) {
          verify(() => mockAuthRepository.isLoggedIn());
          verifyNever(() => mockAuthRepository.getCurrentUser());
        },
      );

      blocTest<AuthCubit, AuthState>(
        'emits [loading, unauthenticated] when user is logged in but user data retrieval fails',
        build: () {
          when(() => mockAuthRepository.isLoggedIn())
              .thenAnswer((_) async => const Right(true));
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => const Left('No user data'));
          return authCubit;
        },
        act: (cubit) => cubit.checkAuthStatus(),
        expect: () => [
          const AuthState.loading(),
          const AuthState.unauthenticated(),
        ],
        verify: (_) {
          verify(() => mockAuthRepository.isLoggedIn());
          verify(() => mockAuthRepository.getCurrentUser());
        },
      );

      blocTest<AuthCubit, AuthState>(
        'emits [loading, error] when checking login status fails',
        build: () {
          when(() => mockAuthRepository.isLoggedIn())
              .thenAnswer((_) async => const Left('Check failed'));
          return authCubit;
        },
        act: (cubit) => cubit.checkAuthStatus(),
        expect: () => [
          const AuthState.loading(),
          const AuthState.error(message: 'Check failed'),
        ],
        verify: (_) {
          verify(() => mockAuthRepository.isLoggedIn());
          verifyNever(() => mockAuthRepository.getCurrentUser());
        },
      );
    });

    group('forgotPassword', () {
      const tEmail = 'test@example.com';

      blocTest<AuthCubit, AuthState>(
        'emits [loading, unauthenticated] when forgot password is successful',
        build: () {
          when(() => mockAuthRepository.forgotPassword(email: any(named: 'email')))
              .thenAnswer((_) async => const Right(null));
          return authCubit;
        },
        act: (cubit) => cubit.forgotPassword(email: tEmail),
        expect: () => [
          const AuthState.loading(),
          const AuthState.unauthenticated(),
        ],
        verify: (_) {
          verify(() => mockAuthRepository.forgotPassword(email: tEmail));
        },
      );

      blocTest<AuthCubit, AuthState>(
        'emits [loading, error] when forgot password fails',
        build: () {
          when(() => mockAuthRepository.forgotPassword(email: any(named: 'email')))
              .thenAnswer((_) async => const Left('Email not found'));
          return authCubit;
        },
        act: (cubit) => cubit.forgotPassword(email: tEmail),
        expect: () => [
          const AuthState.loading(),
          const AuthState.error(message: 'Email not found'),
        ],
        verify: (_) {
          verify(() => mockAuthRepository.forgotPassword(email: tEmail));
        },
      );
    });
  });
}