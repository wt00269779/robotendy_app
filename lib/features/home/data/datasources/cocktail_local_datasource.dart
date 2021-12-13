import 'package:robo_app/features/home/data/models/cocktail_model.dart';

abstract class CocktailLocalDataSource {
  Future<List<CocktailModel>> getLastHotMenuCocktail();

  Future<void> cacheHotMenuListCocktail(List<CocktailModel> cocktailTocCache);
}

class CocktailLocalDataSourceImpl implements CocktailLocalDataSource {
  @override
  Future<void> cacheHotMenuListCocktail(List<CocktailModel> cocktailTocCache) {
    throw UnimplementedError();
  }

  @override
  Future<List<CocktailModel>> getLastHotMenuCocktail() {
    return null;
  }

}