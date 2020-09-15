import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Rocket_Elevator_Mobile/utilities/constants.dart';


class ChangeElevator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kappBar,
      body: Builder(builder: (context) {
        return Stack(
          children: <Widget>[
            kBGColor,
            Container(
              child: Column(
                children: [
                  Text("change elevator page")
                ],
              ),
            ),
          ]
        );
      })
    );
  }
}