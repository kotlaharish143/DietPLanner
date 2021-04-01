import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firstApp/Goal.dart';
import 'package:firebase_database/firebase_database.dart';
import 'main.dart' as glbls;
import 'Goal.dart' as g;

int cals;
Map<dynamic, dynamic> map;
Future<void> getUserData() async {
  print(glbls.glbl);
  map = (await databaseReference.child("/users/" + glbls.glbl).once()).value;

  // print(map[glbls.glbl]['user']);
}

void dbEnter() {
  print("----------------------------");
  print(cals);
  print("------------------------------");
  databaseReference
      .child("users/" + glbls.glbl + "/details")
      .update({"left": cals});
}

void dbenter(calco) {
  databaseReference
      .child("users/" + glbls.glbl + "/details")
      .update({"rc": calco});
}

double bmr;
int calc, dbcalc;
void calCalories(w, t, cal, dur) {
  double w1 = double.parse(w);
  int t1 = int.parse(t);
  double rw = w1 - t1;
  double x = rw / 0.453592;
  double rc = x * 3500;
  rc = rc / double.parse(dur);
  double temp = (cal - rc);
  calc = temp.ceil();
  dbenter(calc);
  print(rc);

  cals = calc;
}

List count = List<int>();
List<dynamic> finalfoods = [];
List<int> finalcounts = [];
var glbl = glbls.glbl;
List<dynamic> fooditems;
final databaseReference = FirebaseDatabase.instance.reference();
Future<void> getData() async {
  print("MyHomePageState");

  fooditems = (await databaseReference.child("/foods").once()).value;
  // cals = map.values.toList()[0]['rc'];
}

void setData() {
  for (int i = 1; i < fooditems.length; i++) {
    if (count[i] > 0) {
      // print(fooditems[i]);
      finalfoods.add(fooditems[i]);

      finalcounts.add(count[i]);
    }
  }
  // databaseReference.child("users/" + glbl + "/details").update({"foods":});
}

class feed extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<feed> {
  void initState() {
    getUserData();
    getData();
    calCalories(
        map.values.toList()[0]['weight'],
        map.values.toList()[0]['target'],
        map.values.toList()[0]['BMI'],
        map.values.toList()[0]['duration']);
    print(cals);
    super.initState();
    for (int i = 0; i < fooditems.length + 1; i++) {
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
          Padding(
            padding: EdgeInsets.only(left: 0),
            child: Column(
              children: <Widget>[
                Text('Diet Plan',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 36.0)),
                SizedBox(width: 10.0),
                Container(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    onPressed: () {
                      finalfoods.clear();
                      setData();
                      dbEnter();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Goal()),
                      );
                    },
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("Add Foods to Diet",
                        style: TextStyle(color: Colors.black)),
                  ),
                  width: 300,
                ),

                // Text('Diabetic',
                //     style: TextStyle(
                //         fontFamily: 'Montserrat',
                //         color: Colors.white,
                //         fontWeight: FontWeight.bold,
                //         fontSize: 25.0))

                Text(cals.toString() + " cal",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 35))
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
                    for (var i = 1; i < fooditems.length; i++)
                      _buildItem(fooditems[i]['item'],
                          fooditems[i]['cal'].toString(), i)
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
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
              cals -= fooditems[id]['cal'];
              print(cals);
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
                cals += fooditems[id]['cal'];
                print(cals);
                count[id]--;
              }
            });
          })
    ]);
  }

//   bool check() {
//     bool flag = true;

//     return flag;
//   }
// }
}
