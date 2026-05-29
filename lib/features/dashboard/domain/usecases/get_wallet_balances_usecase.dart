import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../shared/domain/repositories/transaction_repository.dart';

class GetWalletBalancesUseCase {
  final TransactionRepository _repository;

  const GetWalletBalancesUseCase(this._repository);

  Future<Either<Failure, Map<String, double>>> call() {
    return _repository.getBalances();
  }
}
