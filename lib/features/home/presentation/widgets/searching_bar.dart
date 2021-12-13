import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:robo_app/features/home/domain/entities/cocktail.dart';
import 'package:robo_app/features/home/presentation/pages/cocktail_detail/cocktail_detail_page.dart';

class SearchingBar extends StatefulWidget {
  SearchingBar({Key key, @required this.cocktailList}) : super(key: key);

  final List<Cocktail> cocktailList;

  @override
  _SearchingBarState createState() => _SearchingBarState();
}

class _SearchingBarState extends State<SearchingBar> {
  List<Cocktail> cocktails = [];

  @override
  void initState() {
    print(cocktails);

    super.initState();
  }

  final sizeIcon = BoxConstraints(
    minWidth: 40,
    minHeight: 40,
  );

  Widget buildListCocktail() {
    ScrollController _controller = new ScrollController();
    print("LEN");
    print(cocktails.length);
    if (cocktails.length == 0) {
      return SizedBox();
    } else {
      return Container(
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: ListView.builder(
          controller: _controller,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          shrinkWrap: true,
          itemCount: cocktails.length,
          itemBuilder: (context, index) {
            return searchCard(cocktails[index]);
          },
        ),
      );
    }
  }

  Widget searchCard(Cocktail cocktail) {
    Cocktail tempCocktail = Cocktail(cocktailId: cocktail.cocktailId,cocktailName: cocktail.cocktailName,pathImage: "https://robotendy.com/Photo%20Cocktail/" + cocktail.pathImage,price: cocktail.price);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CocktailDetailPage(
              cocktail: tempCocktail,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child:
                      Image.network("https://robotendy.com/Photo%20Cocktail/" + cocktail.pathImage, fit: BoxFit.fill),
                ),
              ),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 8,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "Strength : Strong",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Text(
                        cocktail.cocktailName,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Container(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: 50.0,
                          ),
                          child: Text(
                            "        " +
                                "metus, at tempus velit. metus, at tempus velit. metus, at tempus velit. metus, at tempus velit. metus, at tempus velit. metus, at tempus velit. metus, at tempus velit. Pellentesque interdum tellus tempor sem gravida fermentum.",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                            maxLines: 4,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          cocktail.price.toString() + " ฿",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.black),
          ),
        ),
      ),
    );
  }

  // Widget searchListCocktail() {
  //   setState(() {
  //   });
  // }

  List<Cocktail> searchingCocktail = [];

  final border = OutlineInputBorder(
      borderRadius: const BorderRadius.all(
    const Radius.circular(10.0),
  ));
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color(0x000000).withOpacity(0.8),
          ),
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
                    child: Column(
                      children: <Widget>[
                        TextField(
                          onChanged: (query) => updateSearch(query),
                          controller: searchController,
                          focusNode: AlwaysDisabledFocusNode(),
                          autofocus: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding: EdgeInsets.all(5),
                            hintText: "Robotendy",
                            enabledBorder: border,
                            isDense: true,
                            hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                            suffixIcon: InkWell(
                              onTap: () {
                                searchController.text = "";
                              },
                              child: Icon(FontAwesomeIcons.times),
                            ),
                            suffixIconConstraints: sizeIcon,
                            prefix: Padding(
                              child: InkWell(
                                onTap: () => {Navigator.of(context).pop()},
                                child: Icon(FontAwesomeIcons.arrowLeft),
                              ),
                              padding: EdgeInsetsDirectional.only(
                                  end: 8.0, start: 4),
                            ),
                            prefixIconConstraints: sizeIcon,
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        buildListCocktail(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  updateSearch(String query) {
    if (query == "") {
      cocktails = [];
    } else {
      cocktails = [];
      widget.cocktailList.forEach((item) {
        if (item.cocktailName.toLowerCase().contains(query.toLowerCase())) {
          cocktails.add(item);
        }
      });
    }
    setState(() {});
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => true;
}
