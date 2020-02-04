// Flutter Packages
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// Models
import 'package:HITCH/models/forms.dart';
import 'package:HITCH/models/seperator.dart';

// Utils
import 'package:HITCH/utils/database_helper.dart';


///#############################################################################
///                            testing_init.dart
///#############################################################################

class CustomerPage extends StatelessWidget {
  // Pull GetIt Singleton and create pointers to Singleton Helpers
  final DatabaseHelper dbHelper = GetIt.instance<DatabaseHelper>();

  @override
  Widget build (BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("H.I.T.C.H. Testing"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              new SeparatorBox('Insert Customer Details'),
              new CustomerForm(),
              SizedBox(height: 20),
            ],
          ),
        ),
    );
  }
}

class TextEntryField extends StatelessWidget {
  final String text;
  TextEntryField(this.text);

  Widget build(BuildContext context){
    return TextFormField(
      //controller: ,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        hintText: '$text',
      ),
    );
  }
}