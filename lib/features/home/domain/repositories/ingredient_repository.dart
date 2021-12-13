import 'package:dartz/dartz.dart';
import 'package:robo_app/core/error/failures.dart';
import 'package:robo_app/features/home/domain/entities/ingredient.dart';

abstract class IngredientRepository {
  Future<Either<Failure,List<Ingredient>>> getMasterIngredient();
  Future<Either<Failure,List<Ingredient>>> getIngredientOfCocktail(int cocktailId);
}