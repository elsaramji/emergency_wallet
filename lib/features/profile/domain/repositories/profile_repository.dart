import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserProfile>> getProfile({
    required String userId,
  });

  Future<Either<Failure, UserProfile>> saveProfile({
    required UserProfile profile,
  });

  Future<Either<Failure, UserProfile>> updateFinancialProfile({
    required String userId,
    required String employmentStatus,
    required bool hasStableSalary,
    double? monthlySalary,
    required bool emergencyWalletActivated,
  });

  Future<Either<Failure, UserProfile>> updateInitialBalances({
    required String userId,
    required double cash,
    required double visa,
    required double smartWallet,
  });
}
