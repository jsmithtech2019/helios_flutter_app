/*
 * Texas A&M University
 * Electronic Systems Engineering Technology
 * ESET-420 Engineering Technology Senior Design II
 * File: results.dart
 * Author: Jack Smith (john.d.smitherton@tamu.edu)
 */

// Flutter Packages
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// Models
import 'package:HITCH/models/customer_data.dart';
import 'package:HITCH/models/global.dart';
import 'package:HITCH/models/print.dart';
import 'package:HITCH/models/seperator.dart';

// Utils
import 'package:HITCH/utils/database_helper.dart';

/// Stateful results page widget
class ResultsPage extends StatefulWidget {
  /// [GetIt] singleton for [DatabaseHelper]
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();

  /// [GetIt] singleton for [GlobalHelper]
  final GlobalHelper gbHelper = GetIt.instance<GlobalHelper>();

  /// Initialize [CustomerData] object local variable
  final CustomerData custData;

  /// Default constructor
  ResultsPage({this.custData});

  @override
  State<StatefulWidget> createState() {
    return ResultsPageState();
  }
}

/// State of results page
/// 
/// Used to display test results as well as allow the technician the option to
/// choose results other than the most recent test result
class ResultsPageState extends State<ResultsPage> {
  /// Initialize useful string variables
  String dropDownNameValue, dropDownTestNum, custid;
  
  /// Create a map of customer id's
  Map<String, dynamic> custNameIDmap = {'key': -1};

