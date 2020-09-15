
import 'package:Rocket_Elevator_Mobile/app.dart';
import 'package:flutter/material.dart';
import 'package:Rocket_Elevator_Mobile/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'list.dart';

final myController = TextEditingController();

class Home extends StatelessWidget {
  //email input field
  _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
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
              hintText: "Enter your Email",
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
  
  

  _buildLoginBtn(context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => _callHttpRequest(myController.text, context),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
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
                    Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white, 
                        fontFamily: 'OpenSans', 
                        fontSize: 30.0, 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    SizedBox(
                          height: 30.0,
                        ),
                    _buildEmailField(),
                    _buildLoginBtn(context),
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

_buildSnackbar(context) {
    SnackBar mySackbar = SnackBar(
      content: Text(
        "Invalid email please try again!",
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red[900],
      
      );
    Scaffold.of(context).showSnackBar(mySackbar);
}

_callHttpRequest(email, context) async {
  final response = await http.get('https://imastuden.herokuapp.com/graphql?query=query%20%7B%0A%20%20checkExsitingEmployee(email%3A%20%22' + email + '%22)%20%7Bid%20email%7D%0A%7D');
  final res = json.decode(response.body);
  myController.text = "";
  if(res['data']['checkExsitingEmployee'] == null) {
    //tell the user he has the wrong email :D
    _buildSnackbar(context);
  }else {
    //tell the user he is good to go and change the view
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => List()
      )
    );
  }
}