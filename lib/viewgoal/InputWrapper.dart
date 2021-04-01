import 'package:firstApp/Goal.dart';
import 'package:firstApp/feed.dart';
import 'package:flutter/material.dart';
import 'package:firstApp/main.dart' as m;
import 'package:firebase_database/firebase_database.dart';

final databaseReference = FirebaseDatabase.instance.reference();
Map<dynamic, dynamic> data;
Future<int> getData() async {
  data = (await databaseReference.child("/users/" + m.glbl).once()).value;
}

class InputWrapper extends StatelessWidget {
  var y = getData();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Container(
              child: Column(children: [
            Padding(
                padding: EdgeInsets.all(10),
                child: Table(
                  border: TableBorder(
                      horizontalInside: BorderSide(color: Colors.black38)),
                  children: [
                    _buildItem("Starting Weight",
                        data.values.toList()[0]['weight'].toString()),
                    _buildItem("Your Target",
                        data.values.toList()[0]['target'].toString()),
                    _buildItem("Days Left",
                        data.values.toList()[0]['duration'].toString()),
                    _buildItem("Goal fixed on", "01-04-2021"),
                  ],
                )),
          ])),
          SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => feed()),
                );
              },
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text("Plan Diet", style: TextStyle(color: Colors.white)),
            ),
            width: 200,
          ),
        ],
      ),
    );
  }
}

TableRow _buildItem(String key, String value) {
  return TableRow(children: <Widget>[
    Padding(
      padding: EdgeInsets.all(15.0),
      child: Text(key,
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 15.0,
              fontWeight: FontWeight.bold)),
    ),
    Padding(
      padding: EdgeInsets.all(13.0),
      child: Text(value,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 15.0,
            color: Colors.blueGrey[600],
            fontWeight: FontWeight.bold,
          )),
    ),
  ]);
}
