import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:robo_app/features/home/domain/entities/cocktail.dart';

abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState();
  
  @override
  List<Object> get props => [];
}

class CurrentIndexChanged extends BottomNavigationState {
  final int currentIndex;

  CurrentIndexChanged({@required this.currentIndex});

  @override
  String toString() => 'CurrentIndexChanged to $currentIndex';
}

class ListCocktailLoaded extends BottomNavigationState {
  final List<Cocktail> cocktails;

  ListCocktailLoaded({@required this.cocktails});

  String toString() => 'ListCocktailLoaded : { $cocktails } ';
}

class BottomNavigationInitial extends BottomNavigationState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'BottomNavigationInitial';
}

class PageLoading extends BottomNavigationInitial {
  final int indexPage;

  PageLoading(this.indexPage);

  @override
  String toString() => 'PageLoading { indexPage : $indexPage }';
}

class HomePageLoaded extends BottomNavigationState {
  // final List<Cocktail> cocktails;

  // HomePageLoaded({this.cocktails});

  @override
  String toString() => 'HomePageLoaded';
}

class FavoritePageLoaded extends BottomNavigationState {
  @override
  String toString() => 'FavoritePageLoaded';
}

class AuthenPageLoaded extends BottomNavigationState {
  @override
  String toString() => 'AuthenPageLoaded';
}

class Error extends BottomNavigationState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];

   @override
  String toString() => 'Error { Error : $message }';
}