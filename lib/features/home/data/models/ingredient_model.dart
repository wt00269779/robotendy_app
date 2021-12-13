import 'package:flutter/material.dart';
import 'package:robo_app/features/home/domain/entities/ingredient.dart';

class IngredientModel extends Ingredient {
  IngredientModel({
    @required ingredientId,
    @required ingredientName,
    description,
    ingredientType,
    volume,
    defaultVolume,
    stepVolume,
  }) : super(
          ingredientId: ingredientId,
          ingredientName: ingredientName,
          description: description,
          ingredientType: ingredientType,
          volume: volume,
          defaultVolume: defaultVolume,
          stepVolume: stepVolume,
        );

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      ingredientId: json['Ingredient_Id'],
      ingredientName: json['Ingredient_Name'],
      description: json['Description'],
      ingredientType: json['Ingredient_Type'],
      volume: (json['Volume'] as num),
      defaultVolume: (json['Default_Volume'] as num),
      stepVolume: (json['Step_Volume'] as num),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Ingredient_Id': ingredientId,
      'Ingredient_Name': ingredientName,
      'Description': description,
      'Ingredient_Type': ingredientType,
      'Volume': volume,
      'Default_Volume': defaultVolume,
      'Step_Volume': stepVolume,
    };
  }
}
