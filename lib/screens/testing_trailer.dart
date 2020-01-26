import 'package:HITCH/screens/testing_complete.dart';
import 'package:flutter/material.dart';
import 'package:HITCH/models/database.dart';
import 'package:HITCH/utils/database_helper.dart';

class TrailerTestingPage extends StatelessWidget {
  final CustomerData custData;

  final DatabaseHelper helper = DatabaseHelper();

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
              PrintDatabaseResponses(helper, 'SELECT name FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1', 'Running test for Customer', 1.5),
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