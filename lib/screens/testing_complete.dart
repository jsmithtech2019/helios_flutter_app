/*
 * Texas A&M University
 * Electronic Systems Engineering Technology
 * ESET-420 Engineering Technology Senior Design II
 * File: testing_complete.dart
 * Author: Jack Smith (john.d.smitherton@tamu.edu)
 */

// Flutter Packages
import 'package:HITCH/models/bluetooth.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';

// Models
import 'package:HITCH/models/customer_data.dart';
import 'package:HITCH/models/trailer_data.dart';
import 'package:HITCH/models/truck_data.dart';

// Utils
import 'package:HITCH/utils/database_helper.dart';
import 'package:HITCH/utils/home_widget.dart';
import 'package:HITCH/utils/api_helper.dart';

/// Class for the TestingComplete page
/// 
/// Used to insert data into the [SQLite] database from the [CustomerData],
/// [TruckTestData] and [TrailerTestData] objects.
class TestingCompletePage extends StatelessWidget {
  /// Pull [DatabaseHelper] from [GetIt]
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();
  
  /// Pull [Logger] from [GetIt]
  final Logger logHelper = GetIt.instance<Logger>();

  /// Create local [CustomerData] object
  CustomerData custData;

  /// Initialize empty [TruckTestData] object 
  /// 
  /// May be overridden by optional variable from testing a truck that is passed
  /// to the testing complete page
  TruckTestData truckData = new TruckTestData.emptyConst();

  /// Initialize empty [TrailerTestData] object 
  /// 
  /// May be overridden by optional variable from testing a trailer that is passed
  /// to the testing complete page
  TrailerTestData trailerData = new TrailerTestData.emptyConst();

  /// Default constructor
  /// 
  /// Takes a [CustomerData] object and has two optional arguments for [TruckTestData]
  /// and [TrailerTestData] based on the testing that was run
  TestingCompletePage(CustomerData cd, [TruckTestData truckd, TrailerTestData trailerd]){
    // Update local variables
    this.custData = cd;
    if(truckd != null){
      this.truckData = truckd;
    }
    if(trailerd != null){
      this.trailerData = trailerd;
    }
  }

  /// Future object used to send data to DUET
  /// 
  /// Takes the data objects and attempts to send them to DUET of the dealership.
  /// Then displays the status code and message following upload to the user.
  Future<Set<Object>> syncData() async {
    // Call the server sync function (postRequest())
    var postResponse = await postRequest(custData, truckData, trailerData);

    // Validate response and return error and code or success and code
    return {postResponse.statusCode.toString(), postResponse.body};
  }

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
                ],
              ),
              RaisedButton(
                onPressed: () {
                  dbHelper.insertCustomerData(custData).then((custId){
                    dbHelper.insertTruckData(truckData, custId);
                    dbHelper.insertTrailerData(trailerData, custId);
                    globalHelper.customerData.customerId = custId;
                    globalHelper.lastTestId = custId;
                  });

                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => Home(0)),
                      (Route<dynamic> route) => false);
                }, // onPressed
                child: Text('Return to Home Page'),
              ),
              new FutureBuilder<Set<Object>>(
                future: syncData(),
                builder: (BuildContext context, AsyncSnapshot<Set<Object>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none: return new Text("Database Connection Failed!");
                    case ConnectionState.waiting: return new CircularProgressIndicator();
                    case ConnectionState.active: return new CircularProgressIndicator();
                    default:
                      if(snapshot.hasError){
                        return new Text("Error: ${snapshot.error}");
                      } else if(int.parse(snapshot.data.elementAt(0)) > 290){
                        // Got an error code, print error
                        return new Text("Warning, upload failure: ${snapshot.data.elementAt(1)} (${snapshot.data.elementAt(0)})");
                      } else {
                        // Got good response
                        //return new Text("Server Response: ${snapshot.data.elementAt(1)} (${snapshot.data.elementAt(0)})");
                        return new Text("DUET Upload Successful");
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