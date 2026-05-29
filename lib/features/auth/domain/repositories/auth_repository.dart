import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> signInWithGoogle();

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, void>> forgotPassword({
    required String email,
  });

  Future<Either<Failure, User?>> getAuthenticatedUser();
}
