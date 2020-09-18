import 'package:flutter/material.dart';
import 'package:Rocket_Elevator_Mobile/app.dart';

//some text styling used in some places
final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

//some text styling used in some places
final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

//global app bar used everywere
final kappBar = AppBar(
  title: Text("Rocket Elevator Mobile App"),
  actions: <Widget> [
    IconButton(
      icon: const Icon(Icons.logout),
      tooltip: 'Logout',
      onPressed: () {
        try{
          Navigator.popUntil(globalContext, ModalRoute.withName('/'));
        }
        catch(_) {}
      },
    ),
    Image.asset(
      "images/R2.png"
    ),
  ]
);


//box decoration unsed in some places
final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

//background color used everywhere
final kBGColor = Container(
  height: double.infinity, 
  width: double.infinity, 
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF73AEF5),
        Color(0xFF61A4F1),
        Color(0xFF478DE0),
        Color(0xFF398AE5),
      ],
      stops: [0.1,0.4,0.7,0.9],
    ),
  ),
);