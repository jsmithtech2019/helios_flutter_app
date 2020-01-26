import 'package:HITCH/screens/testing_complete.dart';
import 'package:flutter/material.dart';
import 'package:HITCH/models/database.dart';

class TrailerTestingPage extends StatelessWidget {
  final TestData testData;

  TrailerTestingPage({this.testData});

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
              Text('Customer Name: ${testData.custName}'),
              Text('Customer Phone: ${testData.custPhoneNumber}'),
              Text('Customer Email: ${testData.custEmail}'),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TestingCompletePage(
                        testData: testData,
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