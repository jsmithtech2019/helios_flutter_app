import 'package:HITCH/contactpage.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'testingpage.dart';
import 'resultspage.dart';
import 'helppage.dart';
import 'contactpage.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    TestingPage(),
    ResultsPage(),
    HelpPage(),
    ContactPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      backgroundColor: Colors.red,
      bottomNavigationBar: new Container(
        child: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.developer_mode),
              title: Text('Testing'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.storage),
              title: Text('Results'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.settings),
              title: Text('Settings'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.help),
              title: Text('Help'),
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