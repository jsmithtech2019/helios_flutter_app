// Flutter Packages
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// Models
import 'package:HITCH/models/database.dart';

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
          child: Column(
            children: <Widget>[
              Text('I guess we start trailer testing now?'),
              PrintDatabaseResponses(dbHelper, 'SELECT name FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1', 'Running test for Customer', 1.5),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TestingCompletePage(
                        custData: custData,
                      ),
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