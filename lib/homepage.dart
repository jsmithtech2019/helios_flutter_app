import 'package:HITCH/contactpage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home Page"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Text("Hello",
                style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 3.0),
              ),
              Text("World!",
                style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 3.0),
              ),
              RaisedButton(
                child: Text("To Contact Us"),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}