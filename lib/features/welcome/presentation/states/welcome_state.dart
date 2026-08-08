enum EmploymentType { student, freelancer, employee }
enum EmergencyWalletStatus { pending, accepted, declined }
enum WelcomeStatus { initial, loading, success, failure }

class WelcomeState {
  final int currentStep;
  final EmploymentType? employmentType;
  final bool? hasStableSalary;
  final EmergencyWalletStatus emergencyWalletStatus;
  final double? salaryAmount;
  final double? cashBalance;
  final double? visaBalance;
  final double? smartWalletBalance;
  final double savingsPercentage;
  final WelcomeStatus status;
  final String? errorMessage;

  final bool isCompleted;

  const WelcomeState({
    this.currentStep = 0,
    this.employmentType,
    this.hasStableSalary,
    this.emergencyWalletStatus = EmergencyWalletStatus.pending,
    this.salaryAmount,
    this.cashBalance,
    this.visaBalance,
    this.smartWalletBalance,
    this.savingsPercentage = 20.0,
    this.status = WelcomeStatus.initial,
    this.errorMessage,
    this.isCompleted = false,
  });

  WelcomeState copyWith({
    int? currentStep,
    EmploymentType? employmentType,
    bool? hasStableSalary,
    EmergencyWalletStatus? emergencyWalletStatus,
    double? salaryAmount,
    double? cashBalance,
    double? visaBalance,
    double? smartWalletBalance,
    double? savingsPercentage,
    WelcomeStatus? status,
    String? errorMessage,
    bool? isCompleted,
  }) {
    return WelcomeState(
      currentStep: currentStep ?? this.currentStep,
      employmentType: employmentType ?? this.employmentType,
      hasStableSalary: hasStableSalary ?? this.hasStableSalary,
      emergencyWalletStatus: emergencyWalletStatus ?? this.emergencyWalletStatus,
      salaryAmount: salaryAmount ?? this.salaryAmount,
      cashBalance: cashBalance ?? this.cashBalance,
      visaBalance: visaBalance ?? this.visaBalance,
      smartWalletBalance: smartWalletBalance ?? this.smartWalletBalance,
      savingsPercentage: savingsPercentage ?? this.savingsPercentage,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
