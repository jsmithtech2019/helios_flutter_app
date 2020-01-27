// Flutter Packages
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// Models

// Screens
import 'package:HITCH/screens/contact.dart';

// Utils
import 'package:HITCH/utils/database_helper.dart';


///#############################################################################
///
///#############################################################################

class HelpPage extends StatelessWidget {
  // Pull GetIt Singleton and create pointers to Singleton Helpers
  static GetIt sl = GetIt.instance;
  final DatabaseHelper dbHelper = sl.get<DatabaseHelper>();

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