import 'package:dartz/dartz.dart';
import 'package:robo_app/core/error/failures.dart';

abstract class ExternalLoginRepository {
  Future<Either<Failure,Map<String,String>>> getDataFacebook();
  Future<Either<Failure,Map<String,String>>> getDataGoogle();
}