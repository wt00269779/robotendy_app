import 'package:robo_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:robo_app/core/usecases/usecase.dart';
import 'package:robo_app/features/home/domain/entities/cocktail.dart';
import 'package:robo_app/features/home/domain/repositories/cocktail_repository.dart';

class GetListCocktail extends UseCase<List<Cocktail>,NoParams> {
  final CocktailRepository repository;

  GetListCocktail(this.repository);

  @override
  Future<Either<Failure, List<Cocktail>>> call(NoParams params) async {
    return await repository.getMasterCocktail();
  }

}