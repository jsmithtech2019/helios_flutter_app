import 'package:flutter/material.dart';
import 'package:HITCH/contactpage.dart';

class TestingPage extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("H.I.T.C.H. Testing"),
      ),
      body: Column(
        children: <Widget>[
          new Text(""),
          new Text("Insert Customer Details:",
            style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
          ),
          new Text(""),
          new TextEntryField('Customer Phone Number'),
          new TextEntryField('Customer Truck License Plate'),
          new TextEntryField('Trailer License Plate'),
          new Text(""),
          new SizedBox(
            width: 200,
            height: 50,
            child: RaisedButton(
              child: Text("Begin Testing!"),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactPage()),
                );
              },
            ),
          ),
        ],
      )
    );
  }
}

class TextEntryField extends StatelessWidget {
  final String text;
  TextEntryField(this.text);

  Widget build(BuildContext context){
    return TextField(
      //controller: ,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        hintText: '$text',
      ),
    );
  }
}