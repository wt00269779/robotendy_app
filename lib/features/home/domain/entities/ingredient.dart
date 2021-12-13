import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Ingredient extends Equatable {
  final int ingredientId;
  final String ingredientName;
  final String description;
  final String ingredientType;
  final double volume;
  final double defaultVolume;
  final double stepVolume;

  Ingredient({
    @required this.ingredientId,
    @required this.ingredientName,
    this.description,
    this.ingredientType,
    this.volume,
    this.defaultVolume,
    this.stepVolume,
  });

  @override
  List<Object> get props => [
        this.ingredientId,
        this.ingredientName,
        this.description,
        this.ingredientType,
        this.volume,
        this.defaultVolume,
        this.stepVolume,
      ];
}
