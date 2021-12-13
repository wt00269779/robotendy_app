import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Header extends StatefulWidget {
  final TrackingScrollController scrollController;
  final bool transparent;
  final String headerText;

  const Header({this.scrollController,this.transparent = false,this.headerText = 'Robotendy'});

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  Color _backgroundColor;
  Color _backgroundColorSearch;
  Color _colorIcon;
  double _opacity;

  final _opacityMax = 0.01;

  @override
  void initState() {

    _backgroundColor = Colors.transparent;
    _backgroundColorSearch = Colors.white;
    _colorIcon = Colors.white;
    _opacity = 0.0;

    widget.scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildAppbar(),
      ],
    );
  }

  _buildAppbar() {
    return Container(
      color: widget.transparent ? _backgroundColor : Color.fromRGBO(163, 106, 224, 1),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 8.0,
          right: 8.0,
        ),
        child: SafeArea(
          bottom: false,
          child: Row(
            children: <Widget>[
              _buildIconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icons.keyboard_backspace,
              ),
              _buildInputSearch(),
              _buildIconButton(
                  onPressed: () => print("click"),
                  icon: Icons.shopping_cart,
                  notification: 5),
            ],
          ),
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
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(3),
          hintText: widget.headerText,
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
          fillColor: _backgroundColorSearch,
        ),
      ),
    );
  }

  _buildIconButton({
    VoidCallback onPressed,
    IconData icon,
    Color color = Colors.white,
    int notification = 0,
  }) {
    return Stack(
      children: <Widget>[
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
          color: _colorIcon,
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

  // _backPageButton() {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.pop(context);
  //       // Navigate back to first route when tapped.
  //     },
  //     child: Container(
  //       width: 40,
  //       height: 20,
  //       alignment: Alignment.center,
  //       child: Icon(
  //         Icons.keyboard_backspace,
  //         size: 40,
  //       ),
  //     ),
  //   );
  // }



  void _onScroll() {
    final scrollOfset = widget.scrollController.offset;
    if(widget.scrollController.position.userScrollDirection == ScrollDirection.reverse && scrollOfset > 5){
      _opacity = double.parse((_opacity + _opacityMax).toStringAsFixed(2));

      if(_opacity >= 1.0 || scrollOfset > 200) {
        _opacity = 1.0;
      }
    }else if (scrollOfset < 100) {
      _opacity = double.parse((_opacity - _opacityMax).toStringAsFixed(2));
      if(_opacity <= 0.0) {
        _opacity = 0.0;
      }
    }

    setState(() {
      if(scrollOfset <= 0){
        _backgroundColorSearch = Colors.white;
        _opacity = 0.0;
      }else {
        _backgroundColorSearch = Colors.grey[200];
      }

      _backgroundColor = Color.fromRGBO(163, 106, 224, 1).withOpacity(_opacity);
    });
  }
}
