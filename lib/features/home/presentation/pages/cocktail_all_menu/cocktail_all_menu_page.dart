import 'package:flutter/material.dart';
import 'package:robo_app/features/home/domain/entities/cocktail.dart';
import 'package:robo_app/features/home/presentation/pages/cocktail_type_menu/widgets/header.dart';
import 'package:robo_app/features/home/presentation/pages/cocktail_type_menu/widgets/menu_list_verticle.dart';

class CocktailAllMenuPage extends StatelessWidget {
  final List<Cocktail> cocktails;

  const CocktailAllMenuPage({Key key, this.cocktails}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final _scrollController = TrackingScrollController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: <Widget>[
        SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.only(
            top: 85,
          ),
          child : MenuListVerticle(
            cocktails: cocktails,
          ),
        ),
        Header(
          scrollController: _scrollController,
          headerText : 'All',
        ),
      ]),
    );
  }
}
