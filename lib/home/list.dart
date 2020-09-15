import 'package:flutter/material.dart';
import 'package:Rocket_Elevator_Mobile/home/listElevator.dart';
import 'package:Rocket_Elevator_Mobile/home/getElevator.dart';
import 'package:Rocket_Elevator_Mobile/home/changeElevator.dart';
import 'package:Rocket_Elevator_Mobile/utilities/constants.dart';






class List extends StatelessWidget {
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
                  _buildLoginBtn("List of inactive elevators", context, ListElevator()),
                  _buildLoginBtn("Get status of elevator", context, GetElevator()),
                  _buildLoginBtn("Change status of elevator", context, ChangeElevator()),
                ],
              ),
            ),
            
            // Padding(padding: EdgeInsets.all(16.0)),
            // _buildLoginBtn("allo", context),
            // _buildLoginBtn("allo", context),
          ]
        );

      })
    );
  }
}




//template for the buttons
_buildLoginBtn(title, context, pageName) {
  return Center(
    
    child: Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.17),
      width: MediaQuery.of(context).size.width * 0.70,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => 
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => pageName
          )
        ),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          '$title',
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
  );
}





