import 'dart:convert';

import 'package:robo_app/core/error/exception.dart';
import 'package:robo_app/features/home/data/models/cocktail_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class CocktailRemoteDataSource {
  Future<List<CocktailModel>> getMasterCocktail();
}

class CocktailRemoteDataSourceImpl implements CocktailRemoteDataSource {
  final http.Client client;

  CocktailRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<CocktailModel>> getMasterCocktail() async {
    final response =
        await client.get('https://robotendy.com/api/Master/Cocktail', headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      return json.decode(response.body).map<CocktailModel>((data) {
        return new  CocktailModel.fromJson(data);
      }).toList();
    } else {
      throw ServerException();
    }
  }
}
