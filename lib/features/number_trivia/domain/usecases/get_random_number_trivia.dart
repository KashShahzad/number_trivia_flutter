import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repo.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepo repo;

  GetRandomNumberTrivia(this.repo);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams parms) async {
    return await repo.getRandomNumberTrivia();
  }
}
