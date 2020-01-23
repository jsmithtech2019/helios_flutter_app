import 'package:HITCH/customerdetails.dart';
import 'package:HITCH/resultspage.dart';
import 'package:flutter/material.dart';
import 'package:HITCH/home_widget.dart';
import 'package:HITCH/datastorage.dart';

class TestingCompletePage extends StatelessWidget {
  final CustomerData customerData;

  TestingCompletePage({this.customerData});

  @override
  Widget build (BuildContext context) {
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
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => Home(
                            customerData: customerData,
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