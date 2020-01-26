import 'package:flutter/material.dart';
import 'package:HITCH/models/forms.dart';

class CustomerPage extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("H.I.T.C.H. Testing"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              new Text(""),
              new Text("Insert Customer Details:",
                style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
              ),
              new Text(""),
              new MyCustomForm(),
              new Text(""),
            ],
          ),
        ),
    );
  }
}

class TextEntryField extends StatelessWidget {
  final String text;
  TextEntryField(this.text);

  Widget build(BuildContext context){
    return TextFormField(
      //controller: ,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        hintText: '$text',
      ),
    );
  }
}