import 'package:robo_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:robo_app/core/usecases/usecase.dart';
import 'package:robo_app/features/home/domain/entities/ingredient.dart';
import 'package:robo_app/features/home/domain/repositories/ingredient_repository.dart';

class GetMasterIngredient extends UseCase<List<Ingredient>,NoParams> {
  final IngredientRepository repository;

  GetMasterIngredient(this.repository);
  
  @override
  Future<Either<Failure, List<Ingredient>>> call(NoParams params) async {
    return await repository.getMasterIngredient();
  }
  
}