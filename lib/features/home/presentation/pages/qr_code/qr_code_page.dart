import 'package:flutter/material.dart';
import 'package:robo_app/features/home/presentation/pages/qr_code/widgets/header.dart';

class QrCodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          HeaderQrCode(),
          Container(
            width: 300,
            height: 300,
            child: Image.network(
                "https://www.kaspersky.com/content/en-global/images/repository/isc/2020/9910/a-guide-to-qr-codes-and-how-to-scan-qr-codes-2.png"),
          ),
          SizedBox(height: 20,),
          Text("Order No. : ORD22312",style: TextStyle(fontSize: 15),),
          SizedBox(height: 20,),
          Text("Order Date : 23/12/2020",style: TextStyle(fontSize: 15),),
          SizedBox(height: 20,),
          Text("Expire Date :  23/01/2021",style: TextStyle(fontSize: 15),), 
        ],
      ),
    );
  }
}
