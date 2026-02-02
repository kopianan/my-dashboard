import 'package:bloc/bloc.dart';
import 'package:dynamic_dashboard/domain/entities/user.dart';
import 'package:dynamic_dashboard/domain/repositories/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  
  AuthCubit(this._authRepository) : super(const AuthState.initial());
  final AuthRepository _authRepository;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const AuthState.loading());
    
    final result = await _authRepository.login(
      email: email,
      password: password,
    );
    
    result.fold(
      (error) => emit(AuthState.error(message: error)),
      (user) => emit(AuthState.authenticated(user: user)),
    );
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(const AuthState.loading());
    
    final result = await _authRepository.register(
      email: email,
      password: password,
      name: name,
    );
    
    result.fold(
      (error) => emit(AuthState.error(message: error)),
      (user) => emit(AuthState.authenticated(user: user)),
    );
  }

  Future<void> logout() async {
    emit(const AuthState.loading());
    
    final result = await _authRepository.logout();
    
    result.fold(
      (error) => emit(AuthState.error(message: error)),
      (_) => emit(const AuthState.unauthenticated()),
    );
  }

  Future<void> checkAuthStatus() async {
    emit(const AuthState.loading());
    
    final isLoggedInResult = await _authRepository.isLoggedIn();
    
    await isLoggedInResult.fold(
      (error) async => emit(AuthState.error(message: error)),
      (isLoggedIn) async {
        if (isLoggedIn) {
          final userResult = await _authRepository.getCurrentUser();
          userResult.fold(
            (error) => emit(const AuthState.unauthenticated()),
            (user) => emit(AuthState.authenticated(user: user)),
          );
        } else {
          emit(const AuthState.unauthenticated());
        }
      },
    );
  }

  Future<void> forgotPassword({required String email}) async {
    emit(const AuthState.loading());
    
    final result = await _authRepository.forgotPassword(email: email);
    
    result.fold(
      (error) => emit(AuthState.error(message: error)),
      (_) => emit(const AuthState.unauthenticated()),
    );
  }
}
