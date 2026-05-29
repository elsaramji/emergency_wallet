import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../shared/domain/entities/wallet_transaction.dart';

abstract interface class HistoryRepository {
  Future<Either<Failure, List<WalletTransaction>>> getTransactionsByMonth({
    required int year,
    required int month,
  });

  Future<Either<Failure, Map<int, int>>> getYearlyActivity({
    required int year,
  });

  Future<Either<Failure, void>> logTransaction({
    required WalletTransaction transaction,
  });
}
