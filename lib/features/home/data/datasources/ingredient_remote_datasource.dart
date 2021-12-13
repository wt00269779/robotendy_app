import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:robo_app/core/error/exception.dart';
import 'package:robo_app/features/home/data/models/ingredient_model.dart';
import 'package:http/http.dart' as http;

abstract class IngredientRemoteDataSource {
  Future<List<IngredientModel>> getMasterIngredient();
  Future<List<IngredientModel>> getIngredientOfCocktail(int cocktailId);
}

class IngredientRemoteDataSourceImpl implements IngredientRemoteDataSource {
  final http.Client client;

  IngredientRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<IngredientModel>> getMasterIngredient() async {
    final response = await client.get(
        'https://robotendy.com/api/Master/Ingredient',
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return json
          .decode(response.body)
          .map<IngredientModel>((data) {
            return new IngredientModel.fromJson(data);
          })
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<IngredientModel>> getIngredientOfCocktail(int cocktailId) async {
    final response = await client.get(
      'https://robotendy.com/api/Mobile/Cocktail/Detail/json?cocktailId=$cocktailId',
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json
          .decode(response.body)
          .map<IngredientModel>((data) => IngredientModel.fromJson(data))
          .toList();
    }else {
      throw ServerException();
    }
  }
}
