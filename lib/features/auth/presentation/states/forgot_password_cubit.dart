import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class ForgotPasswordCubit extends Cubit<AuthState> {
  ForgotPasswordCubit() : super(const AuthInitial());

  Future<void> resetPassword(String email) async {
    emit(const AuthLoading());
    try {
      // Mock network delay
      await Future.delayed(const Duration(seconds: 2));
      
      if (email.isNotEmpty && email.contains('@')) {
        emit(const AuthSuccess());
      } else {
        emit(const AuthFailure('Please enter a valid email address'));
      }
    } catch (e) {
      emit(const AuthFailure('Failed to send reset link. Please try again.'));
    }
  }
}
