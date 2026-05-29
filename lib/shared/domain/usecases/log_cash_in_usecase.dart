import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../features/profile/domain/repositories/profile_repository.dart';
import '../entities/wallet_transaction.dart';
import '../entities/wallet.dart';
import '../repositories/transaction_repository.dart';

// Helper to map WalletType enum to map keys used in balances
String _walletKey(WalletType type) {
  switch (type) {
    case WalletType.cash:
      return 'Cash';
    case WalletType.visa:
      return 'Visa';
    case WalletType.smartWallet:
      return 'Smart Wallet';
    case WalletType.emergency:
      return 'Emergency';
  }
}

class LogCashInUseCase {
  final TransactionRepository _transactionRepository;
  final ProfileRepository _profileRepository;

  const LogCashInUseCase({
    required TransactionRepository transactionRepository,
    required ProfileRepository profileRepository,
  })  : _transactionRepository = transactionRepository,
        _profileRepository = profileRepository;

  Future<Either<Failure, void>> call(WalletTransaction transaction) async {
    if (!transaction.isPositive) {
      return const Left(LocalFailure('Cash-in transaction must have a positive amount.'));
    }

    // 1. Fetch current balances
    final balancesEither = await _transactionRepository.getBalances();
    return balancesEither.fold(
      (failure) => Left(failure),
      (balances) async {
        final Map<String, double> updatedBalances = Map.from(balances);
        final String wallet = _walletKey(transaction.walletType);
        final double currentBalance = updatedBalances[wallet] ?? 0.0;

        // Default addition
        updatedBalances[wallet] = currentBalance + transaction.amount;

        // Check if salary and if user has stable salary to trigger 20% auto-deduction
        if (transaction.isSalary) {
          final profileEither = await _profileRepository.getProfile(userId: 'local_user');
          
          await profileEither.fold(
            (failure) async {
              // If profile get fails, just save the transaction without auto-save
            },
            (profile) async {
              if (profile.hasStableSalary && profile.emergencyWalletActivated) {
                final double emergencyDeduction = transaction.amount * 0.20;
                
                // Subtract 20% from the target wallet
                final double currentTargetWalletBal = updatedBalances[wallet] ?? 0.0;
                updatedBalances[wallet] = currentTargetWalletBal - emergencyDeduction;

                // Add 20% to Emergency Wallet
                final String emergencyKey = _walletKey(WalletType.emergency);
                final double currentEmergencyBal = updatedBalances[emergencyKey] ?? 0.0;
                updatedBalances[emergencyKey] = currentEmergencyBal + emergencyDeduction;

                // Log the auto-save transaction metadata if required
                // Note: The UI/data source will handle saving both transactions.
              }
            },
          );
        }

        // 2. Save the transaction log
        final logResult = await _transactionRepository.logTransaction(transaction: transaction);
        return logResult.fold(
          (failure) => Left(failure),
          (_) async {
            // 3. Update the balances
            return _transactionRepository.updateBalances(balances: updatedBalances);
          },
        );
      },
    );
  }
}
