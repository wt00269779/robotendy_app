import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robo_app/features/home/domain/entities/cocktail.dart';
import 'package:robo_app/features/home/presentation/blocs/home/bloc.dart';
import 'package:robo_app/features/home/presentation/widgets/loading_indicator.dart';

import '../../../../../injection_container.dart';
import 'widgets/header.dart';
import 'widgets/menu_list_verticle.dart';

class CocktailTypeMenuPage extends StatefulWidget {
  final String cocktailType;
  final String pathImage;
  final List<Cocktail> listCocktail;

  const CocktailTypeMenuPage({
    Key key,
    @required this.cocktailType,
    @required this.pathImage,
    this.listCocktail,
  }) : super(key: key);

  @override
  _CocktailTypeMenuPageState createState() => _CocktailTypeMenuPageState();
}

class _CocktailTypeMenuPageState extends State<CocktailTypeMenuPage> {
  final _scrollController = TrackingScrollController();

  String cocktailType;
  String pathImage;

  @override
  void initState() {
    cocktailType = widget.cocktailType;
    pathImage = widget.pathImage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = sl<HomeBloc>();
    bloc.add(GetListPopularCocktail());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.only(),
            child: Column(
              children: <Widget>[
                _buildBanner(),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is PopularMenuLoading) {
                      return LoadingIndicator();
                    } else if (state is PopularMenuLoaded) {
                      return MenuListVerticle(
                        cocktails: state.cocktail,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Header(
            scrollController: _scrollController,
            transparent: true,
          ),
        ],
      ),
    );
  }

  _buildBanner() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Expanded(
          child: AspectRatio(
            aspectRatio: 20 / 17,
            child: Container(
              width: double.infinity,
              child: Image.network(
                pathImage,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          child: Text(
            cocktailType,
            style: TextStyle(
              fontSize: 50,
              color: Colors.white,
              letterSpacing: 15,
              shadows: [
                Shadow(offset: Offset(-1.5, 1.5), color: Colors.black),
              ],
            ),
          ),
        )
      ],
    );
  }
}
