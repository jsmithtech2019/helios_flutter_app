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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Text("Showing test result for:",
                style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child:  PrintDatabaseResponses(helper, 'SELECT name FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1', 'Name from Database', 1.15),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: PrintDatabaseResponses(helper, 'SELECT truckplate FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1', 'Truck from Database', 1.15),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: PrintDatabaseResponses(helper, 'SELECT trailerplate FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1', 'Trailer from Database', 1.15),
              ),
              TruckResults(),
              TrailerResults(),
            ],
          ),
        ),
      ),
    );
  }
}

class TruckResults extends StatelessWidget {
  DatabaseHelper helper = DatabaseHelper();

  Widget build(BuildContext context){
    return new Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.fromLTRB(24, 24, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Truck test result 1
            Text('Truck Test 1:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
            PrintDatabaseCurrentResult(helper, 'SELECT test1_current FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
            PrintDatabaseResponses(helper, 'SELECT test1_result FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 1),

            // Truck test result 2
            SizedBox(height: 15),
            Text('Truck Test 2:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
            PrintDatabaseCurrentResult(helper, 'SELECT test2_current FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
            PrintDatabaseResponses(helper, 'SELECT test2_result FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 1),

            // Truck test result 3
            SizedBox(height: 15),
            Text('Truck Test 3:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
            PrintDatabaseCurrentResult(helper, 'SELECT test3_current FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
            PrintDatabaseResponses(helper, 'SELECT test3_result FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 1),

            // Truck test result 4
            SizedBox(height: 15),
            Text('Truck Test 4:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
            PrintDatabaseCurrentResult(helper, 'SELECT test4_current FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
            PrintDatabaseResponses(helper, 'SELECT test4_result FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 1),
          ],
        ),
      ),
    );
  }
}

class TrailerResults extends StatelessWidget {
  DatabaseHelper helper = DatabaseHelper();

  Widget build(BuildContext context){
    return new Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.fromLTRB(24, 35, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Truck test result 1
            Text('Trailer Test 1:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
            PrintDatabaseCurrentResult(helper, 'SELECT test1_current FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
            PrintDatabaseResponses(helper, 'SELECT test1_result FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 1),

            // Truck test result 2
            SizedBox(height: 15),
            Text('Trailer Test 2:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
            PrintDatabaseCurrentResult(helper, 'SELECT test2_current FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
            PrintDatabaseResponses(helper, 'SELECT test2_result FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 1),

            // Truck test result 3
            SizedBox(height: 15),
            Text('Trailer Test 3:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
            PrintDatabaseCurrentResult(helper, 'SELECT test3_current FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
            PrintDatabaseResponses(helper, 'SELECT test3_result FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 1),

            // Truck test result 4
            SizedBox(height: 15),
            Text('Trailer Test 4:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
            PrintDatabaseCurrentResult(helper, 'SELECT test4_current FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
            PrintDatabaseResponses(helper, 'SELECT test4_result FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 1),
          ],
        ),
      ),
    );
  }
}

