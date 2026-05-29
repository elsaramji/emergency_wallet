import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/wallet_transaction.dart';

abstract interface class TransactionRepository {
  Future<Either<Failure, Map<String, double>>> getBalances();

  Future<Either<Failure, void>> logTransaction({
    required WalletTransaction transaction,
  });

  Future<Either<Failure, void>> updateBalances({
    required Map<String, double> balances,
  });
}
