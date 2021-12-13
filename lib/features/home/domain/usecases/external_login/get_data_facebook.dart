import 'package:robo_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:robo_app/core/usecases/usecase.dart';
import 'package:robo_app/features/home/domain/repositories/external_login_repository.dart';

class GetDataFacebook extends UseCase<Map<String,String>,NoParams> {
  final ExternalLoginRepository repository;

  GetDataFacebook(this.repository);

  
  @override
  Future<Either<Failure, Map<String,String>>> call(NoParams params) async {
    return await repository.getDataFacebook();
  }
  
}