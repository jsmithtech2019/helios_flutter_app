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
import 'package:HITCH/utils/api_helper.dart';


///#############################################################################
///
///#############################################################################

class TestingCompletePage extends StatelessWidget {
  // Pull GetIt Singleton and create pointers to Singleton Helpers
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();
  final Logger logHelper = GetIt.instance<Logger>();
  CustomerData custData;
  TruckTestData truckData = new TruckTestData(-1, -1, -1, -1, 0, 0, 0, 0); // result[4], current[4]
  TrailerTestData trailerData = new TrailerTestData(-1, -1, -1, -1, 0, 0, 0, 0); // result[4], current[4]

  TestingCompletePage(CustomerData cd, [TruckTestData truckd, TrailerTestData trailerd]){
    this.custData = cd;
    if(truckd != null){
      this.truckData = truckd;
    }
    if(trailerd != null){
      this.trailerData = trailerd;
    }
  }

  Future<Set<Object>> syncData(CustomerData custData, [TruckTestData truckData, TrailerTestData trailerData]) async {
    TestingCompletePage td = new TestingCompletePage(custData, truckData, trailerData);
    // Send cust data to the database
    var custInsert = await dbHelper.insertCustomerData(custData);

    // Get cust data ID from database
    var custID = await dbHelper.executeRawQuery('SELECT id FROM CUSTOMER_DATA WHERE name="${custData.customerName}" ORDER BY timestamp DESC LIMIT 1');
    
    // Send truck data to db with custID
    await dbHelper.executeRawQuery('INSERT INTO TRUCK_TEST_DATA (customerid, test1_result, test1_current, test2_result, test2_current, test3_result, test3_current, test4_result, test4_current) VALUES (${custID[0]['id']}, ${td.truckData.truckTest1Result}, ${td.truckData.truckTest1Current}, ${td.truckData.truckTest2Result}, ${td.truckData.truckTest2Current}, ${td.truckData.truckTest3Result}, ${td.truckData.truckTest3Current}, ${td.truckData.truckTest4Result}, ${td.truckData.truckTest4Current})');

    // Send trailer data to DB with custID
    await dbHelper.executeRawQuery('INSERT INTO TRAILER_TEST_DATA (customerid, test1_result, test1_current, test2_result, test2_current, test3_result, test3_current, test4_result, test4_current) VALUES (${custID[0]['id']}, ${td.trailerData.trailerTest1Result}, ${td.trailerData.trailerTest1Current}, ${td.trailerData.trailerTest2Result}, ${td.trailerData.trailerTest2Current}, ${td.trailerData.trailerTest3Result}, ${td.trailerData.trailerTest3Current}, ${td.trailerData.trailerTest4Result}, ${td.trailerData.trailerTest4Current})');

    // Call the server sync function (postRequest())
    var postResponse = await postRequest(custData);

    // Validate response and return error and code or success and code
    return {postResponse.statusCode.toString(), postResponse.body};
  }

  @override
  Widget build (BuildContext context) {
    var page = TestingCompletePage(custData);
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
              new FutureBuilder<Set<Object>>(
                future: page.syncData(custData),
                builder: (BuildContext context, AsyncSnapshot<Set<Object>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none: return new Text("Database Connection Failed!");
                    case ConnectionState.waiting: return new CircularProgressIndicator();
                    case ConnectionState.active: return new CircularProgressIndicator();
                    default:
                      if(snapshot.hasError){
                        return new Text("Error: ${snapshot.error}");
                      } else if(int.parse(snapshot.data.elementAt(0)) > 290){
                        // Got an error code
                        return new Text("Warning, upload failure: ${snapshot.data.elementAt(1)} (${snapshot.data.elementAt(0)})");
                      } else {
                        // Got good response
                        return new Text("Server Response: ${snapshot.data.elementAt(1)} (${snapshot.data.elementAt(0)})");
                      }
                  }
                }
              ),
              // new FutureBuilder<List<String>>(
              //   future: dbHelper.getCustomerNamesList(),
              //   initialData: List<String>(),
              //   builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
              //     switch (snapshot.connectionState) {
              //       case ConnectionState.none: return new Text("Database Connection Failed!");
              //       case ConnectionState.waiting: return new CircularProgressIndicator();
              //       case ConnectionState.active: return new CircularProgressIndicator();
              //       default:
              //         if(snapshot.hasError){
              //           return new Text("Error: ${snapshot.error}");
              //         } else {
              //           //return CircularProgressIndicator();
              //           return DropdownButton<String>(
              //             items: snapshot.data.map((String val) {
              //               return new DropdownMenuItem<String>(
              //                 value: val,
              //                 child: new Text(val.toString()),
              //               );
              //             }).toList(),
              //             onChanged: (_){},
              //           );
              //         }
              //       }
              //     }
              // ),
            ],
          ),
        ),
      ),
    );
  }
}