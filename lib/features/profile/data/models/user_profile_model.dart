import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.userId,
    required super.employmentStatus,
    required super.hasStableSalary,
    super.monthlySalary,
    required super.emergencyWalletActivated,
    required super.initialCashBalance,
    required super.initialVisaBalance,
    required super.initialSmartWalletBalance,
    required super.isOnboardingCompleted,
  });

  factory UserProfileModel.fromEntity(UserProfile entity) {
    return UserProfileModel(
      userId: entity.userId,
      employmentStatus: entity.employmentStatus,
      hasStableSalary: entity.hasStableSalary,
      monthlySalary: entity.monthlySalary,
      emergencyWalletActivated: entity.emergencyWalletActivated,
      initialCashBalance: entity.initialCashBalance,
      initialVisaBalance: entity.initialVisaBalance,
      initialSmartWalletBalance: entity.initialSmartWalletBalance,
      isOnboardingCompleted: entity.isOnboardingCompleted,
    );
  }

  factory UserProfileModel.fromFirestore(Map<String, dynamic> json, String userId) {
    return UserProfileModel(
      userId: userId,
      employmentStatus: json['employmentStatus'] as String? ?? 'employee',
      hasStableSalary: json['hasStableSalary'] as bool? ?? false,
      monthlySalary: (json['monthlySalary'] as num?)?.toDouble(),
      emergencyWalletActivated: json['emergencyWalletActivated'] as bool? ?? false,
      initialCashBalance: (json['initialCashBalance'] as num?)?.toDouble() ?? 0.0,
      initialVisaBalance: (json['initialVisaBalance'] as num?)?.toDouble() ?? 0.0,
      initialSmartWalletBalance: (json['initialSmartWalletBalance'] as num?)?.toDouble() ?? 0.0,
      isOnboardingCompleted: json['isOnboardingCompleted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toProfileFirestore() {
    return {
      'employmentStatus': employmentStatus,
      'hasStableSalary': hasStableSalary,
      'monthlySalary': monthlySalary,
      'emergencyWalletActivated': emergencyWalletActivated,
      'isOnboardingCompleted': isOnboardingCompleted,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> toFinancialStatusFirestore() {
    return {
      'salaryAmount': monthlySalary ?? 0.0,
      'cashAmount': initialCashBalance,
      'visaAmount': initialVisaBalance,
      'phoneWalletAmount': initialSmartWalletBalance,
      'emergencyWalletActivated': emergencyWalletActivated,
      'emergencyWalletStatus': emergencyWalletActivated ? 'accepted' : 'declined',
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> toMoneyFirestore() {
    return {
      'cashAmount': initialCashBalance,
      'visaAmount': initialVisaBalance,
      'phoneWalletAmount': initialSmartWalletBalance,
      'emergencyWalletAmount': 0.0,
      'emergencyWalletLocked': false,
      'totalBalance': initialCashBalance + initialVisaBalance + initialSmartWalletBalance,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
