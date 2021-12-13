import 'package:flutter/material.dart';
import 'package:robo_app/features/home/domain/entities/cocktail.dart';
import 'package:robo_app/features/home/presentation/widgets/searching_bar.dart';

class HeaderHome extends StatefulWidget {
  final TrackingScrollController scrollController;

  final List<Cocktail> listCocktail;

  const HeaderHome({Key key,@required this.scrollController,@required this.listCocktail}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<HeaderHome> {

  List<Cocktail> listCocktail;

  @override
  void initState() {
    // TODO: implement initState
    listCocktail = widget.listCocktail;
  }
  
  @override
  Widget build(BuildContext context) {
    print("COCKTAIL 5555555 " + widget.listCocktail.toString());
    return Container(
      color: Color.fromRGBO(163, 106, 224, 1),
      child: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            print('Screen height: ${MediaQuery.of(context).size.height}');
            print('Real safe height: ${constraints.maxHeight}');
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                child: Row(
                  children: <Widget>[
                    _buildInputSearch(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _buildInputSearch() {
    final sizeIcon = BoxConstraints(
      minWidth: 40,
      minHeight: 40,
    );

    final border = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
        borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        ));

    return Expanded(
      child: TextField(
        onTap: () => {
          Navigator.of(context).push(
            PageRouteBuilder(
              opaque: false, // set to false
              pageBuilder: (_, __, ___) => SearchingBar(cocktailList: widget.listCocktail,),
            ),
          )
          },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(3),
          hintText: "Robotendy",
          enabledBorder: border,
          focusedBorder: border,
          isDense: true,
          hintStyle: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
          suffixIcon: Icon(Icons.search),
          suffixIconConstraints: sizeIcon,
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}

_buildIconButton({
  VoidCallback onPressed,
  IconData icon,
  int notification = 0,
}) {
  return Stack(
    children: <Widget>[
      IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        color: Colors.white,
        iconSize: 30,
      ),
      notification == 0
          ? SizedBox()
          : Positioned(
              right: 0,
              child: Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.deepOrange,
                  border: Border.all(color: Colors.white),
                ),
                constraints: BoxConstraints(
                  minWidth: 22,
                  minHeight: 22,
                ),
                child: Text(
                  '$notification',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
    ],
  );
}

