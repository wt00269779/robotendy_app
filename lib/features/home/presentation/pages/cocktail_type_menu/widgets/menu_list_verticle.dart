import 'package:flutter/material.dart';
import 'package:robo_app/features/home/domain/entities/cocktail.dart';
import 'package:robo_app/features/home/presentation/widgets/card_cocktail.dart';

class MenuListVerticle extends StatelessWidget {
  final List<Cocktail> cocktails;

  MenuListVerticle({Key key, this.cocktails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new GridView.builder(
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.730,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15
        ),
        shrinkWrap: true,
        controller: new ScrollController(keepScrollOffset: false),
        scrollDirection: Axis.vertical,
        itemCount: cocktails.length,
        padding: new EdgeInsets.all(8.0),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: double.infinity,
            child: new CardCocktail(
              cocktailName: cocktails[index].cocktailName,
              pathImage: 'https://robotendy.com/Photo%20Cocktail/' +cocktails[index].pathImage,
              cocktailId: cocktails[index].cocktailId,
            ),
          );
        },
      ),
    );
  }
}
