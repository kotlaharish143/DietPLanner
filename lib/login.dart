import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_database/firebase_database.dart';
// ignore: unused_import
import 'Theme.dart';
import 'Alert.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

String un, pw, a, h, w;
String g = "male";
enum Gender { Male, Female }
var uid = Uuid();
String dropdownValue = "Sendentary";

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          // brightness: Brightness.dark,
          primaryColor: Colors.white,
          accentColor: Colors.white,
          textSelectionHandleColor: Colors.white,
          textSelectionColor: Colors.white,
          cursorColor: Colors.white,
          toggleableActiveColor: Colors.black,
          inputDecorationTheme: InputDecorationTheme(
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent),
            ),
            labelStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        home: Scaffold(
          // appBar: AppBar(
          //   title: const Text('Sign Up'),
          //   centerTitle: true,
          //   elevation: 0.0,
          // ),
          body: SingleChildScrollView(
            child: Column(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.85), BlendMode.darken),
                      image: new AssetImage("assets/images/background.jpeg"),
                      fit: BoxFit.cover),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                  child: RegisterForm(),
                ),
              )
            ]),
          ),
        ));
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final databaseReference = FirebaseDatabase.instance.reference();

  bool _agreedToTOS = true;
  Gender _site = Gender.Male;

  int i = 1;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            height: 150,
            width: double.infinity,
            child: Center(
              child: Text(
                'DietPlanner',
                style: GoogleFonts.pinyonScript(
                  fontSize: 68,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
              height: 100.0,
              width: 180,
              child: Center(
                child: Image.asset(
                  "./assets/images/logo.jpeg",
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  height: 100,
                  width: 100,
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 75,
            child: Center(
              child: Text(
                'Register',
                style: GoogleFonts.pinyonScript(
                  fontSize: 50,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          TextFormField(
            decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue, width: 5.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'UserName',
                labelStyle: TextStyle(
                  color: Colors.white,
                )),
            validator: (String value) {
              un = value;
              if (value.trim().isEmpty) {
                return 'UserName is required';
              }
            },
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            obscureText: true,
            style: TextStyle(color: Colors.white),
            decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue, width: 5.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Colors.white,
                )),
            validator: (String value) {
              pw = value;
              if (value.trim().isEmpty) {
                return 'Password is required';
              }
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            obscureText: true,
            style: TextStyle(color: Colors.white),
            decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue, width: 5.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Confirm Password',
                labelStyle: TextStyle(
                  color: Colors.white,
                )),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Confirm Password is required';
              }
            },
          ),
          const SizedBox(height: 16.0),
          Text(
            'Personal Info',
            style: GoogleFonts.pinyonScript(
              fontSize: 32,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue, width: 5.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Age',
                labelStyle: TextStyle(
                  color: Colors.white,
                )),
            validator: (String value) {
              a = value;
              if (value.trim().isEmpty) {
                return 'Enter Your age in Number';
              }
            },
          ),
          const SizedBox(height: 16.0),
          Theme(
            data: ThemeData.dark(), //set the dark theme or write your own theme
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Flexible(
                  child: ListTile(
                    title: Text(
                      'Male',
                      style: GoogleFonts.pinyonScript(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    leading: Radio(
                      // activeColor: Colors.white,
                      // focusColor: Colors.white,
                      // hoverColor: Colors.white,
                      autofocus: true,
                      value: Gender.Male,
                      groupValue: _site,
                      onChanged: (Gender value) {
                        setState(() {
                          _site = value;
                        });
                      },
                    ),
                  ),
                ),
                new Flexible(
                  child: ListTile(
                    title: Text(
                      'Female',
                      style: GoogleFonts.pinyonScript(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    leading: Radio(
                      value: Gender.Female,
                      groupValue: _site,
                      onChanged: (Gender value) {
                        setState(() {
                          _site = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue, width: 5.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Height(in cms)',
                labelStyle: TextStyle(
                  color: Colors.white,
                )),
            validator: (String value) {
              h = value;
              if (value.trim().isEmpty) {
                return 'Enter height in Numbers';
              }
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue, width: 5.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Weight(in Kgs)',
                labelStyle: TextStyle(
                  color: Colors.white,
                )),
            validator: (String value) {
              w = value;
              if (value.trim().isEmpty) {
                return 'Enter weight in Numbers';
              }
            },
          ),
          SizedBox(height: 16),
          Theme(
            data: ThemeData.dark(),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              margin: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Text(
                    "ACTIVITY",
                    style: TextStyle(color: Colors.white),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        items: [
                          DropdownMenuItem(
                            child: Text("Sendentary : little or No Exercise"),
                            value: "Sendentary",
                          ),
                          DropdownMenuItem(
                            child: Text("Light : Exercise 1-3 times per week "),
                            value: "Light",
                          ),
                          DropdownMenuItem(
                              child: Text(
                                  "Moderate : Exercise 4-5 times per week"),
                              value: "Moderate"),
                          DropdownMenuItem(
                              child: Text(
                                  "Active : intence Exercise 6-7 times per week"),
                              value: "Active"),
                          DropdownMenuItem(
                              child: Text(
                                  "Very Active :  Very intence Exercise daily or physical Job"),
                              value: "Very Active"),
                        ],
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value;
                          });
                        }),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: _agreedToTOS,
                  onChanged: _setAgreedToTOS,
                ),
                GestureDetector(
                  onTap: () => _setAgreedToTOS(!_agreedToTOS),
                  child: const Text(
                    'I agree to the Terms of Services',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 40.0,
            child: Material(
              borderRadius: BorderRadius.circular(10.0),
              shadowColor: Colors.blueAccent,
              color: Colors.blueAccent,
              elevation: 10.0,
              child: GestureDetector(
                onTap: _submittable() ? _submit : null,
                child: Center(
                    child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  var bmr, calc, _bmi;
  void calculateBMI() {
    _bmi = int.parse(w) / pow(int.parse(h) / 100, 2);
  }

  void calCalories() {
    print(g);
    calculateBMI();
    if (g == "male") {
      bmr = 5 + (10 * int.parse(w)) + 6.25 * int.parse(h) - 5 * int.parse(a);
    }
    if (g == "female") {
      bmr = (10 * int.parse(w)) + 6.25 * int.parse(h) - 5 * int.parse(h) - 161;
    }
    if (dropdownValue == "Sendentary") {
      calc = bmr * 1.2;
    }
    if (dropdownValue == "Light") {
      calc = bmr * 1.375;
    }
    if (dropdownValue == "Moderate") {
      calc = bmr * 1.55;
    }
    if (dropdownValue == "Active") {
      calc = bmr * 1.725;
    }
    if (dropdownValue == "Very Active") {
      calc = bmr * 1.9;
    }
  }

  void createRecord(un, pw, a, g, h, w) {
    print(un);
    print(w);
    calCalories();
    print(calc);
    databaseReference.child("users/" + uid.v1() + "/details").set({
      'user': un,
      'password': pw,
      'age': a,
      'gender': g,
      "height": h,
      "weight": w,
      "Activity": dropdownValue,
      "BMI": calc,
      "bmi": _bmi,
      "duration": "1",
      "target": "0",
      "left": "0"
    });
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  void _submit() {
    _formKey.currentState.validate();
    createRecord(un, pw, a, g, h, w);
    showAlertDialog(context, "Success", "Registration Succesful");
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }
}
