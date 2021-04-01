import 'package:firebase_database/firebase_database.dart';
import 'package:firstApp/EditProfilePage.dart';
import 'package:flutter/material.dart';
import 'main.dart' as glbls;

final dbref = FirebaseDatabase.instance.reference();
Map<dynamic, dynamic> map;
Future<void> getData() async {
  print(glbls.glbl);
  map = (await dbref.child("/users/" + glbls.glbl).once()).value;
  // print(map[glbls.glbl]['user']);
}

// ignore: camel_case_types
class profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getData();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff374ABE), Color(0xff64B6FF)],
          )),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              );
              // do something
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Container(
                height: 200,
                width: 200,
                alignment: Alignment.center,
                child: new Image(
                  image: new AssetImage("assets/images/login.png"),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.grey, Colors.cyanAccent],
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Table(
                          border: TableBorder(
                              bottom: BorderSide(color: Colors.black38),
                              horizontalInside:
                                  BorderSide(color: Colors.black38)),
                          children: [
                            _buildItem("Name", map.values.toList()[0]['user']),
                            _buildItem("Age", map.values.toList()[0]['age']),
                            _buildItem(
                                "Height", map.values.toList()[0]['height']),
                            _buildItem(
                                "Weight", map.values.toList()[0]['weight']),
                            _buildItem(
                                "BMI", map.values.toList()[0]['bmi'].toString()
                                // map.values.toList()[0]['weight'] /
                                //     map.values.toList()[0]['height']
                                ),
                            _buildItem("Calories intake per day",
                                map.values.toList()[0]['BMI'].toString()),
                          ],
                        )),
                    SizedBox(height: 30),
                    Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                        height: 50.0,
                        margin: EdgeInsets.all(10),
                        child: RaisedButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => Homepage()),
                            // );
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff374ABE),
                                    Color(0xff64B6FF)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 250.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Set A Goal",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
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
