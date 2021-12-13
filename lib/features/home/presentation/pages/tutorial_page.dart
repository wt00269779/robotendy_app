import 'package:flutter/material.dart';
import 'package:robo_app/core/services/local_storage_service.dart';
import 'package:robo_app/features/home/presentation/pages/main/initial_page.dart';

class TutorialPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(45.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Tutorial Page', style: TextStyle(fontSize: 20.0),),
              SizedBox(height: 30.0,),
              _startApp(context),
            ],
          ),
      ),
    );
  }

  _startApp(context) {
    
    return InkWell(
      onTap: () async {
        await LocalStorageService.putString("firstStartApp", "false");
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => InitailPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromRGBO(100, 100, 100, 1),
                  Color.fromRGBO(50, 50, 50, 1)
                ])),
        child: Text(
          'เข้าสู่ระบบ',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
