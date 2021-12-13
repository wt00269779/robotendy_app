import 'package:meta/meta.dart';
import 'package:robo_app/core/error/exception.dart';
import 'package:robo_app/core/network/network_info.dart';
import 'package:robo_app/features/home/data/datasources/ingredient_remote_datasource.dart';
import 'package:robo_app/features/home/domain/entities/ingredient.dart';
import 'package:robo_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:robo_app/features/home/domain/repositories/ingredient_repository.dart';

class IngredientRepositoryImpl implements IngredientRepository {
  IngredientRemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;
  
  IngredientRepositoryImpl({@required this.remoteDataSource,@required this.networkInfo,});

  @override
  Future<Either<Failure, List<Ingredient>>> getMasterIngredient() async {
    if(await networkInfo.isConnect) {
      try {
        return Right(await remoteDataSource.getMasterIngredient());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, List<Ingredient>>> getIngredientOfCocktail(int id) async {
    if(await networkInfo.isConnect) {
      try {
        return Right(await remoteDataSource.getIngredientOfCocktail(id));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

}