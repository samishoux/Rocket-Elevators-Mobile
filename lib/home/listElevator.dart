import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Rocket_Elevator_Mobile/utilities/constants.dart';
import 'dart:convert';


List<String> list = new List();



class ListElevator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewState();
  }
}

class NewState extends State<ListElevator>  {
  var result = _getListInactiveElevators();
  var res = ListMyWidgets();
  var _res = ["premier","deuxieme", "troisieme"];
  var _currentItemSelected = "premier";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kappBar,
      body: Builder(builder: (context) {
        return Stack(
          children: <Widget>[
            kBGColor,
            Container(
              child: Column(
                children: <Widget>[
                  DropdownButton<String>(
                    items: _res.map((dropDownStringItem) {
                      print(dropDownStringItem);

                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (String newValueSelected) {
                      print(res);
                      setState(() {
                        this._currentItemSelected = newValueSelected;
                      });
                    },
                    value: _currentItemSelected,
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


_getListInactiveElevators() async {
  list = [];
  final response = await http.get('https://imastuden.herokuapp.com/graphql?query=%7B%0A%20%20inactiveelevators%20%7B%0A%20%20%20%20id%0A%20%20%20%20status%0A%20%20%7D%0A%7D%0A');
  final res = json.decode(response.body);
  for (var i = 0; i < res['data']['inactiveelevators'].length; i++) {
    var elev = res['data']['inactiveelevators'][i];
    var id = elev['id'];
    // print(elev);
    list.add("Elevatornumber");
  }
}

List<String> ListMyWidgets() {
return list;
}

