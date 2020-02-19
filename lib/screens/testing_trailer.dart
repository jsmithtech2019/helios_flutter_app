// Flutter Packages
import 'package:HITCH/models/print.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// Models
import 'package:HITCH/models/database.dart';
//import 'package:HITCH/models/seperator.dart';

// Screens
import 'package:HITCH/screens/testing_complete.dart';

// Utils
import 'package:HITCH/utils/database_helper.dart';


///#############################################################################
///
///#############################################################################

class TrailerTestingPage extends StatelessWidget {
  // Pull GetIt Singleton and create pointers to Singleton Helpers
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();

  final CustomerData custData;

  TrailerTestingPage({this.custData});

  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Trailer Testing"),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  PrintDatabaseResponses('SELECT name FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1', 'Running test for Customer', 20),
                ],
              ),
              SizedBox(height: 15),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TestingCompletePage(custData),
                    ),
                  );
                }, // onPressed
                child: Text('Finish Testing'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}