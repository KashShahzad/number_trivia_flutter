import 'package:flutter/cupertino.dart';
import 'package:numberTrivia/core/errors/exceptions.dart';
import 'package:numberTrivia/core/network/network_info.dart';
import 'package:numberTrivia/features/number_trivia/data/dataSources/number_trivia_local_data_source.dart';
import 'package:numberTrivia/features/number_trivia/data/dataSources/number_trivia_remote_data_source.dart';
import 'package:numberTrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:numberTrivia/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:numberTrivia/features/number_trivia/domain/repositories/number_trivia_repo.dart';

typedef Future<NumberTrivia> _ConcreteOrRandomChooser();

class NumberTriviaRepoImpl implements NumberTriviaRepo {
  final NTRemoteDataSource remoteDataSource;
  final NTLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepoImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
    int number,
  ) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
