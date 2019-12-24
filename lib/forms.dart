import 'package:flutter/material.dart';
import 'package:HITCH/testingpage.dart';

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new TextEntryField('Customer Name'),
          new TextEntryField('Customer Phone Number'),
          new TextEntryField('Customer Truck License Plate'),
          new TextEntryField('Trailer License Plate'),
          new TextEntryField('Test Engineer ID'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TestingPage()),
                  );
                } // if
              }, // onPressed
              child: Text('Submit'),
            ),
          ),
        ],
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
      validator: (value) {
        if (value.isEmpty) {
          return 'Please $text';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        hintText: '$text',
      ),
    );
  }
}