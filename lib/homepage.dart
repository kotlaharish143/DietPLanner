import 'package:firstApp/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firstApp/screens/calculator_screen.dart';
import 'package:firstApp/feed.dart';
import 'package:firstApp/BMR.dart';
import 'package:firstApp/setgoal/LoginPage.dart';
import 'package:firstApp/viewgoal/ViewGoal.dart';
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';
import 'main.dart' as m;
import 'feed.dart' as g;

Map<dynamic, dynamic> data;
Future<int> getUserData() async {
  print("Entered gus");
  data = (await databaseReference.child("/users/" + m.glbl).once()).value;
}

void dbEnter(c) {
  databaseReference.child("users/" + m.glbl + "/details").update({"rc": c});
}

String display() {
  if (g.cals != Null) {
    return g.cals.toStringAsFixed(2);
  } else {
    return "0";
  }
}

var uid = Uuid();
var ref;
List<dynamic> reqFoods = [];
List<dynamic> goalFoods = [];
// List<dynamic> goalCounts = [];
final databaseReference = FirebaseDatabase.instance.reference();
Timer _timer;

class Homepage extends StatelessWidget {
  var x = getUserData();
  var y = calCalories(
      data.values.toList()[0]['weight'],
      data.values.toList()[0]['target'],
      data.values.toList()[0]['BMI'].toDouble(),
      data.values.toList()[0]['duration']);
  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece of paper on which the UI appears.
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("DIET PLANNER"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff374ABE), Color(0xff64B6FF)],
          )),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                ),
              ),
              child: Row(
                children: [
                  SizedBox(height: 10),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          data.values.toList()[0]['duration'].toString(),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Days left',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          data.values.toList()[0]['left'].toString(),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Calories left',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          data.values.toList()[0]['target'].toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Target Weight',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                ),
              ),
              width: double.infinity,
              child: Container(
                width: 350,
                height: 120,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Container(
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ViewGoal()),
                          );
                        },
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text("YOUR GOAL",
                            style: TextStyle(color: Colors.white)),
                      ),
                      width: 200,
                    ),
                    Container(
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text("SET A GOAL",
                            style: TextStyle(color: Colors.white)),
                      ),
                      width: 200,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                ref = "WL";
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
              child: Container(
                width: double.maxFinite,
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.5), BlendMode.darken),
                        image: new AssetImage("assets/images/background.jpeg"),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.only(
                  top: 80.0,
                  left: 5.0,
                ),
                margin: EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  "WEIGHT LOSS",
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                ref = "WG";
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
              child: Container(
                width: double.maxFinite,
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.5), BlendMode.darken),
                        image: new AssetImage("assets/images/2tab.webp"),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.only(
                  top: 80.0,
                  left: 5.0,
                ),
                margin: EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  "WEIGHT GAIN",
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                ref = "DIABETIC";

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
              child: Container(
                width: double.maxFinite,
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.5), BlendMode.darken),
                        image: new AssetImage("assets/images/3tab.jpg"),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.only(
                  top: 80.0,
                  left: 5.0,
                ),
                margin: EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  "DIABETIC",
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                ref = "HT";

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
              child: Container(
                width: double.maxFinite,
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.darken),
                      image: new AssetImage("assets/images/101.jpeg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.only(
                  top: 80.0,
                  left: 5.0,
                ),
                margin: EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  "Hyper Tension",
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SizedBox(height: 10),
            // Container(
            //   width: 400,
            //   height: 150,
            //   decoration: BoxDecoration(
            //       image: DecorationImage(
            //         colorFilter: new ColorFilter.mode(
            //             Colors.black.withOpacity(0.5), BlendMode.darken),
            //         image: new AssetImage("assets/images/4tab.jpg"),
            //         fit: BoxFit.cover,
            //       ),
            //       borderRadius: BorderRadius.circular(12)),
            //   padding: EdgeInsets.only(top: 80.0),
            //   child: Text(
            //     "FULL BODY",
            //     style: GoogleFonts.raleway(
            //       color: Colors.white,
            //       fontSize: 38,
            //       fontWeight: FontWeight.bold,
            //     ),
            //     textAlign: TextAlign.left,
            //   ),
            // ),
            // SizedBox(height: 10),
            // Container(
            //   width: 400,
            //   height: 150,
            //   decoration: BoxDecoration(
            //       image: DecorationImage(
            //         colorFilter: new ColorFilter.mode(
            //             Colors.black.withOpacity(0.5), BlendMode.darken),
            //         image: new AssetImage("assets/images/4tab.jpg"),
            //         fit: BoxFit.cover,
            //       ),
            //       borderRadius: BorderRadius.circular(12)),
            //   padding: EdgeInsets.only(top: 80.0),
            //   child: Text(
            //     "FULL BODY",
            //     style: GoogleFonts.raleway(
            //       color: Colors.white,
            //       fontSize: 38,
            //       fontWeight: FontWeight.bold,
            //     ),
            //     textAlign: TextAlign.left,
            //   ),
            // ),
            // SizedBox(height: 10),
            // Container(
            //   width: 400,
            //   height: 150,
            //   decoration: BoxDecoration(
            //       image: DecorationImage(
            //         colorFilter: new ColorFilter.mode(
            //             Colors.black.withOpacity(0.5), BlendMode.darken),
            //         image: new AssetImage("assets/images/4tab.jpg"),
            //         fit: BoxFit.cover,
            //       ),
            //       borderRadius: BorderRadius.circular(12)),
            //   padding: EdgeInsets.only(top: 80.0),
            //   child: Text(
            //     "FULL BODY",
            //     style: GoogleFonts.raleway(
            //       color: Colors.white,
            //       fontSize: 38,
            //       fontWeight: FontWeight.bold,
            //     ),
            //     textAlign: TextAlign.left,
            //   ),
            // ),
            // SizedBox(height: 10),
            // Container(
            //   width: 400,
            //   height: 150,
            //   decoration: BoxDecoration(
            //       image: DecorationImage(
            //         colorFilter: new ColorFilter.mode(
            //             Colors.black.withOpacity(0.5), BlendMode.darken),
            //         image: new AssetImage("assets/images/4tab.jpg"),
            //         fit: BoxFit.cover,
            //       ),
            //       borderRadius: BorderRadius.circular(12)),
            //   padding: EdgeInsets.only(top: 80.0),
            //   child: Text(
            //     "FULL BODY",
            //     style: GoogleFonts.raleway(
            //       color: Colors.white,
            //       fontSize: 38,
            //       fontWeight: FontWeight.bold,
            //     ),
            //     textAlign: TextAlign.left,
            //   ),
            // ),
            // SizedBox(height: 10),
          ],
        ),
      )),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: Image.asset(
                "assets/images/login.png",
                fit: BoxFit.contain,
                alignment: Alignment.bottomLeft,
              ),
            ),
            ListTile(
              title: Text('My Profile'),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => profile()),
                )
              },
            ),
            ListTile(
              title: Text('BMI Caluculator'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalculatorScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Calorie Counter'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BMRCalculatorScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Load data'),
              onTap: () => loadExcdel(),
            ),
          ],
        ),
      ),
    );
  }

  void createRecord(row, i) {
    // print("create record called");
    var item = row[0];
    var quantity = row[1];
    var cal = row[2];
    var tags = row[3];
    var id = uid.v1();
    databaseReference.child("foods/" + i.toString()).set({
      "item": item,
      "quantity": quantity,
      "cal": cal,
      "tags": tags,
      "id": id
    });
  }

  Future<void> loadExcdel() async {
    ByteData data = await rootBundle.load("assets/database.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      int i = 0;
      print(table); //sheet Name
      print(excel.tables[table].maxCols);
      print(excel.tables[table].maxRows);
      for (var row in excel.tables[table].rows) {
        // if (i > 10) {
        //   break;
        // }
        createRecord(row, i++);
      }
    }
  }
}

