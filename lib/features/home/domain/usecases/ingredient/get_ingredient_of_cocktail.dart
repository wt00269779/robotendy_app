import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:robo_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:robo_app/core/usecases/usecase.dart';
import 'package:robo_app/features/home/domain/entities/ingredient.dart';
import 'package:robo_app/features/home/domain/repositories/ingredient_repository.dart';

class GetIngredientOfCocktail extends UseCase<List<Ingredient>,Params> {

  final IngredientRepository repository;

  GetIngredientOfCocktail(this.repository);

  @override
  Future<Either<Failure, List<Ingredient>>> call(params) async {
    return await repository.getIngredientOfCocktail(params.cocktailId);
  }

}

class Params extends Equatable {
  final int cocktailId;

  Params({@required this.cocktailId});

  @override
  List<Object> get props => [this.cocktailId];

}