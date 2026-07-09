import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/auth_repository.dart';
import 'auth_state.dart';

@LazySingleton()
class RegisterCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  RegisterCubit(this._authRepository) : super(const AuthInitial());

  Future<void> register(String name, String email, String password) async {
    emit(const AuthLoading());
    final result = await _authRepository.register(
      name: name,
      email: email,
      password: password,
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(isFirstTime: user.isFirstTime)),
    );
  }
}
