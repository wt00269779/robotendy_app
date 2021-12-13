import 'package:meta/meta.dart';
import 'package:robo_app/core/error/exception.dart';
import 'package:robo_app/core/network/network_info.dart';
import 'package:robo_app/features/home/data/datasources/token_remote_datasource.dart';
import 'package:robo_app/features/home/domain/entities/token.dart';
import 'package:robo_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:robo_app/features/home/domain/repositories/token_repository.dart';

class TokenRepositoryImpl implements TokenRepository {
  TokenRemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;

  TokenRepositoryImpl({@required this.remoteDataSource,@required this.networkInfo,});

  @override
  Future<Either<Failure, Token>> accessUser(String user, String password,String method,String providerKey,String displayName) async {
    if(await networkInfo.isConnect) {
      try {
        return Right(await remoteDataSource.accessUser(user,password,method,providerKey,displayName));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, Token>> getNewToken(String refreshToken) async {
    if(await networkInfo.isConnect) {
      try {
        return Right(await remoteDataSource.getNewToken(refreshToken));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, Map<String,dynamic>>> registerUser(String user, String password) async {
    if(await networkInfo.isConnect) {
      try {
        return Right(await remoteDataSource.registerUser(user,password));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

}