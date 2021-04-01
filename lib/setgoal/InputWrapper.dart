import 'package:firstApp/Goal.dart';
import 'package:firstApp/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firstApp/feed.dart';
import 'package:firstApp/main.dart' as m;
import 'package:firebase_database/firebase_database.dart';
import 'package:firstApp/Alert.dart';

// void dbEnter() {
//   ready();
//   databaseReference.child("users/" + m.glbl + "/details").update({
//     "foods": [foods],
//     "qua": [counts]
//   });
// }
TextEditingController target = new TextEditingController();
TextEditingController dur = new TextEditingController();
final databaseReference = FirebaseDatabase.instance.reference();
void updb() {
  print(dur);
  databaseReference
      .child("users/" + m.glbl + "/details")
      .update({"target": target.text, "duration": dur.text});
}

class InputWrapper extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    TextFormField(
                      controller: target,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.lightBlue, width: 5.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'Target weight',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          )),
                      validator: (String value) {
                        if (value.trim().isEmpty) {
                          return 'Target Weight is required';
                        }
                      },
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: dur,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.lightBlue, width: 5.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'Duration(in Days)',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          )),
                      validator: (String value) {
                        if (value.trim().isEmpty) {
                          return 'Duration is required';
                        }
                      },
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                child: RaisedButton(
                  onPressed: () {
                    updb();
                    showAlertDialog(context, "Success", "Succesfully set");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Homepage()),
                    );
                  },
                  color: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("Set ", style: TextStyle(color: Colors.white)),
                ),
                width: 200,
              ),
            ],
          ),
        ));
  }
}

// ignore: non_constant_identifier_names
Widget Test_Flied(String text) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]))),
    child: TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: text,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          border: InputBorder.none),
    ),
  );
}
