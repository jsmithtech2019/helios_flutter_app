import 'package:flutter/material.dart';
import 'homepage.dart';
import 'testingpage.dart';
import 'resultspage.dart';
import 'helppage.dart';

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
    HelpPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.developer_mode),
            title: new Text('Testing'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.archive),
            title: new Text('Results'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.help),
            title: new Text('Help'),
          )
        ],
      ),
    );
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}