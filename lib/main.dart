import 'package:flutter/material.dart';
import 'home_widget.dart';


void main() => runApp(HeliosApp());

class HeliosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Helios Project',
      home: Home(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
      ),
    );
  }
}
