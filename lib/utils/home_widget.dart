/*
 * Texas A&M University
 * Electronic Systems Engineering Technology
 * ESET-420 Engineering Technology Senior Design II
 * File: home_widget.dart
 * Author: Jack Smith (john.d.smitherton@tamu.edu)
 */

// Flutter Packages
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

// Models
//import 'package:HITCH/models/database.dart';

// Screens
import 'package:HITCH/screens/help.dart';
import 'package:HITCH/screens/results.dart';
import 'package:HITCH/screens/settings.dart';
import 'package:HITCH/screens/testing.dart';

/// # Bottom Navigation Bar Controller
/// 
/// This class contains the bottom navigation widget that is drawn on the main
/// pages of the application. This bar allows navigation between [TestingPage],
/// [ResultsPage], [SettingsPage] and [HelpPage]. It allows for the user to
/// select any of these pages and (memory permitting) retains the memory stack
/// for each of these pages independently.
class Home extends StatefulWidget {
  static int _setIndex = 0;

  Home(int index){
    _setIndex = index;
  }

  @override
  State<StatefulWidget> createState() 
  {
    return _HomeState();
  }

  // Getters
  int get getIndex => _setIndex;

  // Setters
  set setIndex(int index) 
  {
    _setIndex = index;
  }
}

class _HomeState extends State<Home> {
  var logHelper = GetIt.instance<Logger>();
  int _currentIndex = 0;
  final List<Widget> _children = [
    TestingPage(),
    ResultsPage(),
    SettingsPage(),
    HelpPage(),
  ];
  @override
  Widget build(BuildContext context) {
    if(widget.getIndex != 0){
      setIndex(widget.getIndex);
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
      logHelper.d('Navigation Tab Tapped, Current index: $_currentIndex ');
    });
  }

  void setIndex(int index) {
    setState(() {
      widget.setIndex = 0;
      _currentIndex = index;
      logHelper.d('Navigation Index Set, Current index: $_currentIndex ');
    });
  }
}