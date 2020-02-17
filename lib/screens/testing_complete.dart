// Flutter Packages
import 'package:get_it/get_it.dart';
//import 'dart:io';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';

// Models
import 'package:HITCH/models/database.dart';

// Utils
import 'package:HITCH/utils/database_helper.dart';
import 'package:HITCH/utils/home_widget.dart';


///#############################################################################
///
///#############################################################################

class TestingCompletePage extends StatelessWidget {
  // Pull GetIt Singleton and create pointers to Singleton Helpers
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();
  final Logger logHelper = GetIt.instance<Logger>();
  final CustomerData custData;
  final List<Map<String, dynamic>> nameList;

  TestingCompletePage({this.custData, this.nameList});

  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Testing Complete!"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Testing completed successfully, please move to the results'
                        ' tab to view test results.',
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(height: 15),
                  /*
                   * This whole function is critical for reading from async function
                   * calls to the SQLite database. The FutureBuilder class reads
                   * on a AsyncSnapshot state that branches either waiting, error,
                   * success or none response. This will need to be called whenever
                   * data is needed to be read from the database and displayed on
                   * the screen prior to drawing.
                   *
                   * Context: https://stackoverflow.com/questions/49930180/flutter-render-widget-after-async-call
                   */
                  PrintDatabaseResponses(dbHelper,
                      'SELECT name FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1',
                      'Name from Database', 20),
                  PrintDatabaseResponses(dbHelper,
                      'SELECT email FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1',
                      'Email from Database', 20),
                ],
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => Home(0)),
                          (Route<dynamic> route) => false);
                }, // onPressed
                child: Text('Return to Home Page'),
              ),
              new FutureBuilder<List<String>>(
                  future: dbHelper.getCustomerNamesList(),
                  initialData: List<String>(),
                  builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none: return new Text("Database Connection Failed!");
                      case ConnectionState.waiting: return new CircularProgressIndicator();
                      case ConnectionState.active: return new CircularProgressIndicator();
                      default:
                        if(snapshot.hasError){
                          return new Text("Error: ${snapshot.error}");
                        } else {
                          //return CircularProgressIndicator();
                          return DropdownButton<String>(
                            items: snapshot.data.map((String val) {
                              return new DropdownMenuItem<String>(
                                value: val,
                                child: new Text(val),
                              );
                            }).toList(),
                            onChanged: (_){},
                          );
                        }
                    }
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}