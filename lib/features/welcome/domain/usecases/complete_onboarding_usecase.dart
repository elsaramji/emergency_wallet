import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../../profile/domain/entities/user_profile.dart';
import '../../../profile/domain/repositories/profile_repository.dart';

class CompleteOnboardingParams {
  final String employmentStatus;
  final bool hasStableSalary;
  final double? monthlySalary;
  final bool emergencyWalletActivated;
  final double initialCashBalance;
  final double initialVisaBalance;
  final double initialSmartWalletBalance;

  const CompleteOnboardingParams({
    required this.employmentStatus,
    required this.hasStableSalary,
    this.monthlySalary,
    required this.emergencyWalletActivated,
    required this.initialCashBalance,
    required this.initialVisaBalance,
    required this.initialSmartWalletBalance,
  });
}

@injectable
class CompleteOnboardingUseCase {
  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;

  const CompleteOnboardingUseCase({
    required AuthRepository authRepository,
    required ProfileRepository profileRepository,
  })  : _authRepository = authRepository,
        _profileRepository = profileRepository;

  Future<Either<Failure, UserProfile>> call(CompleteOnboardingParams params) async {
    // 1. Get the authenticated user
    final userEither = await _authRepository.getAuthenticatedUser();
    
    return userEither.fold(
      (failure) => Left(failure),
      (user) async {
        // Use user ID if available, otherwise default to a local guest user ID
        final userId = user?.id ?? 'local_user';
        
        final profile = UserProfile(
          userId: userId,
          employmentStatus: params.employmentStatus,
          hasStableSalary: params.hasStableSalary,
          monthlySalary: params.monthlySalary,
          emergencyWalletActivated: params.emergencyWalletActivated,
          initialCashBalance: params.initialCashBalance,
          initialVisaBalance: params.initialVisaBalance,
          initialSmartWalletBalance: params.initialSmartWalletBalance,
          isOnboardingCompleted: true,
        );

        return _profileRepository.saveProfile(profile: profile);
      },
    );
  }
}
