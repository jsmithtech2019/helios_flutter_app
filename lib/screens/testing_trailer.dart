import 'package:HITCH/screens/testing_complete.dart';
import 'package:flutter/material.dart';
import 'package:HITCH/models/database.dart';

class TrailerTestingPage extends StatelessWidget {
  final CustomerData custData;

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
              Text('Customer Name: ${custData.customerName}'),
              Text('Customer Phone: ${custData.customerPhoneNumber}'),
              Text('Customer Email: ${custData.customerEmail}'),
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