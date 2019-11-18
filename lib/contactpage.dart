import 'package:flutter/material.dart';
class ContactPage extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Contact Us"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              new SeparatorBox("General Inquiries"),
              new NamePlates("Helios Team", "", "(713) 898-3810", "helioscapstone@gmail.com", "helioslogo.png"),

              new SeparatorBox("Our Team"),
              new NamePlates("Christian Ledgard", "Project Manager", "(713) 898-3810", "christianledgard@tamu.edu", "christian_header.jpg"),
              new NamePlates("Kenley Pang", "Hardware Engineer", "(979) 571-5010", "kenleypang@tamu.edu", "kenley_header.jpg"),
              new NamePlates("Jonathan Smith", "Software Engineer", "(303) 801-8528", "john.d.smitherton@tamu.edu", "jack_header.jpg"),
              new NamePlates("Diego Espina", "Test/Integration Engineer", "(979) 574-7193", "diegoespina@tamu.edu", "diego_header.jpg"),
            ],
          )
        ),
        //),
      ),
    );
  }
}

class NamePlates extends StatelessWidget {
  String name, role, phone, email, image;
  NamePlates(this.name, this.role, this.phone, this.email, this.image);

  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          margin: new EdgeInsets.only(left: 40.0),
          height: 200,
          width: 175,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text(name,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              new Text(role,
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
              ),
              new Text(phone,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              new Text(email,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Image.asset("assets/images/$image",
            width: 150, height: 150,
          ),
        ),
      ],
    );
  }
}

class SeparatorBox extends StatelessWidget {
  final String text;
  SeparatorBox(this.text);

  Widget build(BuildContext context){
    return Container(
      color: Colors.blueGrey[800],
      alignment: Alignment.centerLeft,
      height: 75,
      child: Text("     $text:",
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}