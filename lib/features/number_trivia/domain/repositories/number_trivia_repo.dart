import 'package:dartz/dartz.dart';
import '../entities/number_trivia.dart';
import '../../../../core/errors/failure.dart';

abstract class NumberTriviaRepo {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
