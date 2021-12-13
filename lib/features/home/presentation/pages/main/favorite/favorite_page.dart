import 'package:flutter/material.dart';
import 'package:robo_app/features/home/presentation/blocs/initial_app/bloc.dart';
import 'package:robo_app/features/home/presentation/pages/main/tab_bar.dart';

class FavoritePage extends StatelessWidget {
  final BottomNavigationBloc bloc;

  const FavoritePage({Key key, this.bloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: TabBarNavigation(bloc: bloc,currentIndex: 1,),
      appBar: AppBar(title: Text('Favorite')),
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: Text("Favorite Page"),
      ),
    );
  }
}
