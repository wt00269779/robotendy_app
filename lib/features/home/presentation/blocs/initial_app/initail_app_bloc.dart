import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:robo_app/core/error/failures.dart';

import 'package:robo_app/features/home/domain/usecases/cocktail/get_list_cocktail.dart';
import 'package:robo_app/features/home/presentation/blocs/initial_app/bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INTERNET_FAILURE_MESSAGE = 'Internet Failure';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {

  final GetListCocktail getListCocktail;
  int currentIndex = 0;
  // List<Cocktail> cocktails = new List<Cocktail>();

  BottomNavigationBloc({@required this.getListCocktail}) : super(null);
  
  @override
  Stream<BottomNavigationState> mapEventToState(
    BottomNavigationEvent event,
  ) async* {

    // Bottom Navigation
    if (event is NavigationInitial) {
      this.currentIndex = 0;
      yield HomePageLoaded();
    }
    if (event is PageSelected) {
      this.currentIndex = event.index;
      print("CURRENT INDEX " + this.currentIndex.toString());
      if (this.currentIndex == 0) {
        yield HomePageLoaded();
      } else if (this.currentIndex == 1) {
        yield FavoritePageLoaded();
      } else if (this.currentIndex == 2) {
        yield AuthenPageLoaded();
      }
    }
  }

  // Stream<BottomNavigationState> initailDataHomePage() async* {
  //   if(cocktails.length == 0) {
  //     yield PageLoading(0);
  //     final failureOrList = await getListCocktail(NoParams());
  //     yield failureOrList.fold(
  //       (failure) => Error(message: _mapFailureToMessage(failure)),
  //       (cocktail) {
  //         cocktails.addAll(cocktail);
  //         return HomePageLoaded(cocktails: cocktails);
  //       },
  //     );
  //   } else {
  //     yield HomePageLoaded(cocktails: cocktails);
    
  //   }
  // }

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