// void main() {
//   runApp(MaterialApp(
//     title: 'My app', // used by the OS task switcher
//     home: SafeArea(
//       child: MyScaffold(),
//     ),
//   ));
// }

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

bool substr(String a, String b) {
  return a.contains(b);
}

Future<String> getData() async {
  print("MyHomePageState");

  List<dynamic> data = (await databaseReference.child("/foods").once()).value;
  reqFoods = [];
  for (var i = 1; i < data.length; i++) {
    if (substr(data[i]['tags'], ref)) {
      reqFoods.add(data[i]);
    }
  }
  print(ref);
  print(reqFoods.length);
  for (var i = 0; i < reqFoods.length; i++) {
    print(reqFoods[i]);
  }
  // data<dynamic, dynamic> data = snapshot.value;
  // // print(data.values.toList()[0][1]['details']['password']);
  // // pw = data.values.toList()[0][0]['details']['password'];
  // // un = data.values.toList()[0][0]['details']['user'];
  // for (var i = 0; i < data.length; i++) {
  //   if (data.values.toList()[0][i]['details']['user'] ==
  //       emailController.text) {
  //     if (data.values.toList()[0][i]['details']['password'] ==
  //         passController.text) {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => Homepage()),
}

class _MyHomePageState extends State<MyHomePage> {
  List count = List<int>();

