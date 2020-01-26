import 'package:HITCH/screens/testing_complete.dart';
import 'package:HITCH/screens/testing_trailer.dart';
import 'package:flutter/material.dart';
import 'package:HITCH/models/database.dart';

class TruckTestingPage extends StatelessWidget {
  final TestData testData;

  TruckTestingPage({this.testData});

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
              Text('Customer Name: ${testData.custName}'),
              Text('Customer Phone: ${testData.custPhoneNumber}'),
              Text('Customer Email: ${testData.custEmail}'),
              Text('Customer Address Line 1: ${testData.custAddressLine1}'),
              Text('Customer Address Line 2: ${testData.custAddressLine2}'),
              Text('Customer City: ${testData.custCity}'),
              Text('Customer State: ${testData.custState}'),
              Text('Customer Zip Code: ${testData.custZipCode}'),
              Text('Truck License Plate: ${testData.truckLicensePlate}'),
              Text('Trailer License Plate: ${testData.trailerLicensePlate}'),
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
                            testData: testData,
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
                            testData: testData,
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