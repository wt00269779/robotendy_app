import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:robo_app/features/home/domain/entities/cocktail.dart';

abstract class HomeState extends Equatable {
  HomeState([List props = const <dynamic>[]]);
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'HomeInitial';
}

class Empty extends HomeState {
  @override
  List<Object> get props => [];

   @override
  String toString() => 'Empty';
}

class PopularMenuLoading extends HomeState {
   @override
  List<Object> get props => [];

   @override
  String toString() => 'PopularMenuLoading ';
}

class PopularMenuLoaded extends HomeState {
  final List<Cocktail> cocktail;

  PopularMenuLoaded({@required this.cocktail}): super([cocktail]);

  @override
  List<Object> get props => [cocktail];

   @override
  String toString() => 'PopularMenuLoaded { cocktail : $cocktail }';
}

class PopularMenuError extends HomeState {
  final String message;

  PopularMenuError({@required this.message}): super([message]);

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [message];

   @override
  String toString() => 'PopularMenuError { PopularMenuError : $message }';
}