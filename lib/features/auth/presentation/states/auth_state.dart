abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  final bool isFirstTime;

  const AuthSuccess({this.isFirstTime = false});
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);
}
