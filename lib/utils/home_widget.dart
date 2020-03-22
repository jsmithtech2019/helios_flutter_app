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
  /// Set initial index of application to testing page
  static int _setIndex = 0;

  /// Default constructor, set index of page to the provided index
  /// 
  /// Takes an integer [index] and updates the array location
  Home(int index){
    _setIndex = index;
  }

  /// Create the home state object
  @override
  State<StatefulWidget> createState() 
  {
    return _HomeState();
  }

  /// Getter to the index value
  int get getIndex => _setIndex;

  /// Setter to the index value
  /// 
  /// Takes an integer [index] argument to update the index accordingly
  set setIndex(int index) 
  {
    _setIndex = index;
  }
}

/// The state object of [Home]
/// 
/// Used for actual operation of the home widget
class _HomeState extends State<Home> {
  /// [GetIt] instance of the logging tool
  var logHelper = GetIt.instance<Logger>();

  /// Local variable to store the current index
  /// 
  /// Default initializes to 0
  int _currentIndex = 0;

  /// Create list of children widgets
  /// 
  /// The navigatable pages available for the nav bar are the [TestingPage],
  /// [ResultsPage], [SettingsPage], and [HelpPage]. Other pages are not
  /// accessible from this navigation bar (such as [ContactPage])
  final List<Widget> _children = [
    TestingPage(),
    ResultsPage(),
    SettingsPage(),
    HelpPage(),
  ];

  /// Build the widget
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

  /// Change the page and state when a button is tabbed
  /// 
  /// Takes an integer [index] that is connected to each navbar button
  /// and selects which to move to. Also logs the change.
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      logHelper.d('Navigation Tab Tapped, Current index: $_currentIndex ');
    });
  }

  /// Set a specific index
  /// 
  /// Used for leaving pages that do not have the navigation bar and need to return
  /// to a specific page after execution via [Navigator].
  void setIndex(int index) {
    setState(() {
      widget.setIndex = 0;
      _currentIndex = index;
      logHelper.d('Navigation Index Set, Current index: $_currentIndex ');
    });
  }
}