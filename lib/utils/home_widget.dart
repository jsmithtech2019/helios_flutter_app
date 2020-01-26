import 'package:HITCH/models/database.dart';
import 'package:HITCH/screens/results.dart';
import 'package:flutter/material.dart';
import 'package:HITCH/screens/settings.dart';
import 'package:HITCH/screens/help.dart';
import 'package:HITCH/screens/testing_init.dart';

class Home extends StatefulWidget {
  final TestData testData;

  Home({this.testData});

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