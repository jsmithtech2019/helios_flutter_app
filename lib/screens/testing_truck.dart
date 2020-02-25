// Flutter Packages
import 'package:HITCH/models/global.dart';
import 'package:HITCH/models/print.dart';
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
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();
  final GlobalHelper globalHelper = GetIt.instance<GlobalHelper>();

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
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //PrintDatabaseResponses('SELECT name FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1', 'Testing for customer', 20),
              Text("Testing for customer: ${globalHelper.customerName}", 
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic
                )
              ),
              //PrintDatabaseResponses('SELECT phone FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1', 'Phone number from db', 20),
              SizedBox(height: 15),
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
                          builder: (context) => TestingCompletePage(custData),
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
