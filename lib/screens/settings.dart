// Flutter Packages
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// Utils
import 'package:HITCH/utils/database_helper.dart';


///#############################################################################
///
///#############################################################################

class SettingsPage extends StatelessWidget {
  // Pull GetIt Singleton and create pointers to Singleton Helpers
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();

  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Settings"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Text("Placeholder widget"),
            ],
          ),
        ),
      ),
    );
  }
}