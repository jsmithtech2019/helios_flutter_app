import 'package:HITCH/screens/testing_complete.dart';
import 'package:HITCH/screens/testing_trailer.dart';
import 'package:flutter/material.dart';
import 'package:HITCH/models/database.dart';
import 'package:HITCH/utils/database_helper.dart';

class TruckTestingPage extends StatelessWidget {
  final CustomerData custData;

  final DatabaseHelper helper = DatabaseHelper();

  TruckTestingPage({this.custData});

  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Truck Testing"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Text('Customer Name: ${custData.customerName}'),
              FutureBuilder<String>(
                  future: helper.executeFormattedQuery("email", "TESTING_DATA", "2")
                      .then((resp){return resp[0].values.toList()[0];}),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                    switch (snapshot.connectionState) {
                      case ConnectionState.none: return new Text('Didn\'t Work!');
                      case ConnectionState.waiting: return new Text('Awaiting result!');
                      default:
                        if(snapshot.hasError){
                          return new Text('Error: ${snapshot.error}');
                        } else {
                          return new Text('Email from Database: ${snapshot.data}');
                        }
                    }
                  }
              ),
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
                          builder: (context) => TestingCompletePage(
                            custData: custData,
                          ),
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