import 'package:flutter/material.dart';
import 'package:robo_app/features/home/domain/entities/cocktail.dart';

class CocktailModel extends Cocktail {
  CocktailModel({
    @required cocktailId,
    @required cocktailName,
    @required pathImage,
    @required rating,
    price,
  }) : super(
            cocktailId: cocktailId,
            cocktailName: cocktailName,
            pathImage: pathImage,
            rating: rating,
            price: price
            );

  factory CocktailModel.fromJson(Map<String, dynamic> json) {
    return CocktailModel(
      cocktailId: json['Cocktail_Id'],
      cocktailName: json['Cocktail_Name'],
      pathImage: json['Path_Image'],
      rating: (json['Rating'] as num),
      price: (json['Price'] as num),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Cocktail_Id': cocktailId,
      'Cocktail_Name': cocktailName,
      'Path_Image': pathImage,
      'Rating': rating,
      'Price': price,
    };
  }
}
