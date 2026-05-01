enum EmploymentType { student, freelancer, employee }
enum EmergencyWalletStatus { pending, accepted, declined }

class WelcomeState {
  final int currentStep;
  final EmploymentType? employmentType;
  final bool? hasStableSalary;
  final EmergencyWalletStatus emergencyWalletStatus;

  const WelcomeState({
    this.currentStep = 0,
    this.employmentType,
    this.hasStableSalary,
    this.emergencyWalletStatus = EmergencyWalletStatus.pending,
  });

  WelcomeState copyWith({
    int? currentStep,
    EmploymentType? employmentType,
    bool? hasStableSalary,
    EmergencyWalletStatus? emergencyWalletStatus,
  }) {
    return WelcomeState(
      currentStep: currentStep ?? this.currentStep,
      employmentType: employmentType ?? this.employmentType,
      hasStableSalary: hasStableSalary ?? this.hasStableSalary,
      emergencyWalletStatus: emergencyWalletStatus ?? this.emergencyWalletStatus,
    );
  }
}
