import 'package:HITCH/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:HITCH/models/database.dart';

class ResultsPage extends StatefulWidget {
  final CustomerData custData;
  ResultsPage({this.custData});

  @override
  State<StatefulWidget> createState() {
    return ResultsPageState(this.custData);
  }
}

class ResultsPageState extends State<ResultsPage> {
  DatabaseHelper helper = DatabaseHelper();

  // Pass customer data into this state
  final CustomerData custData;
  ResultsPageState(this.custData);

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
              Text("Showing most recent test result",
                style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.0),
              ),
              FutureBuilder<String>(
                  future: helper.executeRawQuery("SELECT name FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1")
                      .then((resp){return resp[0].values.toList()[0];}),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                    switch (snapshot.connectionState) {
                      case ConnectionState.none: return new Text('Didn\'t Work!');
                      case ConnectionState.waiting: return new Text('Awaiting result!');
                      default:
                        if(snapshot.hasError){
                          return new Text('Error: ${snapshot.error}');
                        } else {
                          return new Text('Customer Name: ${snapshot.data}',
                            style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0));
                        }
                    }
                  }
              ),
              FutureBuilder<String>(
                future: helper.executeRawQuery("SELECT truckplate FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1")
                    .then((resp){return resp[0].values.toList()[0];}),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                  switch (snapshot.connectionState) {
                    case ConnectionState.none: return new Text('Didn\'t Work!');
                    case ConnectionState.waiting: return new Text('Awaiting result!');
                    default:
                      if(snapshot.hasError){
                        return new Text('Error: ${snapshot.error}');
                      } else {
                        return new Text('Truck License Plate: ${snapshot.data}',
                            style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0));
                      }
                  }
                }
              ),
              FutureBuilder<String>(
                future: helper.executeRawQuery("SELECT trailerplate FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1")
                    .then((resp){return resp[0].values.toList()[0];}),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                  switch (snapshot.connectionState) {
                    case ConnectionState.none: return new Text('Didn\'t Work!');
                    case ConnectionState.waiting: return new Text('Awaiting result!');
                    default:
                      if(snapshot.hasError){
                        return new Text('Error: ${snapshot.error}');
                      } else {
                        return new Text('Trailer License Plate: ${snapshot.data}',
                            style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0));
                      }
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}