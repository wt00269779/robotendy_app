import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robo_app/features/home/domain/entities/cocktail.dart';
import 'package:robo_app/features/home/domain/entities/ingredient.dart';
import 'package:robo_app/features/home/presentation/blocs/ingredient/bloc.dart';
import 'package:robo_app/features/home/presentation/pages/cocktail_detail/widgets/navigator_bar.dart';
import 'package:robo_app/features/home/presentation/widgets/loading_indicator.dart';
import 'package:robo_app/injection_container.dart';

class CocktailDetailPage extends StatelessWidget {
  final Cocktail cocktail;

  const CocktailDetailPage({Key key, @required this.cocktail})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: NavigatorBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Image.network(
                    cocktail.pathImage,
                    fit: BoxFit.fill,
                  ),
                ),
                SafeArea(
                  bottom: false,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate back to first route when tapped.
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      child: Icon(Icons.keyboard_backspace,
                          size: 40, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 13,
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              alignment: Alignment.topLeft,
              child: Text(
                cocktail.cocktailName,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildIngredientDetail(),
          ],
        ),
      ),
    );
  }

  _buildIngredientDetail() {
    print("NAME " + cocktail.cocktailName);
    print(cocktail.cocktailId);
    final bloc = sl<IngredientBloc>();
    bloc.add(ShowIngredientOfCocktail(cocktailId: cocktail.cocktailId));
    return BlocProvider(
      create: (context) =>
          bloc..add(ShowIngredientOfCocktail(cocktailId: cocktail.cocktailId)),
      child: BlocBuilder<IngredientBloc, IngredientState>(
        builder: (context, state) {
          if (state is IngredientOfCocktailLoading) {
            return LoadingIndicator();
          } else if (state is IngredientOfCocktailLoaded) {
            List<Ingredient> cocktail = state.listIngredient;
            return Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Ingredient : ',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ConstrainedBox(
                    constraints: new BoxConstraints(
                      minHeight: 50.0,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 50, top: 10),
                      child: getIngredientWidgets(cocktail),
                    )),
              ],
            );
          }
          if (state is Error) {
            return Center(
              child: Text(state.message),
            );
          }
          return LoadingIndicator();
        },
      ),
    );
  }

  Widget getIngredientWidgets(List<Ingredient> ingredients) {
    return new Column(
      children: ingredients
          .map(
            (e) => new Container(
              padding: EdgeInsets.only(bottom: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  e.ingredientName + ' ' + e.volume.toString() + ' ml.',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
