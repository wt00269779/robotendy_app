import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:robo_app/features/home/domain/entities/ingredient.dart';

abstract class IngredientState extends Equatable {
  const IngredientState();

  @override
  List<Object> get props => [];
}

class IngredientInitial extends IngredientState {}

class IngredientOfCocktailLoading extends IngredientState {
  @override
  String toString() => "IngredientOfCocktailLoading";
}

class IngredientOfCocktailLoaded extends IngredientState {
  final List<Ingredient> listIngredient;

  IngredientOfCocktailLoaded(this.listIngredient);

  @override
  String toString() => "IngredientOfCocktailLoaded : { $listIngredient }";
}

class MasterIngredientLoading extends IngredientState {
  @override
  String toString() => "MasterIngredient";
}

class MasterIngredientLoaded extends IngredientState {
  final List<Ingredient> listIngredient;

  MasterIngredientLoaded({@required this.listIngredient});
  @override
  String toString() => "MasterIngredientLoaded : { $listIngredient }"; 
}

class Error extends IngredientState {
  final String message;

  Error({@required this.message});

  @override
  String toString() => "Error : { $message }";
}