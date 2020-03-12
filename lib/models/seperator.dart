/*
 * Texas A&M University
 * Electronic Systems Engineering Technology
 * ESET-420 Engineering Technology Senior Design II
 * File: seperator.dart
 * Author: Jack Smith (john.d.smitherton@tamu.edu)
 */

// Flutter Packages
import 'package:flutter/material.dart';

class SeparatorBox extends StatelessWidget {
  final String text;
  SeparatorBox(this.text);

  Widget build(BuildContext context){
    return Container(
      color: Colors.blueGrey[600],
      alignment: Alignment.centerLeft,
      height: 60,
      child: Text("     $text:",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}