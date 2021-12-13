import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robo_app/features/home/presentation/blocs/initial_app/bloc.dart';

class TabBarNavigation extends StatefulWidget {
  final BottomNavigationBloc bloc;
  final int currentIndex;

  const TabBarNavigation({
    Key key,
    @required this.bloc,
    @required this.currentIndex,
  }) : super(key: key);

  @override
  TabBarNavigationState createState() => TabBarNavigationState();
}

class TabBarNavigationState extends State<TabBarNavigation> {
  int pageSelected;

  @override
  void initState() {
    pageSelected = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var listItems = [
      BottomAppBarItem(iconData: Icons.local_bar, text: 'Home'),
      BottomAppBarItem(iconData: Icons.favorite, text: 'Favorite'),
      BottomAppBarItem(iconData: Icons.supervised_user_circle, text: 'Profile'),
    ];

    var items = List.generate(listItems.length, (int index) {
      print(listItems[index].text);
      return _buildTabItem(
        item: listItems[index],
        index: index,
        bloc: widget.bloc,
      );
    });

    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      bloc: widget.bloc,
      builder: (context, state) {
        return BottomAppBar(
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.2,
                blurRadius: 3,
                offset: Offset(0, -2),
              )
            ]),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: items,
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabItem(
      {BottomAppBarItem item, int index, BottomNavigationBloc bloc}) {
    return Expanded(
      child: SizedBox(
        height: 55,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              print("SELECTED " + index.toString());
              bloc.add(PageSelected(index: index));

              setState(() {
                pageSelected = index;
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  item.iconData,
                  color: widget.currentIndex == index
                      ? Colors.purple
                      : Colors.black,
                  size: 24,
                ),
                Text(
                  item.text,
                  style: TextStyle(
                    color: widget.currentIndex == index
                        ? Colors.purple
                        : Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomAppBarItem {
  BottomAppBarItem({this.iconData, this.text});

  IconData iconData;
  String text;
}
