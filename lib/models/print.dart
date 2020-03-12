/*
 * Texas A&M University
 * Electronic Systems Engineering Technology
 * ESET-420 Engineering Technology Senior Design II
 * File: print.dart
 * Author: Jack Smith (john.d.smitherton@tamu.edu)
 */

import 'package:HITCH/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

/// Widget that displays database responses.
///
/// This function is utilized to display the response from the database in a clean
/// and well designed format. In the future this should be rolled into the
/// database helper class.
class PrintDatabaseResponses extends StatelessWidget {
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();
  final String query;
  final String successStatement;
  final double size;

  PrintDatabaseResponses(this.query, this.successStatement, this.size);

  Widget build(BuildContext context){
    return FutureBuilder<String>(
        future: dbHelper.executeRawQuery(query)
            .then((resp){return resp[0].values.toList()[0].toString();}),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.none: return new Text('Didn\'t Work!');
            case ConnectionState.waiting: return new Text('Awaiting result!');
            default:
              if(snapshot.hasError){
                return new Text('Error: ${snapshot.error}');
              } else {
                return new Text('$successStatement: ${snapshot.data}',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: size)
                );
              }
          }
        }
    );
  }
}

class PrintDatabaseTestResult extends StatelessWidget {
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();
  final String query;
  final String successStatement;
  final double size;

  PrintDatabaseTestResult(this.query, this.successStatement, this.size);

  Widget build(BuildContext context){
    return FutureBuilder<String>(
        future: dbHelper.executeRawQuery(query)
            .then((resp){return resp[0].values.toList()[0].toString();}),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.none: return new Text('Didn\'t Work!');
            case ConnectionState.waiting: return new Text('Awaiting result!');
            default:
              if(snapshot.hasError){
                return new Text('Error: ${snapshot.error}');
              } else {
                return new Text('$successStatement: ${snapshot.data}',
                  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: size),
                );
              }
          }
        }
    );
  }
}

class PrintDatabaseCurrentResult extends StatelessWidget {
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();
  final String query;
  final String successStatement;
  final double size;

  PrintDatabaseCurrentResult(this.query, this.successStatement, this.size);

  Widget build(BuildContext context){
    return FutureBuilder<String>(
        future: dbHelper.executeRawQuery(query)
            .then((resp){return resp[0].values.toList()[0].toString();}),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.none: return new Text('Didn\'t Work!');
            case ConnectionState.waiting: return new Text('Awaiting result!');
            default:
              if(snapshot.hasError){
                return new Text('Error: ${snapshot.error}');
              } else {
                return new Text('$successStatement: ${snapshot.data} A',
                  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: size),
                );
              }
          }
        }
    );
  }
}