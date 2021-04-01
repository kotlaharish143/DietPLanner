// import 'package:flutter/material.dart';
// import 'Theme.dart';
// import 'package:firebase_database/firebase_database.dart';

// class Register extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         theme: ThemeData(
//           brightness: Brightness.dark,
//           primaryColor: Colors.black,
//           accentColor: Colors.white,
//           scaffoldBackgroundColor: Colors.black,
//           textSelectionHandleColor: Colors.white,
//           textSelectionColor: Colors.white,
//           cursorColor: Colors.white,
//           toggleableActiveColor: Colors.black,
//           inputDecorationTheme: InputDecorationTheme(
//             border: const OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.white),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.white),
//             ),
//             focusedBorder: const OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.blueAccent),
//             ),
//             labelStyle: const TextStyle(
//               color: Colors.white,
//             ),
//           ),
//         ),
//         home: Scaffold(
//           appBar: AppBar(
//             title: const Text('Sign Up'),
//             centerTitle: true,
//             elevation: 0.0,
//           ),
//           body: const SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
//               child: RegisterForm(),
//             ),
//           ),
//         ));
//   }
// }

// class RegisterForm extends StatefulWidget {
//   const RegisterForm({Key key}) : super(key: key);

//   @override
//   _RegisterFormState createState() => _RegisterFormState();
// }

// class _RegisterFormState extends State<RegisterForm> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   final databaseReference = FirebaseDatabase.instance.reference();
//   bool _agreedToTOS = true;
//   String us, pw;
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           SizedBox(
//               height: 155.0,
//               width: 180,
//               child: Center(
//                 child: Image.asset(
//                   "./assets/a.png",
//                   fit: BoxFit.contain,
//                   alignment: Alignment.center,
//                 ),
//               )),
//           TextFormField(
//             decoration: const InputDecoration(
//               labelText: 'Email',
//             ),
//             validator: (String value) {
//               us = value;
//               if (value.trim().isEmpty) {
//                 return 'Nickname is required';
//               }
//             },
//           ),
//           const SizedBox(height: 16.0),
//           TextFormField(
//             decoration: const InputDecoration(
//               labelText: 'Password',
//             ),
//             validator: (String value) {
//               pw = value;
//               if (value.trim().isEmpty) {
//                 return 'Full name is required';
//               }
//             },
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16.0),
//             child: Row(
//               children: <Widget>[
//                 Checkbox(
//                   value: _agreedToTOS,
//                   onChanged: _setAgreedToTOS,
//                 ),
//                 GestureDetector(
//                   onTap: () => _setAgreedToTOS(!_agreedToTOS),
//                   child: const Text(
//                     'I agree to the Terms of Services and Privacy Policy',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             children: <Widget>[
//               // OutlineButton(
//               //   highlightedBorderColor: Colors.black,
//               //   onPressed: _submittable() ? _submit : null,
//               //   child: const Text('Register'),
//               // ),
//               SizedBox(height: 40.0),
//               Container(
//                 width: 375,
//                 height: 40.0,
//                 child: Material(
//                   borderRadius: BorderRadius.circular(10.0),
//                   shadowColor: Colors.blueAccent,
//                   color: Colors.black,
//                   elevation: 10.0,
//                   child: GestureDetector(
//                     onTap: _submittable(us, pw) ? _submit : null,
//                     child: Center(
//                         child: Text(
//                       'Register',
//                       style: TextStyle(color: Colors.white),
//                     )),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   bool _submittable(us, pw) {
//     createRecord(us, pw);
//     return _agreedToTOS;
//   }

//   void createRecord(us, pw) {
//     print("create record called");
//     print(us);
//     databaseReference.child("4").set({'user': us, 'password': pw});
//   }

//   void _submit() {
//     _formKey.currentState.validate();

//     print('Form submitted');
//   }

//   void _setAgreedToTOS(bool newValue) {
//     setState(() {
//       _agreedToTOS = newValue;
//     });
//   }
// }
