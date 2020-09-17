import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Rocket_Elevator_Mobile/utilities/constants.dart';
final myController = TextEditingController();

class GetElevator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateGetElevator();
  }
}

class StateGetElevator extends State<GetElevator>  {
  var display1 = "";
  var displayred = "";
  var displaygreen = "";
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kappBar,
      body: Builder(builder: (context) {
        return Stack(
          children: <Widget>[
            kBGColor,
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(), 
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0, 
                  vertical: 120.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 30.0,
                    ),
                    SizedBox(
                          height: 30.0,
                        ),
                    _buildIdField(),
                    _buildSubmitBtn(context),
                    _displayInformation(),
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  

  _buildSubmitBtn(context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async { 
          final res = await _callHttpRequest(myController.text);

          setState(() {
            this._isVisible = true;
            this.display1 = "Elevator number: ${res['id']} \n Status: ";
            this.displaygreen = "";
            this.displayred = "";
            if(res['status'] != "Active") {
              this.displayred = "${res['status']}";
            }else {
              this.displaygreen = "${res['status']}";
            }
          });
          print(res);
          
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Submit',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  _buildIdField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Get the Status of an Elevator',
          style: kLabelStyle,
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: myController,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top:14.0, bottom:14.0, left:10),
              hintText: "Enter the Id of the Elevator",
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  _displayInformation() {
    return Visibility(
      visible: _isVisible,
      child: Container(
        margin: EdgeInsets.only(top:100),
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        decoration: kBoxDecorationStyle,
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text: "$display1", 
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                  ),
                ),
                TextSpan(
                  text: "$displayred",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                  ),
                ),
                TextSpan(
                  text: "$displaygreen",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}



_callHttpRequest(id) async {
  final response = await http.get("https://imastuden.herokuapp.com/graphql?query=%7B%0A%20%20elevators(id%3A%20$id)%20%7B%0A%20%20%20%20id%0A%20%20%20%20status%0A%20%20%7D%0A%7D%0A");
  final res = json.decode(response.body);
  return res['data']['elevators'];
}