import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../shared/domain/entities/wallet_transaction.dart';
import '../repositories/history_repository.dart';

class LogTransactionUseCase {
  final HistoryRepository _repository;

  const LogTransactionUseCase(this._repository);

  Future<Either<Failure, void>> call(
    WalletTransaction transaction,
  ) {
    return _repository.logTransaction(
      transaction: transaction,
    );
  }
}
