/*
 * Texas A&M University
 * Electronic Systems Engineering Technology
 * ESET-420 Engineering Technology Senior Design II
 * File: seperator.dart
 * Author: Jack Smith (john.d.smitherton@tamu.edu)
 */

// Flutter Packages
import 'package:flutter/material.dart';

/// Separator box to split up sections of pages
class SeparatorBox extends StatelessWidget {

  /// The text for the box
  final String text;

  /// Default constructor
  SeparatorBox(this.text);

  /// The actual built and returned widget
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