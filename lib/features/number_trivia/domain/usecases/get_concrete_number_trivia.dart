import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:numberTrivia/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repo.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepo repository;

  GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params({@required this.number}) : super([number]);
}
