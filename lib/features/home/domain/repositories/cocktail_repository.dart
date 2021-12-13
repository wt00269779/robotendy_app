import 'package:dartz/dartz.dart';
import 'package:robo_app/core/error/failures.dart';
import 'package:robo_app/features/home/domain/entities/cocktail.dart';

abstract class CocktailRepository {
  Future<Either<Failure, List<Cocktail>>> getMasterCocktail();
  // Future<Either<Failure, Cocktail>> getCocktailInfo();
  // Future<Either<Failure, List<Ingredient>>> getIngredient(int cocktailId);
}