import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:robo_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:robo_app/core/usecases/usecase.dart';
import 'package:robo_app/features/home/domain/entities/token.dart';
import 'package:robo_app/features/home/domain/repositories/token_repository.dart';

class AccessUser extends UseCase<Token, Params> {
  final TokenRepository repository;

  AccessUser(this.repository);

  @override
  Future<Either<Failure, Token>> call(Params params) async {
    return await repository.accessUser(params.username, params.password,params.provider,params.providerKey,params.displayName);
  }
}

class Params extends Equatable {
  final String username;
  final String password;
  final String displayName;
  final String provider;
  final String providerKey;

  Params({
    @required this.username,
    @required this.password,
    @required this.displayName,
    @required this.provider,
    @required this.providerKey,
  });

  @override
  List<Object> get props =>
      [this.username, this.password, this.provider, this.providerKey, this.displayName];
}
