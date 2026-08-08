import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';
import '../models/user_profile_model.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, UserProfile>> getProfile({required String userId}) async {
    try {
      final profile = await _remoteDataSource.getProfile(userId: userId);
      return Right(profile);
    } catch (e) {
      return Left(ServerFailure('Failed to load user profile: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> saveProfile({required UserProfile profile}) async {
    try {
      final model = UserProfileModel.fromEntity(profile);
      await _remoteDataSource.saveProfile(profile: model);
      return Right(profile);
    } catch (e) {
      return Left(ServerFailure('Failed to save user profile: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> updateFinancialProfile({
    required String userId,
    required String employmentStatus,
    required bool hasStableSalary,
    double? monthlySalary,
    required bool emergencyWalletActivated,
  }) async {
    try {
      await _remoteDataSource.updateFinancialProfile(
        userId: userId,
        employmentStatus: employmentStatus,
        hasStableSalary: hasStableSalary,
        monthlySalary: monthlySalary,
        emergencyWalletActivated: emergencyWalletActivated,
      );
      final updatedProfile = await _remoteDataSource.getProfile(userId: userId);
      return Right(updatedProfile);
    } catch (e) {
      return Left(ServerFailure('Failed to update financial profile: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> updateInitialBalances({
    required String userId,
    required double cash,
    required double visa,
    required double smartWallet,
  }) async {
    try {
      await _remoteDataSource.updateInitialBalances(
        userId: userId,
        cash: cash,
        visa: visa,
        smartWallet: smartWallet,
      );
      final updatedProfile = await _remoteDataSource.getProfile(userId: userId);
      return Right(updatedProfile);
    } catch (e) {
      return Left(ServerFailure('Failed to update initial balances: ${e.toString()}'));
    }
  }
}
