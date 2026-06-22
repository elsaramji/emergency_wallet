import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/auth_repository.dart';
import 'auth_state.dart';

@LazySingleton()
class LoginCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(const AuthInitial());

  Future<void> loginWithEmail(String email, String password) async {
    emit(const AuthLoading());
    final result = await _authRepository.login(
      email: email,
      password: password,
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(const AuthSuccess()),
    );
  }

  Future<void> loginWithGoogle() async {
    emit(const AuthLoading());
    final result = await _authRepository.signInWithGoogle();
    result.fold((failure) {
      debugPrint(failure.message);
      emit(AuthFailure(failure.message));
    }, (user) => emit(const AuthSuccess()));
  }
}
