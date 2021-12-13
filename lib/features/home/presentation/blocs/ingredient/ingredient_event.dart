
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class IngredientEvent extends Equatable {
  const IngredientEvent();

  @override
  List<Object> get props => [];
}

class InitMasterIngredient extends IngredientEvent {
  @override
  String toString() => "InitMasterIngredient"; 
}

class ShowIngredientOfCocktail extends IngredientEvent {
  final int cocktailId;

  ShowIngredientOfCocktail({@required this.cocktailId});
}