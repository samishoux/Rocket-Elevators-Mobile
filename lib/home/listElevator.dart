import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Rocket_Elevator_Mobile/utilities/constants.dart';
import 'dart:convert';
import 'package:Rocket_Elevator_Mobile/app.dart';

GlobalKey _myKey;
List<String> list = new List();
var last;

class ListElevator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewState();
  }
}

class NewState extends State<ListElevator>  {
  var yes;
  void initState() {	
    super.initState();	
    yes = _getListInactiveElevators();	
  }	
  var res = ListMyWidgets();
  //init variable to display correctly
  var _statusSelected = "Active";
  var _currentItemSelected = "Select";
  var textDisplay1 = "Please Select an elevator";
  var textDisplayred = "";
  var textDisplaygreen = "";

  bool _isVisible = false;
  Widget build(BuildContext context) => FutureBuilder(
    future: yes,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        // Build the widget with data.
        var res = ListMyWidgets();
        globalContext = context;
        return Scaffold(
          appBar: kappBar,
          body: Builder(builder: (context) {
            return Stack(
              children: <Widget>[
                kBGColor,
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Column(
                        children: [
                          //dropdown button do display all of the elevator
                          Container(
                            margin: EdgeInsets.only(top:100),
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            decoration: kBoxDecorationStyle,
                            child: DropdownButton<String>(
                              style: kLabelStyle,
                              dropdownColor: Colors.blue,
                              items: res.map((dropDownStringItem) {
                                try {
                                  dropDownStringItem = dropDownStringItem.replaceAll("-", " ");
                                  return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Text(dropDownStringItem),
                                  );
                                }catch (_) {
                                }
                              }).toList(),
                              onChanged: (String newValueSelected) {
                                setState(() {
                                  this._isVisible = true;
                                  this._currentItemSelected = newValueSelected;
                                });
                                try {
                                  var e = int.tryParse(this._currentItemSelected.split(" ")[2]);
                                  for(var i = 0;i < last.length; i++) {
                                    if(last[i]['id'] == e) {
                                      var status = last[i]["status"];
                                      //show element with the last inside the thing please :D
                                      textDisplay1 = "Elevator number: $e \n\n Status: ";
                                      textDisplaygreen = "";
                                      textDisplayred = "";
                                      if(status != "Active") {
                                        textDisplayred = "$status";
                                      }else {
                                        textDisplaygreen = "$status";
                                      }
                                      this._statusSelected = last[i]['status'];
                                    }
                                  }
                                }catch (_) {
                                  setState(() {
                                    this._isVisible = false;
                                    
                                  });
                                  textDisplay1 = "Please Select an elevator";
                                }
                              },
                              value: _currentItemSelected,
                            ),
                          ),
                          //display text of informations
                          Container(
                            margin: EdgeInsets.only(top:100),
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            decoration: kBoxDecorationStyle,
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "$textDisplay1", 
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'OpenSans',
                                        fontSize: 20,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "$textDisplayred",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'OpenSans',
                                        fontSize: 20,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "$textDisplaygreen",
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
                          Visibility(
                            visible: _isVisible,
                            child: Row(
                              key: _myKey,
                              children: [
                                // status selector
                                Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top:100),
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
                                  ],
                                ),
                                //submit button
                                Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top:100),
                                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                                      child: RaisedButton(
                                        elevation: 5.0,
                                        onPressed: () async {
                                          var status = this._statusSelected;
                                          var e = this._currentItemSelected.split(" ")[2];
                                          await _callSomething(e, status);
                                          if(this._statusSelected != "Active") {
                                            setState(() { 
                                              textDisplay1 = "Elevator number: $e \n\n Status: ";
                                              textDisplaygreen = "";
                                              textDisplayred = "";
                                              if(status != "Active") {
                                                textDisplayred = "$status";
                                              }else {
                                                textDisplaygreen = "$status";
                                              }
                                            });
                                          }else {
                                            setState(() { 
                                              textDisplaygreen = "";
                                              textDisplayred = "";
                                              this._isVisible = false;
                                              this._currentItemSelected = "Select";
                                              textDisplay1 = "Please Select an elevator";
                                            });
                                          }
                                          _buildSnackbar(context);
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ]
                      ),
                    ],
                  ),
                ),
              ]
            );
          })
        );
      } else {
        // We can show the loading view until the data comes back.
        return CircularProgressIndicator();
      }
    },
  );
}

//tell the user that the status is updated
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

//post the data 
_callSomething(e, status)async{
  await http.post("https://imastuden.herokuapp.com/graphql?query=mutation%7B%0A%20%20updateElevator(input%3A%7B%0A%20%20%20%20id%3A%20"+e+"%0A%20%20%20%20status%3A%20%22"+status+"%22%0A%20%20%7D)%7B%0A%20%20%20%20id%0A%20%20%20%20status%0A%20%20%7D%0A%7D");
  await _getListInactiveElevators();
}

//retreive a list of elevator
Future<bool> _getListInactiveElevators() async {
  list.clear();
  list.add("Select");
  final response = await http.get('https://imastuden.herokuapp.com/graphql?query=%7B%0A%20%20inactiveelevators%20%7B%0A%20%20%20%20id%0A%20%20%20%20status%0A%20%20%7D%0A%7D%0A');
  final res = json.decode(response.body);
  last = res['data']['inactiveelevators'];
  for (var i = 0; i < res['data']['inactiveelevators'].length; i++) {
    var elev = res['data']['inactiveelevators'][i];
    var id = elev['id'];
    list.add("Elevator-Number:-$id");
  }
  return true;
}

//get that said list
List<String> ListMyWidgets() {
return list;
}

