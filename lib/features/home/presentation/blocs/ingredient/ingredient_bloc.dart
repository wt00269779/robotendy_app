import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:robo_app/core/error/failures.dart';
import 'package:robo_app/core/usecases/usecase.dart';
import 'package:robo_app/features/home/domain/entities/ingredient.dart';
import 'package:robo_app/features/home/domain/usecases/ingredient/get_ingredient_list.dart';
import 'package:robo_app/features/home/domain/usecases/ingredient/get_ingredient_of_cocktail.dart';
import 'package:robo_app/features/home/presentation/blocs/ingredient/bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INTERNET_FAILURE_MESSAGE = 'Internet Failure';

class IngredientBloc extends Bloc<IngredientEvent, IngredientState> {
  final GetMasterIngredient getMasterIngredient;
  final GetIngredientOfCocktail getIngredientOfCocktail;

  List<Ingredient> masterIngredient = [];

  IngredientBloc({
    @required this.getMasterIngredient,
    @required this.getIngredientOfCocktail,
  })  : assert(getMasterIngredient != null),
        assert(getIngredientOfCocktail != null),
        super(null);

  @override
  Stream<IngredientState> mapEventToState(
    IngredientEvent event,
  ) async* {
    if (event is InitMasterIngredient) {
      List<Ingredient> masterIngredient = [];
      yield MasterIngredientLoading();
      final failOrList = await getMasterIngredient(NoParams());
      
      yield failOrList.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (ingredients) {
          print("INGREDIENT " +ingredients.toString());
          masterIngredient.addAll(ingredients);
          return MasterIngredientLoaded(listIngredient: masterIngredient);
        },
      );
    }
    if (event is ShowIngredientOfCocktail) {
      List<Ingredient> ingredientOfCocktail = [];

      yield IngredientOfCocktailLoading();

      final failureOrList =
          await getIngredientOfCocktail(Params(cocktailId: event.cocktailId));
      yield failureOrList.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (ingredients) {
          ingredientOfCocktail.addAll(ingredients);
          return IngredientOfCocktailLoaded(ingredientOfCocktail);
        },
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case InternetFailure:
        return INTERNET_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
