import 'dart:async';
import 'package:flutter/material.dart';
import 'package:robo_app/core/error/failures.dart';
import 'package:robo_app/core/usecases/usecase.dart';
import 'package:robo_app/features/home/domain/entities/cocktail.dart';
import 'package:robo_app/features/home/domain/usecases/cocktail/get_list_cocktail.dart';
import 'package:robo_app/features/home/presentation/blocs/home/bloc.dart';

import 'home_event.dart';
import 'home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INTERNET_FAILURE_MESSAGE = 'Internet Failure';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetListCocktail getListCocktail;

  List<Cocktail> cocktails = []; 

  HomeBloc({@required this.getListCocktail})
      : assert(getListCocktail != null),
        super(null);

  @override
  // ignore: override_on_non_overriding_member
  HomeState get initState { 
    return Empty();
  }

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if(event is Initial) {
      yield Empty();
    }
    if(event is GetListPopularCocktail){
      print("COCKTAIL COUNT :" + cocktails.length.toString());
      yield* initailDataHomePage(event.refresh);
    }
  }

  Stream<HomeState> initailDataHomePage(bool refresh) async* {
    if(cocktails.length == 0 || refresh) {
      yield PopularMenuLoading();
      final failureOrList = await getListCocktail(NoParams());
      yield failureOrList.fold(
        (failure) => PopularMenuError(message: _mapFailureToMessage(failure)),
        (cocktail) {
          cocktails.addAll(cocktail);
          return PopularMenuLoaded(cocktail: cocktail);
        },
      );
    } else {
      yield PopularMenuLoaded(cocktail: cocktails);
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch(failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case InternetFailure:
        return INTERNET_FAILURE_MESSAGE;
      default :
        return 'Unexpected error';
    }
  }
}
