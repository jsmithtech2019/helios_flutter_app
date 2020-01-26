import 'package:flutter/material.dart';
import 'package:HITCH/screens/contact.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Help"),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            children: <Widget>[
              new SizedBox(
                width: 200,
                height: 50,
                child: RaisedButton(
                  child: Text("Contact Us"),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContactPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}