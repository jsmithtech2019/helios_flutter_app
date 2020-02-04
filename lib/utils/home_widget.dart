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
///                            home_widget.dart
///#############################################################################

class Home extends StatefulWidget {
  int setIndex = 0;

  Home(int index){
    this.setIndex = index;
  }

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
    if(widget.setIndex != 0){
      setIndex(widget.setIndex);
    }
    //_currentIndex = widget.setIndex;
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
          fixedColor: Colors.blue[300],
        ),
      ),
    );
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void setIndex(int index) {
    setState(() {
      widget.setIndex = 0;
      _currentIndex = index;
    });
  }
}