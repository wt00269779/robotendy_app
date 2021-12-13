import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:robo_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:robo_app/core/usecases/usecase.dart';
import 'package:robo_app/features/home/domain/entities/token.dart';
import 'package:robo_app/features/home/domain/repositories/token_repository.dart';

class GetNewToken extends UseCase<Token,Params> {
  final TokenRepository repository;

  GetNewToken(this.repository);

  @override
  Future<Either<Failure, Token>> call(Params params) {
    return repository.getNewToken(params.refreshToken);
  }

}

class Params extends Equatable {
  final String refreshToken;

  Params({@required this.refreshToken});

  @override
  List<Object> get props => [this.refreshToken]; 

}