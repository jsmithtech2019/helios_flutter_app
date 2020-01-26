import 'package:flutter/material.dart';
import 'package:HITCH/utils/home_widget.dart';
import 'package:HITCH/models/database.dart';
import 'package:HITCH/utils/database_helper.dart';

class TestingCompletePage extends StatelessWidget {
  final DatabaseHelper helper = DatabaseHelper();

  final CustomerData custData;

  TestingCompletePage({this.custData});

  @override
  Widget build (BuildContext context) {
    //helper.initializeDatabase().then((onValue){print("Done initializing");});
    //String oldCount = helper.getCount().toString();
    //helper.insertTestData(customerData);
    //testData.ID = 2;

    //testData.custEmail = "john.d.smitherton@tamu.edu";
    //testData.custState = "Colorado";
    //helper.insertTestData(custData);
    //helper.updateTestData(testData);
    //helper.deleteTestData(5);
    //testData.ID = null;
    //helper.updateTestData(custData);

    //helper.deleteTestData(25);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Testing Complete!"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Text('Testing completed successfully, please move to the results'
                  ' tab to view test results.'),
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
              FutureBuilder<String>(
                  future: helper.executeRawQuery('SELECT name FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1')
                      .then((onValue){return onValue[0].values.toList()[0];}),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                    switch (snapshot.connectionState) {
                      case ConnectionState.none: return new Text('Didn\'t Work!');
                      case ConnectionState.waiting: return new Text('Awaiting result!');
                      default:
                        if(snapshot.hasError){
                          return new Text('Error: ${snapshot.error}');
                        } else {
                          return new Text('Name from Database: ${snapshot.data}',
                              style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0));
                        }
                    }
                  }
              ),
              FutureBuilder<String>(
                  future: helper.executeRawQuery("SELECT email FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1")
                      .then((resp){return resp[0].values.toList()[0];}),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                  switch (snapshot.connectionState) {
                    case ConnectionState.none: return new Text('Didn\'t Work!');
                    case ConnectionState.waiting: return new Text('Awaiting result!');
                    default:
                      if(snapshot.hasError){
                        return new Text('Error: ${snapshot.error}');
                      } else {
                        return new Text('Email from Database: ${snapshot.data}',
                            style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0));
                      }
                  }
                }
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => Home(
                            //testData: testData,
                          )
                      ),
                          (Route<dynamic> route) => false);
                }, // onPressed
                child: Text('Return to Home Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}