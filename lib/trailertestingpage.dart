import 'package:HITCH/testingcompletepage.dart';
import 'package:flutter/material.dart';
import 'package:HITCH/datastorage.dart';

class TrailerTestingPage extends StatelessWidget {
  final CustomerData customerData;

  TrailerTestingPage({this.customerData});

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
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TestingCompletePage(
                        customerData: customerData,
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