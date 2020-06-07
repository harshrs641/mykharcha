// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mykhacha/services/usermanagement.dart';

// class SignInPage extends StatefulWidget {
//   @override
//   _SignInPageState createState() => _SignInPageState();
// }

// class _SignInPageState extends State<SignInPage> {
//   @override
//   var userfname = TextEditingController();
//   var userlname = TextEditingController();
//   var useremail = TextEditingController();
//   var usercpassword = TextEditingController();
//   var userpassword = TextEditingController();
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Theme.of(context).primaryColor,
//         appBar: AppBar(title: Text('SIGN IN')),
//         body: Column(children: <Widget>[
//           Container(),
//           Row(
//             children: <Widget>[
//               TextField(
//                   decoration: InputDecoration(labelText: 'First Name'),
//                   keyboardType: TextInputType.text,
//                   controller: userfname),
//               TextField(
//                   decoration: InputDecoration(labelText: 'Last Name'),
//                   keyboardType: TextInputType.text,
//                   controller: userlname),
//             ],
//           ),
//           TextField(
//               decoration: InputDecoration(labelText: 'Email'),
//               keyboardType: TextInputType.emailAddress,
//               controller: useremail),
//           TextField(
//               decoration: InputDecoration(labelText: 'Password'),
//               keyboardType: TextInputType.visiblePassword,
//               controller: userpassword),
//           TextField(
//               decoration: InputDecoration(labelText: 'Confirm Password'),
//               keyboardType: TextInputType.visiblePassword,
//               controller: usercpassword),
//           IconButton(
//               icon: Icon(Icons.check_circle),
//               onPressed: () {
//                 FirebaseAuth.instance
//                     .createUserWithEmailAndPassword(
//                         email: useremail.text, password: userpassword.text)
//                     .then((signedInUser) {
//                   UserManagement().storeNewUser(signedInUser, context);
//                 }).catchError((e) {
//                   print(e);
//                 });
//                 Navigator.of(context).pop();
//                 Navigator.of(context).pushNamed('/homepage');
//               })
//         ]));
//   }
// }
