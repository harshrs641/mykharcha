// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class LogInPage extends StatefulWidget {
//   @override
//   _LogInPageState createState() => _LogInPageState();
// }

// class _LogInPageState extends State<LogInPage> {
//   @override
//   var useremail = TextEditingController();
//   var userpassword = TextEditingController();
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Theme.of(context).primaryColor,
//         appBar: AppBar(title: Text('LOGIN')),
//         body: Column(children: <Widget>[
//           Container(),
//           TextField(
//               decoration: InputDecoration(labelText: 'Email'),
//               keyboardType: TextInputType.emailAddress,
//               controller: useremail),
//           TextField(
//               decoration: InputDecoration(labelText: 'Password'),
//               keyboardType: TextInputType.visiblePassword,
//               controller: userpassword),
//           IconButton(
//               icon: Icon(Icons.check_circle),
//               onPressed: () {
//                 FirebaseAuth.instance
//                     .signInWithEmailAndPassword(
//                         email: useremail.text, password: userpassword.text)
//                     .then((user) {
//                   Navigator.of(context).pushReplacementNamed('/homepage');
//                 }).catchError((e) {
//                   print(e);
//                 });
//               }),
//           Row(children: <Widget>[
//             Text('Dont\'t have an account'),
//             RaisedButton(
//                 child: Text('SignIn'),
//                 onPressed: () {
//                   Navigator.of(context).pushNamed('/signin');
//                 })
//           ])
//         ]));
//   }
// }
