part of 'dashboard_cubit.dart';

class DashboardState {
  final bool isBalanceVisible;
  final double cashBalance;
  final double visaBalance;
  final double smartWalletBalance;
  final double emergencyBalance;
  final bool isLowBalanceSimulated;

  const DashboardState({
    this.isBalanceVisible = false,
    this.cashBalance = 4200.0,
    this.visaBalance = 6800.0,
    this.smartWalletBalance = 1450.0,
    this.emergencyBalance = 3500.0,
    this.isLowBalanceSimulated = false,
  });

  DashboardState copyWith({
    bool? isBalanceVisible,
    double? cashBalance,
    double? visaBalance,
    double? smartWalletBalance,
    double? emergencyBalance,
    bool? isLowBalanceSimulated,
  }) {
    return DashboardState(
      isBalanceVisible: isBalanceVisible ?? this.isBalanceVisible,
      cashBalance: cashBalance ?? this.cashBalance,
      visaBalance: visaBalance ?? this.visaBalance,
      smartWalletBalance: smartWalletBalance ?? this.smartWalletBalance,
      emergencyBalance: emergencyBalance ?? this.emergencyBalance,
      isLowBalanceSimulated: isLowBalanceSimulated ?? this.isLowBalanceSimulated,
    );
  }
}
