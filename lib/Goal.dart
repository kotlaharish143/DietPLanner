import 'package:firstApp/homepage.dart';
import 'package:flutter/material.dart';
import 'feed.dart' as f;
import 'main.dart' as m;
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

int left = f.cals;
double calc;
final databaseReference = FirebaseDatabase.instance.reference();
List items = f.finalfoods;
List counts = f.finalcounts;
List<String> foods = [];
void ready() {
  for (var i = 0; i < items.length; i++) {
    foods.add(items[i]['item']);
  }
}

Map<dynamic, dynamic> map;
Future<void> getData() async {
  print(m.glbl);
  map = (await databaseReference.child("/users/" + m.glbl).once()).value;

  // print(map[glbls.glbl]['user']);
}

void dbEnter() {
  ready();
  databaseReference.child("users/" + m.glbl + "/details").update({
    "foods": [foods],
    "qua": [counts]
  });
}

// ignore: must_be_immutable
class Goal extends StatelessWidget {
  var x = getData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.blueAccent,
            Colors.blue.shade200,
          ]),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Your Goal",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "get fit don't quit",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  )),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                        child: Column(children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            // Text(
                            //   'Calories Consumed :',
                            //   style: TextStyle(
                            //     color: Colors.blueAccent,
                            //     fontFamily: 'Montserrat',
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            // SizedBox(
                            //   width: 10,
                            // ),
                            // Text(
                            //     (map.values.toList()[0]['rc'] -
                            //             map.values.toList()[0]['left'])
                            //         .toString(),
                            //     style: TextStyle(
                            //         color: Colors.black,
                            //         fontFamily: 'Montserrat',
                            //         fontSize: 30))
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Table(
                            border: TableBorder(
                                horizontalInside:
                                    BorderSide(color: Colors.black38)),
                            children: fun(),
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
                          dbEnter();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Homepage()),
                          );
                        },
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text("Confirm",
                            style: TextStyle(color: Colors.white)),
                      ),
                      width: 200,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => f.feed(),
                              ));
                        },
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text("Reset",
                            style: TextStyle(color: Colors.white)),
                      ),
                      width: 200,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  // ignore: non_constant_identifier_names
  List fun() {
    print("Haii frnds" + items.length.toString());
    List Row = List<TableRow>();
    var Heading = TableRow(children: <Widget>[
      Padding(
        padding: EdgeInsets.all(15.0),
        child: Text("Food item",
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15.0,
                fontWeight: FontWeight.bold)),
      ),
      Padding(
        padding: EdgeInsets.all(13.0),
        child: Text("Quantity",
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 15.0,
              color: Colors.blueGrey[600],
              fontWeight: FontWeight.bold,
            )),
      ),
      Padding(
        padding: EdgeInsets.all(13.0),
        child: Text("count",
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 15.0,
              color: Colors.blueGrey[600],
              fontWeight: FontWeight.bold,
            )),
      ),
      Padding(
        padding: EdgeInsets.all(13.0),
        child: Text("total Calories",
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 15.0,
              color: Colors.blueGrey[600],
              fontWeight: FontWeight.bold,
            )),
      ),
    ]);
    Row.add(Heading);
    for (int i = 0; i < items.length; i++) {
      Row.add(_buildItem(items[i], counts[i]));
    }
    return Row;
  }

  TableRow _buildItem(item, count) {
    return TableRow(children: <Widget>[
      Padding(
        padding: EdgeInsets.all(15.0),
        child: Text(item['item'],
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15.0,
                fontWeight: FontWeight.bold)),
      ),
      Padding(
        padding: EdgeInsets.all(13.0),
        child: Text(item['quantity'].toString(),
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 15.0,
              color: Colors.blueGrey[600],
              fontWeight: FontWeight.bold,
            )),
      ),
      Padding(
        padding: EdgeInsets.all(13.0),
        child: Text(count.toString(),
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 15.0,
              color: Colors.blueGrey[600],
              fontWeight: FontWeight.bold,
            )),
      ),
      Padding(
        padding: EdgeInsets.all(13.0),
        child: Text((count * item['cal']).toString(),
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 15.0,
              color: Colors.blueGrey[600],
              fontWeight: FontWeight.bold,
            )),
      ),
    ]);
  }
}
