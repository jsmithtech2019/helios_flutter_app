//import 'dart:html';

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
              PrintDatabaseResponses(helper, 'SELECT name FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1', 'Testing for customer', 1.5),
              PrintDatabaseResponses(helper, 'SELECT phone FROM CUSTOMER_DATA ORDER BY id DESC LIMIT 1', 'Phone number from db', 1.5),
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

/*
Use this for cool animated things
AnimatedContainer(
  duration: Duration(seconds: 2),
  etc
)

 Use this for keeping an image on screen between screen changes without
 redrawing
Hero(

)

--profile in running app to see the FPS on physical device

Used to show the proper widget based on Android or iOS, can also use adaptive flag
Platform(
)

Builders are functions that build widgets
Use with lists to page things etc

// Statemanagement solutions
get_it
CREATE GLOBAL SINGLETON -> USE FOR THE DB SINGLETON

provider
Very good for state management too, can be accessed with a bunch
of other pages etc

// Icons
flutter_launcher_icons -> already used, autogens all the icons for Android
and iOS
*/