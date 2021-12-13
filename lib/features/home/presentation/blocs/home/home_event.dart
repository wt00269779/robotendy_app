import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  HomeEvent([List props = const<dynamic>[]]) : super();

  @override
  List<Object> get props => [];
}

class Initial extends HomeEvent {
  @override
  String toString() => 'Initial';
}

class GetListPopularCocktail extends HomeEvent {
  final bool refresh;

  GetListPopularCocktail({this.refresh = false});
  @override
  List<Object> get props => [];
}