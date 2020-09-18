import 'package:flutter/material.dart';
import 'package:Rocket_Elevator_Mobile/home/listElevator.dart';
import 'package:Rocket_Elevator_Mobile/home/getElevator.dart';
import 'package:Rocket_Elevator_Mobile/utilities/constants.dart';
import 'package:Rocket_Elevator_Mobile/app.dart';






class List extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    globalContext = context;
    return Scaffold(
      appBar: kappBar,
      body: Builder(builder: (context) {
        return Stack(
          children: <Widget>[
            kBGColor,
            Container(
              child: Column(
                children: [
                  //display list elevator button
                  Flexible(
                    flex: 1,
                    child: Center(
                      child: Container(
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () => 
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ListElevator()
                            )
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.white,
                          child: Text(
                            'List of inactive elevators',
                            style: TextStyle(
                              color: Color(0xFF527DAA),
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      ),
                    )
                  ),
                  //display get status elevator button
                  Flexible(
                    flex: 1,
                    child: Center(
                      child: Container(
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () => 
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => GetElevator()
                            )
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.white,
                          child: Text(
                            'Get status of elevator',
                            style: TextStyle(
                              color: Color(0xFF527DAA),
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ),
          ]
        );

      })
    );
  }
}