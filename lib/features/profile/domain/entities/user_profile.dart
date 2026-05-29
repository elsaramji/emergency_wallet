class UserProfile {
  final String userId;
  final String employmentStatus; // 'Employee', 'Freelancer', 'Student'
  final bool hasStableSalary;
  final double? monthlySalary;
  final bool emergencyWalletActivated;
  final double initialCashBalance;
  final double initialVisaBalance;
  final double initialSmartWalletBalance;
  final bool isOnboardingCompleted;

  const UserProfile({
    required this.userId,
    required this.employmentStatus,
    required this.hasStableSalary,
    this.monthlySalary,
    required this.emergencyWalletActivated,
    required this.initialCashBalance,
    required this.initialVisaBalance,
    required this.initialSmartWalletBalance,
    required this.isOnboardingCompleted,
  });

  UserProfile copyWith({
    String? userId,
    String? employmentStatus,
    bool? hasStableSalary,
    double? monthlySalary,
    bool? emergencyWalletActivated,
    double? initialCashBalance,
    double? initialVisaBalance,
    double? initialSmartWalletBalance,
    bool? isOnboardingCompleted,
  }) {
    return UserProfile(
      userId: userId ?? this.userId,
      employmentStatus: employmentStatus ?? this.employmentStatus,
      hasStableSalary: hasStableSalary ?? this.hasStableSalary,
      monthlySalary: monthlySalary ?? this.monthlySalary,
      emergencyWalletActivated: emergencyWalletActivated ?? this.emergencyWalletActivated,
      initialCashBalance: initialCashBalance ?? this.initialCashBalance,
      initialVisaBalance: initialVisaBalance ?? this.initialVisaBalance,
      initialSmartWalletBalance: initialSmartWalletBalance ?? this.initialSmartWalletBalance,
      isOnboardingCompleted: isOnboardingCompleted ?? this.isOnboardingCompleted,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfile &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          employmentStatus == other.employmentStatus &&
          hasStableSalary == other.hasStableSalary &&
          monthlySalary == other.monthlySalary &&
          emergencyWalletActivated == other.emergencyWalletActivated &&
          initialCashBalance == other.initialCashBalance &&
          initialVisaBalance == other.initialVisaBalance &&
          initialSmartWalletBalance == other.initialSmartWalletBalance &&
          isOnboardingCompleted == other.isOnboardingCompleted;

  @override
  int get hashCode =>
      userId.hashCode ^
      employmentStatus.hashCode ^
      hasStableSalary.hashCode ^
      monthlySalary.hashCode ^
      emergencyWalletActivated.hashCode ^
      initialCashBalance.hashCode ^
      initialVisaBalance.hashCode ^
      initialSmartWalletBalance.hashCode ^
      isOnboardingCompleted.hashCode;

  @override
  String toString() {
    return 'UserProfile{userId: $userId, employmentStatus: $employmentStatus, hasStableSalary: $hasStableSalary, monthlySalary: $monthlySalary, emergencyWalletActivated: $emergencyWalletActivated, initialCashBalance: $initialCashBalance, initialVisaBalance: $initialVisaBalance, initialSmartWalletBalance: $initialSmartWalletBalance, isOnboardingCompleted: $isOnboardingCompleted}';
  }
}
