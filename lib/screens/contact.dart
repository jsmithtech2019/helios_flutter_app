/*
 * Texas A&M University
 * Electronic Systems Engineering Technology
 * ESET-420 Engineering Technology Senior Design II
 * File: contact.dart
 * Author: Jack Smith (john.d.smitherton@tamu.edu)
 */

// Flutter Packages
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

// Utils
import 'package:HITCH/utils/database_helper.dart';

// Models
import 'package:HITCH/models/seperator.dart';

/// Widget for the contact page
/// 
/// Contains the employee information such as email addresses and contact info
/// for Helios team members. These are links that the user can click to open
/// a message to us.
class ContactPage extends StatelessWidget {
  /// [GetIt] singleton for [DatabaseHelper]
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();

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
              new NamePlates("Helios Team", "", "(713) 898-3810", "helioscapstone@gmail.com", "helioslogo.png", "7138983810"),
              new SeparatorBox("Our Team"),
              new NamePlates("Jonathan Smith", "Software Engineer", "(303) 801-8528", "john.d.smitherton@tamu.edu", "jack_header.jpg", "3038018528"),
              new NamePlates("Christian Ledgard", "Project Manager", "(713) 898-3810", "christian.ledgard@tamu.edu", "christian_header.jpg", "7138983810"),
              new NamePlates("Kenley Pang", "Hardware Engineer", "(979) 571-5010", "kenleypang@tamu.edu", "kenley_header.jpg", "9795715010"),
              new NamePlates("Diego Espina", "Test/Integration Engineer", "(979) 574-7193", "diegoespina7@tamu.edu", "diego_header.jpg", "9795747193"),
            ],
          )
        ),
      ),
    );
  }
}

/// The nameplate objects for each developer
/// 
/// Creates a pretty object for each developer with useful information
class NamePlates extends StatelessWidget {
  final String name, role, phone, email, image, phoneclean;
  NamePlates(this.name, this.role, this.phone, this.email, this.image, this.phoneclean);

  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(
            maxHeight: 250,
            maxWidth: 200,
            minHeight: 120,
            minWidth: 100,
          ),
          margin: new EdgeInsets.only(left: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text(name,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              new Text(role,
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
              ),
              new GestureDetector(
                onTap: (){
                  _sendMessage();
                },
                child: new Text(phone,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ),
              new GestureDetector(
                onTap: (){
                  _sendEmail();
                },
                child: new Text(email,
                  style: TextStyle(
                    fontSize: 13,
                  ),
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

  /// Open the messaging app with a draft to the specified number
  _sendMessage() async {
    String uri = 'sms:$phoneclean';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not text $uri';
    }
  }

  /// Open the email client with a draft to the specified address
  _sendEmail() async {
    String uri = 'mailto:$email';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not email $uri';
    }
  }
}
