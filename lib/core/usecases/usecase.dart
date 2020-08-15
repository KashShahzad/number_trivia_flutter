import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../features/number_trivia/domain/entities/number_trivia.dart';
import '../errors/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, NumberTrivia>> call(Params parms);
}

class NoParams extends Equatable {}