  var data = getData();
  void initState() {
    super.initState();
    for (int i = 1; i < 450; i++) {
      count.add(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              children: <Widget>[
                Text('Foods for',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 25.0)),
                SizedBox(width: 10.0),
                Text(ref,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0))
              ],
            ),
          ),
          SizedBox(height: 40.0),
          Container(
            height: MediaQuery.of(context).size.height - 185.0,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.all(25),
              children: <Widget>[
                Table(
                  border: TableBorder(
                      bottom: BorderSide(color: Colors.black38),
                      horizontalInside: BorderSide(color: Colors.black38)),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: {
                    0: FixedColumnWidth(
                        MediaQuery.of(context).size.width - 150),
                    1: FixedColumnWidth(40),
                    2: FixedColumnWidth(20),
                    3: FixedColumnWidth(40),
                  },
                  children: [
                    for (var i = 0; i < reqFoods.length; i++) _buildItems(i)
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  TableRow _buildItems(i) {
    return TableRow(children: <Widget>[
      Column(children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
          alignment: Alignment.centerLeft,
          child: Text(reqFoods[i]['item'],
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold)),
        ),
        Container(
          padding: EdgeInsets.only(right: 10, bottom: 10),
          alignment: Alignment.centerLeft,
          child: Text(reqFoods[i]['cal'].toString() + "cal(per Unit item)",
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400)),
        ),
      ]),
      // IconButton(
      //     icon: Icon(Icons.add),
      //     color: Colors.black,
      //     onPressed: () {
      //       goalFoods.add(reqFoods[i]['item']);
      //     }),
      // Text("added",
      //     style: TextStyle(
      //       fontFamily: 'Montserrat',
      //       fontSize: 12.0,
      //     )),
      // IconButton(
      //     icon: Icon(Icons.remove),
      //     color: Colors.black,
      //     onPressed: () {
      //       setState(() {
      //         if (goalFoods[reqFoods[i]['item']] > 0) {
      //           goalFoods[reqFoods[i]['item']]--;
      //         }
      //       });
      //     })
    ]);
  }

  TableRow _buildItem(String key, String value, int id) {
    return TableRow(children: <Widget>[
      Column(children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
          alignment: Alignment.centerLeft,
          child: Text(key,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold)),
        ),
        Container(
          padding: EdgeInsets.only(right: 10, bottom: 10),
          alignment: Alignment.centerLeft,
          child: Text(value,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400)),
        ),
      ]),
      IconButton(
          icon: Icon(Icons.add),
          color: Colors.black,
          onPressed: () {
            setState(() {
              count[id]++;
            });
          }),
      Text(count[id].toString(),
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 12.0,
          )),
      IconButton(
          icon: Icon(Icons.remove),
          color: Colors.black,
          onPressed: () {
            setState(() {
              if (count[id] > 0) {
                count[id]--;
              }
            });
          })
    ]);
  }
}
