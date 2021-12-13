import 'package:flutter/material.dart';

class HeaderQrCode extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<HeaderQrCode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Color.fromRGBO(163, 106, 224, 1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          bottom: false,
          child: Row(
            children: <Widget>[
              _buildBackSpace(),
              _buildText(),
            ],
          ),
        ),
      ),
    );
  }

  _buildText() {
    return Container(
      margin: EdgeInsets.all(8),
      child: Text(
        "QR Code",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w900
        ),
      ),
    );
  }

  _buildBackSpace() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        // Navigate back to first route when tapped.
      },
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        child: Icon(
          Icons.keyboard_backspace,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
