import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/wallet_transaction.dart';
import '../repositories/history_repository.dart';

class GetTransactionsByMonthParams {
  final int year;
  final int month;

  const GetTransactionsByMonthParams({
    required this.year,
    required this.month,
  });
}

class GetTransactionsByMonthUseCase {
  final HistoryRepository _repository;

  const GetTransactionsByMonthUseCase(this._repository);

  Future<Either<Failure, List<WalletTransaction>>> call(
    GetTransactionsByMonthParams params,
  ) {
    return _repository.getTransactionsByMonth(
      year: params.year,
      month: params.month,
    );
  }
}
