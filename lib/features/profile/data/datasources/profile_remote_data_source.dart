import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../models/user_profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserProfileModel> getProfile({required String userId});

  Future<void> saveProfile({required UserProfileModel profile});

  Future<void> updateFinancialProfile({
    required String userId,
    required String employmentStatus,
    required bool hasStableSalary,
    double? monthlySalary,
    required bool emergencyWalletActivated,
  });

  Future<void> updateInitialBalances({
    required String userId,
    required double cash,
    required double visa,
    required double smartWallet,
  });
}

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseFirestore _firestore;

  ProfileRemoteDataSourceImpl(this._firestore);

  @override
  Future<UserProfileModel> getProfile({required String userId}) async {
    final userRef = _firestore.collection('users').doc(userId);
    final profileDoc = await userRef.collection('profile').doc('data').get();
    final financialDoc = await userRef.collection('financial_status').doc('data').get();
    final moneyDoc = await userRef.collection('money').doc('data').get();

    final profileData = profileDoc.data() ?? {};
    final financialData = financialDoc.data() ?? {};
    final moneyData = moneyDoc.data() ?? {};

    return UserProfileModel(
      userId: userId,
      employmentStatus: profileData['employmentStatus'] as String? ?? 'employee',
      hasStableSalary: profileData['hasStableSalary'] as bool? ?? false,
      monthlySalary: (financialData['salaryAmount'] as num?)?.toDouble() ??
          (profileData['monthlySalary'] as num?)?.toDouble(),
      emergencyWalletActivated: profileData['emergencyWalletActivated'] as bool? ??
          financialData['emergencyWalletActivated'] as bool? ??
          false,
      initialCashBalance: (moneyData['cashAmount'] as num?)?.toDouble() ??
          (financialData['cashAmount'] as num?)?.toDouble() ??
          0.0,
      initialVisaBalance: (moneyData['visaAmount'] as num?)?.toDouble() ??
          (financialData['visaAmount'] as num?)?.toDouble() ??
          0.0,
      initialSmartWalletBalance: (moneyData['phoneWalletAmount'] as num?)?.toDouble() ??
          (financialData['phoneWalletAmount'] as num?)?.toDouble() ??
          0.0,
      isOnboardingCompleted: profileData['isOnboardingCompleted'] as bool? ?? false,
    );
  }

  @override
  Future<void> saveProfile({required UserProfileModel profile}) async {
    final userRef = _firestore.collection('users').doc(profile.userId);
    final batch = _firestore.batch();

    // 1. Profile subcollection
    final profileRef = userRef.collection('profile').doc('data');
    batch.set(profileRef, profile.toProfileFirestore(), SetOptions(merge: true));

    // 2. Financial Status subcollection
    final financialStatusRef = userRef.collection('financial_status').doc('data');
    batch.set(financialStatusRef, profile.toFinancialStatusFirestore(), SetOptions(merge: true));

    // 3. Money subcollection (initial balances)
    final moneyRef = userRef.collection('money').doc('data');
    batch.set(moneyRef, profile.toMoneyFirestore(), SetOptions(merge: true));

    await batch.commit();
  }

  @override
  Future<void> updateFinancialProfile({
    required String userId,
    required String employmentStatus,
    required bool hasStableSalary,
    double? monthlySalary,
    required bool emergencyWalletActivated,
  }) async {
    final userRef = _firestore.collection('users').doc(userId);
    final batch = _firestore.batch();

    final profileRef = userRef.collection('profile').doc('data');
    batch.set(profileRef, {
      'employmentStatus': employmentStatus,
      'hasStableSalary': hasStableSalary,
      'monthlySalary': monthlySalary,
      'emergencyWalletActivated': emergencyWalletActivated,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    final financialStatusRef = userRef.collection('financial_status').doc('data');
    batch.set(financialStatusRef, {
      'salaryAmount': monthlySalary ?? 0.0,
      'emergencyWalletActivated': emergencyWalletActivated,
      'emergencyWalletStatus': emergencyWalletActivated ? 'accepted' : 'declined',
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    await batch.commit();
  }

  @override
  Future<void> updateInitialBalances({
    required String userId,
    required double cash,
    required double visa,
    required double smartWallet,
  }) async {
    final userRef = _firestore.collection('users').doc(userId);
    final batch = _firestore.batch();

    final financialStatusRef = userRef.collection('financial_status').doc('data');
    batch.set(financialStatusRef, {
      'cashAmount': cash,
      'visaAmount': visa,
      'phoneWalletAmount': smartWallet,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    final moneyRef = userRef.collection('money').doc('data');
    batch.set(moneyRef, {
      'cashAmount': cash,
      'visaAmount': visa,
      'phoneWalletAmount': smartWallet,
      'totalBalance': cash + visa + smartWallet,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    await batch.commit();
  }
}
