import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:robo_app/core/error/exception.dart';
import 'package:robo_app/core/error/failures.dart';
import 'package:robo_app/core/network/network_info.dart';
import 'package:robo_app/features/home/data/datasources/external_login_remote_datasouce.dart';
import 'package:robo_app/features/home/domain/repositories/external_login_repository.dart';

class ExternalLoginRepositoryImpl implements ExternalLoginRepository {
  ExternalLoginRemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;

  ExternalLoginRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Map<String, String>>> getDataFacebook() async {
    if(await networkInfo.isConnect) {
      try {
        return Right(await remoteDataSource.getDataFacebook());

      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    } 
  }

  @override
  Future<Either<Failure, Map<String, String>>> getDataGoogle() async {
    if(await networkInfo.isConnect) {
      try {
        return Right(await remoteDataSource.getDataGoogle());

      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    } 
  }

}