  /// Customer Info for Result
  Widget customerInfo(){
    if(dropDownTestNum != null){
      return new Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child:  PrintDatabaseResponses(
                  //'SELECT name FROM CUSTOMER_DATA WHERE id="${gbHelper.customerID}" LIMIT 1',
                  'SELECT name FROM CUSTOMER_DATA WHERE id=$dropDownTestNum',
                  'Customer', 20),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: PrintDatabaseResponses(
                  //'SELECT truckplate FROM CUSTOMER_DATA WHERE id="${gbHelper.customerID}" LIMIT 1',
                  'SELECT truckplate FROM CUSTOMER_DATA WHERE id=$dropDownTestNum',
                  'Truck License Plate', 20),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: PrintDatabaseResponses(
                  //'SELECT trailerplate FROM CUSTOMER_DATA WHERE id="${gbHelper.customerID}" LIMIT 1',
                  'SELECT trailerplate FROM CUSTOMER_DATA WHERE id=$dropDownTestNum',
                  'Trailer License Plate', 20),
            ),
          ],
        ),
      );
    } else {
      return new Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child:  PrintDatabaseResponses(
                  //'SELECT name FROM CUSTOMER_DATA WHERE id="${gbHelper.customerID}" LIMIT 1',
                  'SELECT name FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1',
                  'Customer', 20),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: PrintDatabaseResponses(
                  //'SELECT truckplate FROM CUSTOMER_DATA WHERE id="${gbHelper.customerID}" LIMIT 1',
                  'SELECT truckplate FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1',
                  'Truck License Plate', 20),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: PrintDatabaseResponses(
                  //'SELECT trailerplate FROM CUSTOMER_DATA WHERE id="${gbHelper.customerID}" LIMIT 1',
                  'SELECT trailerplate FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1',
                  'Trailer License Plate', 20),
            ),
          ],
        ),
      );
    }
  }

  /// Results widgets for the truck
  Widget testResults(){
    if(dropDownTestNum != null){
      return new Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.fromLTRB(24, 24, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Truck test result 1
              Text('Truck Left Turn Signal:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
              PrintDatabaseCurrentResult('SELECT test1_current FROM TRUCK_TEST_DATA WHERE id=$dropDownTestNum', 'Current', 1),
              PrintDatabaseResponses('SELECT test1_result FROM TRUCK_TEST_DATA WHERE id=$dropDownTestNum', 'Test Result', 14),

              // Truck test result 2
              SizedBox(height: 15),
              Text('Truck Right Turn Signal:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
              PrintDatabaseCurrentResult('SELECT test2_current FROM TRUCK_TEST_DATA WHERE id=$dropDownTestNum', 'Current', 1),
              PrintDatabaseResponses('SELECT test2_result FROM TRUCK_TEST_DATA WHERE id=$dropDownTestNum', 'Test Result', 14),

              // Truck test result 3
              SizedBox(height: 15),
              Text('Truck Tail Lights:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
              PrintDatabaseCurrentResult('SELECT test3_current FROM TRUCK_TEST_DATA WHERE id=$dropDownTestNum', 'Current', 1),
              PrintDatabaseResponses('SELECT test3_result FROM TRUCK_TEST_DATA WHERE id=$dropDownTestNum', 'Test Result', 14),

              // Truck test result 4
              SizedBox(height: 15),
              Text('Truck Reverse Lights:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
              PrintDatabaseCurrentResult('SELECT test4_current FROM TRUCK_TEST_DATA WHERE id=$dropDownTestNum', 'Current', 1),
              PrintDatabaseResponses('SELECT test4_result FROM TRUCK_TEST_DATA WHERE id=$dropDownTestNum', 'Test Result', 14),

              // Trailer test result 1
              Text('Trailer Left Turn Signal:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
              PrintDatabaseCurrentResult('SELECT test1_current FROM TRAILER_TEST_DATA WHERE id=$dropDownTestNum', 'Current', 1),
              PrintDatabaseResponses('SELECT test1_result FROM TRAILER_TEST_DATA WHERE id=$dropDownTestNum', 'Test Result', 14),

              // Trailer test result 2
              SizedBox(height: 15),
              Text('Trailer Right Turn Signal:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
              PrintDatabaseCurrentResult('SELECT test2_current FROM TRAILER_TEST_DATA WHERE id=$dropDownTestNum', 'Current', 1),
              PrintDatabaseResponses('SELECT test2_result FROM TRAILER_TEST_DATA WHERE id=$dropDownTestNum', 'Test Result', 14),

              // Trailer test result 3
              SizedBox(height: 15),
              Text('Trailer Tail Lights:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
              PrintDatabaseCurrentResult('SELECT test3_current FROM TRAILER_TEST_DATA WHERE id=$dropDownTestNum', 'Current', 1),
              PrintDatabaseResponses('SELECT test3_result FROM TRAILER_TEST_DATA WHERE id=$dropDownTestNum', 'Test Result', 14),

              // Trailer test result 4
              SizedBox(height: 15),
              Text('Trailer Reverse Lights:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
              PrintDatabaseCurrentResult('SELECT test4_current FROM TRAILER_TEST_DATA WHERE id=$dropDownTestNum', 'Current', 1),
              PrintDatabaseResponses('SELECT test4_result FROM TRAILER_TEST_DATA WHERE id=$dropDownTestNum', 'Test Result', 14),
            ],
          ),
        ),
      );
    } else {
      return new Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.fromLTRB(24, 24, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Truck test result 1
              Text('Truck Left Turn Signal:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
              PrintDatabaseCurrentResult('SELECT test1_current FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
              PrintDatabaseResponses('SELECT test1_result FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 14),

              // Truck test result 2
              SizedBox(height: 15),
              Text('Truck Right Turn Signal:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
              PrintDatabaseCurrentResult('SELECT test2_current FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
              PrintDatabaseResponses('SELECT test2_result FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 14),

              // Truck test result 3
              SizedBox(height: 15),
              Text('Truck Tail Lights:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
              PrintDatabaseCurrentResult('SELECT test3_current FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
              PrintDatabaseResponses('SELECT test3_result FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 14),

              // Truck test result 4
              SizedBox(height: 15),
              Text('Truck Reverse Lights:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
              PrintDatabaseCurrentResult('SELECT test4_current FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
              PrintDatabaseResponses('SELECT test4_result FROM TRUCK_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 14),

              // Trailer test result 1
              Text('Trailer Left Turn Signal:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
              PrintDatabaseCurrentResult('SELECT test1_current FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
              PrintDatabaseResponses('SELECT test1_result FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 14),

              // Trailer test result 2
              SizedBox(height: 15),
              Text('Trailer Right Turn Signal:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
              PrintDatabaseCurrentResult('SELECT test2_current FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
              PrintDatabaseResponses('SELECT test2_result FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 14),

              // Trailer test result 3
              SizedBox(height: 15),
              Text('Trailer Tail Lights:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
              PrintDatabaseCurrentResult('SELECT test3_current FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
              PrintDatabaseResponses('SELECT test3_result FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 14),

              // Trailer test result 4
              SizedBox(height: 15),
              Text('Trailer Reverse Lights:', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
              PrintDatabaseCurrentResult('SELECT test4_current FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Current', 1),
              PrintDatabaseResponses('SELECT test4_result FROM TRAILER_TEST_DATA ORDER BY id DESC LIMIT 1', 'Test Result', 14),
            ],
          ),
        ),
      );
    }
  }

  /// initialize the state (for dropdown menu items) to null
  @override
  void initState() {
    dropDownTestNum = null;
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
            new SeparatorBox("Select another test"),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 55,
                        child: RaisedButton(
                          color: Colors.grey[800],
                          onPressed: () {
                            setState(() {
                              dropDownTestNum = null;
                              dropDownNameValue = null;
                            });
                          },
                          child: Text("Show Last Test"),
                        ),
                      ),
                      Spacer(),
                      FutureBuilder<List<Map<String, dynamic>>>(
                        future: widget.dbHelper.getCustomerListTwo('name', 'id'),
                        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none: return new Text("Database Connection Failed!");
                            case ConnectionState.waiting: return new CircularProgressIndicator();
                            case ConnectionState.active: return new CircularProgressIndicator();
                            default:
                              if(snapshot.hasError){
                                return new Text("Error: ${snapshot.error}");
                              } else {
                                // Convert map to list, drop second value (id)
                                List<String> l = [];

                                int i;
                                for(i = 0; i < snapshot.data.length; i++){
                                  snapshot.data[i].forEach((k, v) => l.add(k));
                                }
                                return Container(
                                  color: Colors.grey[800],
                                  padding: EdgeInsets.fromLTRB(13,3,10,3),
                                  child: DropdownButton<String>(
                                    value: dropDownNameValue,
                                    hint: Text('Choose Customer'),
                                    items: l.map((String val){
                                      return new DropdownMenuItem<String>(
                                        value: val.toString(),
                                        child: new Text(val.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (String newVal){
                                      setState(() {
                                        int i;
                                        for(i = 0; i < snapshot.data.length; i++){
                                          if(snapshot.data[i].keys.contains(newVal)){
                                            custNameIDmap = snapshot.data[i];
                                          }
                                        }
                                        dropDownTestNum = null;
                                        dropDownNameValue = newVal;
                                      });
                                    },
                                  ),
                                );
                              }
                          }
                        }
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Spacer(),
                      FutureBuilder<List<String>>(
                          future: widget.dbHelper.getCustomerTestList(custNameIDmap[dropDownNameValue], 'TRUCK_TEST_DATA'),
                          builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none: return new Text("Database Connection Failed!");
                              case ConnectionState.waiting: return new CircularProgressIndicator();
                              case ConnectionState.active: return new CircularProgressIndicator();
                              default:
                                if(snapshot.hasError){
                                  return new Text("Error: ${snapshot.error}");
                                } else {
                                  return Container(
                                    color: Colors.grey[800],
                                    padding: EdgeInsets.fromLTRB(13,3,10,3),
                                    child: DropdownButton<String>(
                                      hint: Text('Available Tests'),
                                      value: dropDownTestNum,
                                      items: snapshot.data.map((String val) {
                                        return new DropdownMenuItem<String>(
                                          value: val,
                                          child: new Text(val),
                                        );
                                      }).toList(),
                                      onChanged: (String newVal){
                                        setState(() {
                                          dropDownTestNum = newVal;
                                          //dropDownTrailerTestNum = null;
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
                ]),
              ),
            new SeparatorBox("Showing test result for"),
            Container(
              margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Column(
                children: <Widget>[
                  customerInfo(),
                  testResults(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
