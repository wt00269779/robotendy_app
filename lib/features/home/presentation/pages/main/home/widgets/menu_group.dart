import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:robo_app/features/home/presentation/blocs/home/home_bloc.dart';
import 'package:robo_app/features/home/presentation/pages/cocktail_type_menu/cocktail_type_menu_page.dart';
import 'package:robo_app/features/home/presentation/widgets/text_header.dart';

class MenuGroup extends StatefulWidget {
  //final List<Cocktail> listCocktail;
  final HomeBloc homeBloc;

  const MenuGroup({Key key, this.homeBloc}) : super(key: key);

  @override
  _MenuGroupState createState() => _MenuGroupState();
}

class _MenuGroupState extends State<MenuGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        TextHeader(
          prefixText: 'Category',
        ),
        SizedBox(height: 4),
        Row(
          children: <Widget>[
            _cardGroupCocktail(
                text: 'Cocktail',
                pathImage:
                    'https://robotendy.com/Photo%20Cocktail/banner_cocktail.png'),
            SizedBox(
              width: 8,
            ),
            _cardGroupCocktail(
                text: 'Mocktail',
                pathImage:
                    'https://robotendy.com/Photo%20Cocktail/banner_mocktail.png'),
            SizedBox(
              width: 8,
            ),
          ],
        ),
      ],
    );
  }

  _cardGroupCocktail({text, pathImage}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CocktailTypeMenuPage(
                cocktailType: text,
                pathImage: pathImage,
                //listCocktail: widget.listCocktail,
              ),
            ),
          );
        },
        child: AspectRatio(
          aspectRatio: 18 / 25,
          child: Container(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.network(
                  pathImage,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 20,
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      shadows: [
                        Shadow(offset: Offset(-1.5, 1.5), color: Colors.black),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
