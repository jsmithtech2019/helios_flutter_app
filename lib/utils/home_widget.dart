// Flutter Packages
import 'package:flutter/material.dart';
// TODO: remove get it
import 'package:get_it/get_it.dart';

// Models
import 'package:HITCH/models/database.dart';

// Screens
import 'package:HITCH/screens/help.dart';
import 'package:HITCH/screens/results.dart';
import 'package:HITCH/screens/settings.dart';
import 'package:HITCH/screens/testing_init.dart';

// Utils
//TODO: remove db helper
import 'package:HITCH/utils/database_helper.dart';

///#############################################################################
///
///#############################################################################

class Home extends StatefulWidget {
  final CustomerData custData;
  int setIndex = 0;
  Home({this.custData, this.setIndex});

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    CustomerPage(),
    ResultsPage(),
    SettingsPage(),
    HelpPage(),
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: remove test data insertion lines
    // Insert test data for debugging development
    // Get singleton
    var dbHelper = GetIt.instance<DatabaseHelper>();

    // Dummy Truck Test Data
    dbHelper.executeRawQuery('INSERT INTO TRUCK_TEST_DATA '
        '(test1_result, test1_current, '
        'test2_result, test2_current, '
        'test3_result, test3_current, '
        'test4_result, test4_current) '
        'VALUES '
        '(0, 21.0, '
        '1, 1.24, '
        '0, 13.9, '
        '1, .98)');
    // Dummy Trailer Test Data
    dbHelper.executeRawQuery('INSERT INTO TRAILER_TEST_DATA '
        '(test1_result, test1_current, '
        'test2_result, test2_current, '
        'test3_result, test3_current, '
        'test4_result, test4_current) '
        'VALUES '
        '(0, 21.0, '
        '1, 1.24, '
        '0, 13.9, '
        '1, .98)');

    // Dummy User Data
    dbHelper.executeRawQuery('INSERT INTO CUSTOMER_DATA (name, phone, email, addr1, addr2, city, state, zip, truckplate, trailerplate) VALUES ('
        '"Jack Smith", "11111", "dummy@gmail.com", "addr1", "addr2", "cstat", "tx", "7777", "truckplateval", "trailerplateval")');
    
    return Scaffold(
      body: _children[_currentIndex],
      backgroundColor: Colors.black12,
      bottomNavigationBar: new Container(
        child: BottomNavigationBar(
          onTap: onTabTapped,
          showUnselectedLabels: true,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.developer_mode),
              title: new Text('Testing'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.storage),
              title: new Text('Results'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.settings),
              title: new Text('Settings'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.help),
              title: new Text('Help'),
            )
          ],
          fixedColor: Colors.cyanAccent,
        ),
      ),
    );
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}