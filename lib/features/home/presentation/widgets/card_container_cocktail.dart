import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

// ignore: must_be_immutable
class CardContainerCocktail extends StatelessWidget {
  final String pathImage;
  final String cocktailName;

  CardContainerCocktail({Key key, this.pathImage, this.cocktailName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          InkWell(
            onTap: () {
              print("EIEIEI");
            },
            child: Image.network(pathImage),
          ),
          _favorite(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: 40,
                        alignment: Alignment.center,
                        color: Colors.black.withOpacity(0.7),
                        child: Text(
                          cocktailName,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      _StarRating(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  _StarRating() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(right: 1, bottom: 1),
      child: SmoothStarRating(
        allowHalfRating: true,
        onRated: (v) {
          print(v);
        },
        spacing: -3,
        starCount: 5,
        rating: 4.3,
        size: 14.0,
        isReadOnly: true,
        color: Colors.yellow[700],
        borderColor: Colors.black,
      ),
    );
  }

  bool favorite = false;

  _favorite() {
    return Positioned(
      top: 2,
      right: 2,
      child: GestureDetector(
        onTap: () {
          if (!favorite)
            favorite = true;
          else
            favorite = false;
          print("test");
        },
        child: Icon(
          Icons.favorite,
          color: favorite ? Colors.red : Colors.white,
        ),
      ),
    );
  }
}
