// Flutter Packages
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// Models
import 'package:HITCH/models/database.dart';

// Screens
import 'package:HITCH/screens/testing_complete.dart';
import 'package:HITCH/screens/testing_trailer.dart';

// Utils
import 'package:HITCH/utils/database_helper.dart';


///#############################################################################
///
///#############################################################################

class TruckTestingPage extends StatelessWidget {
  // Pull GetIt Singleton and create pointers to Singleton Helpers
  static GetIt sl = GetIt.instance;
  final DatabaseHelper dbHelper = sl.get<DatabaseHelper>();

  final CustomerData custData;

  TruckTestingPage({this.custData});

  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Truck Testing"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              PrintDatabaseResponses(dbHelper, 'SELECT name FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1', 'Testing for customer', 1.5),
              PrintDatabaseResponses(dbHelper, 'SELECT phone FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1', 'Phone number from db', 1.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrailerTestingPage(
                            custData: custData,
                          ),
                        ),
                      );
                    }, // onPressed
                    child: Text('Begin Trailer Testing'),
                  ),
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
                    child: Text('End Testing'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
