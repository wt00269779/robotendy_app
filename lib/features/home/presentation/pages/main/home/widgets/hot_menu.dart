import 'package:flutter/material.dart';
import 'package:robo_app/features/home/domain/entities/cocktail.dart';
import 'package:robo_app/features/home/presentation/pages/cocktail_all_menu/cocktail_all_menu_page.dart';
import 'package:robo_app/features/home/presentation/widgets/card_cocktail.dart';
import 'package:robo_app/features/home/presentation/widgets/loading_indicator.dart';
import 'package:robo_app/features/home/presentation/widgets/text_header.dart';

class HotMenu extends StatefulWidget {
  final List<Cocktail> cocktails;
  final bool loading;

  const HotMenu({Key key, this.cocktails, this.loading = false})
      : super(key: key);

  @override
  _HotMenuState createState() => _HotMenuState();
}

class _HotMenuState extends State<HotMenu> {
  // List<CocktailModel> _cocktail = CocktailViewModel().getCocktail();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: TextHeader(
            prefixText: 'Popular Menu',
            suffixText: 'All',
            changePage: CocktailAllMenuPage(
              cocktails: widget.cocktails,
            ),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        _HotMenuList(),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  _HotMenuList() {
    if (widget.loading) {
      return LoadingIndicator();
    }
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Row(
            children: <Widget>[
              CardCocktail(
                pathImage: 'https://robotendy.com/Photo%20Cocktail/' +
                    widget.cocktails[index].pathImage,
                cocktailName: widget.cocktails[index].cocktailName,
                cocktailId: widget.cocktails[index].cocktailId,
              ),
              SizedBox(
                width: 8,
              ),
            ],
          );
        },
      ),
    );
  }
}
