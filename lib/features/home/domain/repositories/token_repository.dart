import 'package:dartz/dartz.dart';
import 'package:robo_app/core/error/failures.dart';
import 'package:robo_app/features/home/domain/entities/token.dart';

abstract class TokenRepository {
  Future<Either<Failure,Token>> accessUser(String user,String password,String method,String providerKey,String displayName);
  Future<Either<Failure,Map<String,dynamic>>>registerUser(String user,String password);
  Future<Either<Failure,Token>> getNewToken(String refreshToken);
}