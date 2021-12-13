import 'package:flutter/material.dart';

class TextHeader extends StatelessWidget {
  final String prefixText;
  final String suffixText;
  final Widget changePage;

  const TextHeader(
      {Key key,
      @required this.prefixText,
      this.suffixText = '',
      this.changePage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              prefixText,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        suffixText == ''
            ? SizedBox()
            : InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => changePage,
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    suffixText,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
