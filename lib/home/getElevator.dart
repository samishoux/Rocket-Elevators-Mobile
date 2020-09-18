import 'dart:convert';
import 'package:Rocket_Elevator_Mobile/app.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Rocket_Elevator_Mobile/utilities/constants.dart';
class GetElevator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateGetElevator();
  }
}

class StateGetElevator extends State<GetElevator>  {
  final anotherController = TextEditingController();
  var _statusSelected = "Active";
  var display1 = "";
  var displayred = "";
  var displaygreen = "";
  var idElevatorSelected;
  bool _isVisible = false;
  bool _isVisible2 = false;

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
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(), 
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0, 
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Input the id if the Elevator',
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
                            controller: anotherController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top:14.0),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              hintText: "Id of Elevator",
                              hintStyle: kHintTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      width: double.infinity,
                      child: RaisedButton(
                        elevation: 5.0,
                        onPressed: () async {
                          try {
                            if(anotherController.text.length != 0) {
                              final res = await _callHttpRequest(anotherController.text);
                              setState(() {
                                this.idElevatorSelected = res['id'];
                                this.displayred = "";
                                this.displaygreen = "";
                              });
                              if(res != null) {
                                setState(() {
                                  this._isVisible = true;
                                  this._isVisible2 = true;
                                  this.display1 = "The status of Elevator number: ${res['id']} is ";
                                  this._statusSelected = res["status"];
                                  if(res['status'] != "Active") {
                                    this.displayred = "${res['status']}";
                                  }else {
                                    this.displaygreen = "${res['status']}";
                                  }
                                });
                              }else {
                                setState(() {
                                  this.display1 = "Sorry the Id you provided is ";
                                  this.displayred = "Invalid";
                                });
                              }
                            }
                            else {
                              setState(() {
                                this.display1 = "";
                                this.displayred = "Please provide an Id for the Elevator";
                                this._isVisible2 = false;
                                this.displaygreen = "";
                              });
                            }

                          }
                          catch (_) {
                            setState(() {
                              this.display1 = "Sorry there was an internal ";
                              this.displayred = "error";
                              this.displaygreen = "";
                            });
                          }
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
                    ),
                    Visibility(
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
                                  color: Colors.red[800],
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans',
                                  fontSize: 20,
                                ),
                              ),
                              TextSpan(
                                text: "$displaygreen",
                                style: TextStyle(
                                  color: Colors.green[800],
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans',
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        )
                      ),
                    ),
                    Visibility(
                      visible: _isVisible2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top:20, right: 10),
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            decoration: kBoxDecorationStyle,
                            child: DropdownButton<String>(
                              style: kLabelStyle,
                              dropdownColor: Colors.blue,
                              items: <String>['Active', 'Inactive', 'Intervention']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              value: _statusSelected,
                              onChanged: (String newValueSelected) {
                                setState(() {
                                  this._statusSelected = newValueSelected;
                                });
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top:20),
                            width: 110,
                            child: RaisedButton(
                              elevation: 5.0,
                              onPressed: () async {
                                await _modifyHttpRequest(this.idElevatorSelected, this._statusSelected);
                                setState(() {
                                  this.displaygreen = "";
                                  this.displayred = "";
                                  this.display1 = "The status of Elevator number: ${this.idElevatorSelected} is ";
                                  if(this._statusSelected != "Active") {
                                    this.displayred= "${this._statusSelected}";
                                  }else {
                                    this.displaygreen = "${this._statusSelected}";
                                  }
                                });
                                _buildSnackbar(context);

                              },
                              padding: EdgeInsets.all(12.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              color: Colors.white,
                              child: Text(
                                'Modify',
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}

_modifyHttpRequest(id,status) async {
  await http.post("https://imastuden.herokuapp.com/graphql?query=mutation%7B%0A%20%20updateElevator(input%3A%20%7B%0A%20%20%20%20id%3A%20"+id.toString()+"%0A%20%20%20%20status%3A%20%22"+status+"%22%0A%20%20%7D)%7B%0A%20%20%20%20id%0A%20%20%20%20status%0A%20%20%7D%0A%7D");
}

_buildSnackbar(context) {
  SnackBar mySackbar = SnackBar(
    content: Text(
      "The status was updated",
      style: kLabelStyle,
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.green,
    
    );
  Scaffold.of(context).showSnackBar(mySackbar);
}

_callHttpRequest(id) async {
  final response = await http.get("https://imastuden.herokuapp.com/graphql?query=%7B%0A%20%20elevators(id%3A%20$id)%20%7B%0A%20%20%20%20id%0A%20%20%20%20status%0A%20%20%7D%0A%7D%0A");
  final res = json.decode(response.body);
  return res['data']['elevators'];
}