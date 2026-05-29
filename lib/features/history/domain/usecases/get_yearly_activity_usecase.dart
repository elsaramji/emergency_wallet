import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/history_repository.dart';

class GetYearlyActivityParams {
  final int year;

  const GetYearlyActivityParams({
    required this.year,
  });
}

class GetYearlyActivityUseCase {
  final HistoryRepository _repository;

  const GetYearlyActivityUseCase(this._repository);

  Future<Either<Failure, Map<int, int>>> call(
    GetYearlyActivityParams params,
  ) {
    return _repository.getYearlyActivity(
      year: params.year,
    );
  }
}
