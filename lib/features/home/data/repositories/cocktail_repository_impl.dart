import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:robo_app/core/error/failures.dart';
import 'package:robo_app/core/error/exception.dart';
import 'package:robo_app/core/network/network_info.dart';
import 'package:robo_app/features/home/data/datasources/cocktail_local_datasource.dart';
import 'package:robo_app/features/home/data/datasources/cocktail_remote_datasource.dart';
import 'package:robo_app/features/home/domain/entities/cocktail.dart';
import 'package:robo_app/features/home/domain/repositories/cocktail_repository.dart';

class CocktailRepositoryImpl implements CocktailRepository {
  CocktailRemoteDataSource remoteDataSource;
  CocktailLocalDataSource localDataSource;
  NetworkInfo networkInfo;

  CocktailRepositoryImpl({
    this.localDataSource,
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Cocktail>>> getMasterCocktail() async {
    if(await networkInfo.isConnect) {
      try {
        return Right(await remoteDataSource.getMasterCocktail());

      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    } 
  }

}