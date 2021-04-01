import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firstApp/homepage.dart';
import 'package:firstApp/login.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:firstApp/Alert.dart';

String glbl;
void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      title: new Text(
        'Welcome',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      seconds: 7,
      navigateAfterSeconds: AfterSplash(),
      image: new Image.asset('assets/images/splash.gif'),
      backgroundColor: Colors.white70,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 200.0,
      onClick: () => print("Flutter Egypt"),
      loaderColor: Colors.black,
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;
  final databaseReference = FirebaseDatabase.instance.reference();

  String un, pw;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 1500));
    _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.bounceOut,
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.transparent,
        body: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Image(
              image: new AssetImage("assets/images/background.jpeg"),
              fit: BoxFit.cover,
              color: Colors.black87,
              colorBlendMode: BlendMode.darken,
            ),
            SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  child: SizedBox(
                    height: 10,
                  ),
                ),
                Container(
                  height: 150,
                  child: Center(
                    child: Text(
                      'DietPlanner',
                      style: GoogleFonts.pinyonScript(
                        fontSize: 75,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                new Image(
                  image: new AssetImage("assets/images/logo.jpeg"),
                  width: _iconAnimation.value * 100,
                  height: _iconAnimation.value * 100,
                ),
                Container(
                  height: 75,
                  child: Center(
                    child: Text(
                      'Login',
                      style: GoogleFonts.pinyonScript(
                        fontSize: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                new Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: new Column(children: [
                      new Container(
                        child: SizedBox(
                          height: 20,
                        ),
                      ),

                      new Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[600].withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextField(
                          controller: emailController,
                          decoration: new InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlue, width: 5.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              labelText: 'Username',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              )),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      new Container(
                        child: SizedBox(
                          height: 30,
                        ),
                      ),

                      new Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[600].withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextField(
                          controller: passController,
                          obscureText: true,
                          decoration: new InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.lightBlue, width: 5.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        'forgot password?',
                        style:
                            GoogleFonts.lato(fontSize: 20, color: Colors.white),
                      ),
                      new Container(
                        child: SizedBox(
                          height: 20,
                        ),
                      ),
                      // new Container(
                      //   child:SizedBox(
                      //     height: 30,
                      //   ),
                      // ),

                      Container(
                        height: 50.0,
                        margin: EdgeInsets.all(10),
                        child: RaisedButton(
                          onPressed: () {
                            validate();
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
                                "Sign in",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 50.0,
                        margin: EdgeInsets.all(10),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()),
                            );
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
                                "New User?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]))
              ],
            ))
          ],
        ));
  }

  Future<int> validate() async {
    Map<dynamic, dynamic> map =
        (await databaseReference.child("/users").once()).value;

    var i;
    for (i in map.keys) {
      if (map[i]['details']['user'] == emailController.text) {
        if (map[i]['details']['password'] == passController.text) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Homepage()),
          );
          break;
        } else {
          showAlertDialog(context, "Error", "Username/password is wrong");
        }
      }
    }
    //   // void Validate() {
    //   //   databaseReference.once().then((DataSnapshot snapshot) {
    //   //     print('Data : ${snapshot.value}');
    //   //     Map<dynamic, dynamic> map = snapshot.value;
    //   //     // print(map.values.toList()[0][1]['details']['password']);
    //   //     // pw = map.values.toList()[0][0]['details']['password'];
    //   //     // un = map.values.toList()[0][0]['details']['user'];
    //   //     for (var i = 0; i < map.length; i++) {
    //   //       if (map.values.toList()[0][i]['details']['user'] ==
    //   //           emailController.text) {
    //   //         if (map.values.toList()[0][i]['details']['password'] ==
    //   //             passController.text) {
    //   //           Navigator.push(
    //   //             context,
    //   //             MaterialPageRoute(builder: (context) => Homepage()),
    //   //           );
    //   //         } else {
    //   //           print("wrong Password");
    //   //         }
    //   //       } else {
    //   //         print("Invalid user ");
    //   //       }
    //   //     }
    //   //     // Map<dynamic, dynamic> details = map.values.toList()[0];
    //   //     // Map<dynamic, dynamic> det = details.values.toList()[0];
    //   //     // print(details);
    //   //     // print(det);
    //   //     //    values.forEach((un,v) {
    //   //     //     print(k);
    //   //     //     print(v["name"]);
    //   //     //  });
    //   //   });
    //   // }
    print(i);
    glbl = i;
  }
}
