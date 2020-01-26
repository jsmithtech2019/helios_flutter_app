import 'package:HITCH/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:HITCH/models/database.dart';

class ResultsPage extends StatefulWidget {
  final TestData testData;
  ResultsPage({this.testData});

  @override
  State<StatefulWidget> createState() {
    return ResultsPageState(this.testData);
  }
}

class ResultsPageState extends State<ResultsPage> {
  DatabaseHelper helper = DatabaseHelper();

  // Pass customer data into this state
  final TestData testData;
  ResultsPageState(this.testData);

  @override
  Widget build (BuildContext context) {
    // TESTING
//    helper.initializeDatabase();
//    helper.getCount();
//    //helper.insertTestData(customerData);
//    helper.insertTestData(testData);
//    helper.getCount();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Test Results"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Text("Results Text",
                style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.0),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}