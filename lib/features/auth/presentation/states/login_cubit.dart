import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class LoginCubit extends Cubit<AuthState> {
  LoginCubit() : super(const AuthInitial());

  Future<void> loginWithEmail(String email, String password) async {
    emit(const AuthLoading());
    try {
      // Mock network delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Basic mock validation
      if (email.isNotEmpty && password.isNotEmpty) {
        emit(const AuthSuccess());
      } else {
        emit(const AuthFailure('Invalid credentials'));
      }
    } catch (e) {
      emit(const AuthFailure('Failed to login. Please try again.'));
    }
  }

  Future<void> loginWithGoogle() async {
    emit(const AuthLoading());
    try {
      // Mock network delay
      await Future.delayed(const Duration(seconds: 2));
      emit(const AuthSuccess());
    } catch (e) {
      emit(const AuthFailure('Failed to login with Google.'));
    }
  }
}
