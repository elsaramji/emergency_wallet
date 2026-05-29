import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/wallet_transaction.dart';
import '../entities/wallet.dart';
import '../repositories/transaction_repository.dart';

// Helper to map WalletType enum to keys used in balances map
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

class LogCashOutUseCase {
  final TransactionRepository _transactionRepository;

  const LogCashOutUseCase(this._transactionRepository);

  Future<Either<Failure, void>> call(WalletTransaction transaction) async {
    if (transaction.isPositive) {
      return const Left(LocalFailure('Cash-out transaction must have a negative or expense amount representation.'));
    }

    // 1. Fetch current balances
    final balancesEither = await _transactionRepository.getBalances();
    return balancesEither.fold(
      (failure) => Left(failure),
      (balances) async {
        final Map<String, double> updatedBalances = Map.from(balances);
        final String walletKey = _walletKey(transaction.walletType);

        // Emergency Wallet withdrawal rule
        if (transaction.walletType == WalletType.emergency) {
          final double cash = balances['Cash'] ?? 0.0;
          final double visa = balances['Visa'] ?? 0.0;
          final double smartWallet = balances['Smart Wallet'] ?? 0.0;
          final double nonEmergencyTotal = cash + visa + smartWallet;

          if (nonEmergencyTotal > 50.0) {
            return const Left(
              LocalFailure(
                'Emergency Wallet can only be accessed when other wallets are empty or near zero (total <= 50 EGP).',
              ),
            );
          }
        }

        // Deduct from target wallet
        final double currentBalance = updatedBalances[walletKey] ?? 0.0;
        updatedBalances[walletKey] = currentBalance - transaction.amount; // transaction.amount is positive, so we subtract

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
