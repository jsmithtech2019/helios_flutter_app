// Flutter Packages
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// Models
import 'package:HITCH/models/database.dart';
import 'package:HITCH/models/seperator.dart';

// Utils
import 'package:HITCH/utils/database_helper.dart';


///#############################################################################
///
///#############################################################################

class ResultsPage extends StatefulWidget {
  final CustomerData custData;
  ResultsPage({this.custData});

  @override
  State<StatefulWidget> createState() {
    return ResultsPageState(this.custData);
  }
}

class ResultsPageState extends State<ResultsPage> {
  // Pull GetIt Singleton and create pointers to Singleton Helpers
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();

  // Pass customer data into this state
  final CustomerData custData;

  String dropDownNameValue, dropDownTestNum;
  ResultsPageState(this.custData);

  @override
  void initState() {
    dropDownNameValue = "Choose Customer";
    dropDownTestNum = "Choose Test";
    super.initState();
  }

  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Test Results"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new SeparatorBox("Showing test result for"),
            Container(
              margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new FutureBuilder<List<String>>(
                          future: dbHelper.getCustomerNamesList(),
                          builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none: return new Text("Database Connection Failed!");
                              case ConnectionState.waiting: return new CircularProgressIndicator();
                              case ConnectionState.active: return new CircularProgressIndicator();
                              default:
                                if(snapshot.hasError){
                                  return new Text("Error: ${snapshot.error}");
                                } else {

                                  if (dropDownNameValue == "Choose Customer"){
                                    snapshot.data.add(dropDownNameValue);
                                  }
                                  return Container(
                                    color: Colors.grey[800],
                                    padding: EdgeInsets.fromLTRB(13,3,10,3),
                                    child: DropdownButton<String>(
                                      value: dropDownNameValue,
                                      items: snapshot.data.map((String val) {
                                        return new DropdownMenuItem<String>(
                                          value: val,
                                          child: new Text(val),
                                        );
                                      }).toList(),
                                      onChanged: (String newVal){
                                        // TODO: update the admin configuration to use selected profile
                                        setState(() {
                                          dropDownNameValue = newVal;
                                        });
                                      },
                                    ),
                                  );
                                }
                            }
                          }
                      ),
                      SizedBox(width: 40),
                      new FutureBuilder<List<String>>(
                          future: dbHelper.getCustomerNamesList(),
                          builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none: return new Text("Database Connection Failed!");
                              case ConnectionState.waiting: return new CircularProgressIndicator();
                              case ConnectionState.active: return new CircularProgressIndicator();
                              default:
                                if(snapshot.hasError){
                                  return new Text("Error: ${snapshot.error}");
                                } else {

                                  if (dropDownTestNum == "Choose Test"){
                                    snapshot.data.add(dropDownTestNum);
                                  }
                                  return Container(
                                    color: Colors.grey[800],
                                    padding: EdgeInsets.fromLTRB(13,3,10,3),
                                    child:DropdownButton<String>(
                                      value: dropDownTestNum,
                                      items: snapshot.data.map((String val) {
                                        return new DropdownMenuItem<String>(
                                          value: val,
                                          child: new Text(val),
                                        );
                                      }).toList(),
                                      onChanged: (String newVal){
                                        // TODO: update the admin configuration to use selected profile
                                        setState(() {
                                          dropDownTestNum = newVal;
                                        });
                                      },
                                    )
                                  );
                                }
                            }
                          }
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child:  PrintDatabaseResponses(dbHelper,
                        'SELECT name FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1',
                        'Customer', 20),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: PrintDatabaseResponses(dbHelper,
                        'SELECT truckplate FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1',
                        'Truck License Plate', 20),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: PrintDatabaseResponses(dbHelper,
                        'SELECT trailerplate FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1',
                        'Trailer License Plate', 20),
                  ),
                  TruckResults(),
                  TrailerResults(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TruckResults extends StatelessWidget {
  // Pull GetIt Singleton and create pointers to Singleton Helpers
  static GetIt sl = GetIt.instance;
  final DatabaseHelper dbHelper = sl.get<DatabaseHelper>();

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
            PrintDatabaseCurrentResult(dbHelper, 'SELECT test1_current FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
            PrintDatabaseResponses(dbHelper, 'SELECT test1_result FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 14),

            // Truck test result 2
            SizedBox(height: 15),
            Text('Truck Test 2:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
            PrintDatabaseCurrentResult(dbHelper, 'SELECT test2_current FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
            PrintDatabaseResponses(dbHelper, 'SELECT test2_result FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 14),

            // Truck test result 3
            SizedBox(height: 15),
            Text('Truck Test 3:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
            PrintDatabaseCurrentResult(dbHelper, 'SELECT test3_current FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
            PrintDatabaseResponses(dbHelper, 'SELECT test3_result FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 14),

            // Truck test result 4
            SizedBox(height: 15),
            Text('Truck Test 4:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
            PrintDatabaseCurrentResult(dbHelper, 'SELECT test4_current FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
            PrintDatabaseResponses(dbHelper, 'SELECT test4_result FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 14),
          ],
        ),
      ),
    );
  }
}

class TrailerResults extends StatelessWidget {
  // Pull GetIt Singleton and create pointers to Singleton Helpers
  static GetIt sl = GetIt.instance;
  final DatabaseHelper dbHelper = sl.get<DatabaseHelper>();

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
            PrintDatabaseCurrentResult(dbHelper, 'SELECT test1_current FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
            PrintDatabaseResponses(dbHelper, 'SELECT test1_result FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 14),

            // Truck test result 2
            SizedBox(height: 15),
            Text('Trailer Test 2:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
            PrintDatabaseCurrentResult(dbHelper, 'SELECT test2_current FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
            PrintDatabaseResponses(dbHelper, 'SELECT test2_result FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 14),

            // Truck test result 3
            SizedBox(height: 15),
            Text('Trailer Test 3:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
            PrintDatabaseCurrentResult(dbHelper, 'SELECT test3_current FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
            PrintDatabaseResponses(dbHelper, 'SELECT test3_result FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 14),

            // Truck test result 4
            SizedBox(height: 15),
            Text('Trailer Test 4:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
            PrintDatabaseCurrentResult(dbHelper, 'SELECT test4_current FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
            PrintDatabaseResponses(dbHelper, 'SELECT test4_result FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 14),
          ],
        ),
      ),
    );
  }
}

