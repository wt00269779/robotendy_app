import 'package:flutter/material.dart';
import 'package:robo_app/features/home/presentation/pages/qr_code/qr_code_page.dart';

class NavigatorBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          children: [
            _buildTabItem(text: "Send To Cart", index: 0, context: context),
            _buildTabItem(text: "Buy", index: 1, context: context),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({String text, int index, BuildContext context}) {
    return SizedBox(
      height: 55,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            print("SELECTED " + index.toString());
          },
          child: InkWell(
            onTap: () {
              if(index == 1) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) =>  QrCodePage()),
                );
              }
            },
            child: Container(
              color: index == 0 ? Colors.green : Colors.red,
              width: index == 0
                  ? MediaQuery.of(context).size.width * 0.3
                  : MediaQuery.of(context).size.width * 0.7,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                ],
              ),
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
