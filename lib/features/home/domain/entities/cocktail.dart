import 'package:equatable/equatable.dart';

class Cocktail extends Equatable {
  final int cocktailId;
  final String cocktailName;
  final String pathImage;
  final double rating;
  final double price;

  Cocktail({this.cocktailId, this.cocktailName, this.pathImage, this.rating, this.price});

  @override
  List<Object> get props => [this.cocktailId, this.cocktailName, this.pathImage, this.rating, this.price];

}