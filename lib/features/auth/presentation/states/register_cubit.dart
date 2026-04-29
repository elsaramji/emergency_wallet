import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class RegisterCubit extends Cubit<AuthState> {
  RegisterCubit() : super(const AuthInitial());

  Future<void> register(String name, String email, String password) async {
    emit(const AuthLoading());
    try {
      // Mock network delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Basic mock validation
      if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        emit(const AuthSuccess());
      } else {
        emit(const AuthFailure('Please fill all fields'));
      }
    } catch (e) {
      emit(const AuthFailure('Failed to register. Please try again.'));
    }
  }
}
