import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mykhacha/addmoney.dart';
import 'package:mykhacha/displayaddedmoney.dart';
import 'package:mykhacha/phoneauth.dart';
import 'package:mykhacha/services/usermanagement.dart';
import './display.dart';
import './dropdownmenu.dart';
import './global_var.dart';
import './charts.dart';
import './new_list.dart';

import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/phoneauth': (BuildContext context) => PhoneAuth(),
        '/homepage': (BuildContext context) => MyHomePage(),
      },
      home: AuthService().handleAuth(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.teal,
        cardTheme: CardTheme(color: Colors.white),
        bottomSheetTheme:
            BottomSheetThemeData(modalBackgroundColor: Colors.white),
        // Color.fromRGBO(92, 138, 178, 100)),
        buttonTheme: ButtonThemeData(
          focusColor: Color(0xff232d37),
        ),
      ),
      title: 'Expenses',
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  Future<void> newAdd(String txttitle, int txtamount, DateTime dt) async {
    String d = DateFormat.d().format(dt);
    String mon = DateFormat.MMM().format(dt);
    String year = DateFormat.y().format(dt);

    var docData = await Firestore.instance
        .collection(user)
        .document(mon + year)
        .get()
        .then((ds) => ds);
    if (docData.data == null) {
      await Firestore.instance
          .collection(user)
          .document(mon + year)
          .setData({'TotalAmount': 0}, merge: true);
      // await Firestore.instance
      //     .collection(user)
      //     .document(mon+year)
      //     .setData({'0': 1}, merge: true);
      await Firestore.instance
          .collection(user)
          .document(mon + year)
          .setData({'Highest': 5000}, merge: true);
    }
    docData = await Firestore.instance
        .collection(user)
        .document(mon + year)
        .get()
        .then((ds) => ds);
    int totalAmount = docData.data['TotalAmount'];
    await Firestore.instance
        .collection(user)
        .document(mon + year)
        .updateData({'TotalAmount': totalAmount += txtamount}); //WHOLE MONTH

    var queryData = await Firestore.instance
        .collection(user)
        .document(mon + year)
        .collection(d)
        .document('Total')
        .get()
        .then((dd) => dd);
    if (queryData.data == null) {
      await Firestore.instance
          .collection(user)
          .document(mon + year)
          .collection(d)
          .document('Total')
          .setData({'Title': '1', 'Amount': 0, 'Date': dt});
      await Firestore.instance
          .collection(user)
          .document(mon + year)
          .setData({d: 0}, merge: true);
    }
    queryData = await Firestore.instance
        .collection(user)
        .document(mon + year)
        .collection(d)
        .document('Total')
        .get()
        .then((dd) => dd);
    int totalDay = queryData.data['Amount'];
    await Firestore.instance
        .collection(user)
        .document(mon + year)
        .collection(d)
        .document('Total')
        .updateData(
            {'Title': '1', 'Amount': totalDay += txtamount, 'Date': dt});
    if (totalDay > 5000)
      await Firestore.instance
          .collection(user)
          .document(mon + year)
          .updateData({'Highest': 10000});
    await Firestore.instance
        .collection(user)
        .document(mon + year)
        .updateData({d: totalDay}); //Whole Day

    await Firestore.instance
        .collection(user)
        .document(mon + year)
        .collection(d)
        .add({'Title': txttitle, 'Amount': txtamount, 'Date': dt}); //That Day
    setState(() {});
  }

  void update() {
    setState(() {});
  }

  void start(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: ctx,
        builder: (_) =>
            FractionallySizedBox(heightFactor: 0.65, child: NewList(newAdd)));
  }

  void dialog(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (_) => AlertDialog(
              backgroundColor: Colors.teal[800],
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              content: Text(
                'Are you sure you want to logout?',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      AuthService().signOut();
                    },
                    child: Text('Yes',
                        style: TextStyle(
                          color: Colors.black,
                        ))),
                FlatButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: Text(
                      'No',
                      style: TextStyle(color: Colors.black, fontSize: 50),
                    ))
              ],
            ));
  }

  void delete(DocumentSnapshot d) {
    setState(() {});
  }

  Future<String> getUser() async {
    user = await FirebaseAuth.instance.currentUser().then((u) => u.uid);
    return user;
  }

  Container empty() {
    return Container(
        height: 650,
        width: 200,
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.white.withOpacity(0.2), BlendMode.dstATop),
                image: AssetImage('lib/images/rupeeEmpty.png'))));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("MyKharcha"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.exit_to_app), onPressed: () => dialog(context))

            // },),
          ],
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: getUser(),
              builder: (context, s) {
                if (s.hasData)
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              width: 160,
                              child: RaisedButton(
                                  elevation: 15,
                                  onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => DisplayAM())),
                                  child: AddMoney().totalSavings())),
                          DropMenu(update),
                          Container(
                            width: 151,
                            height: 35,
                            decoration: BoxDecoration(
                                color: Color(0xff23b6e6),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                            child: Center(
                              child: StreamBuilder<DocumentSnapshot>(
                                  stream: Firestore.instance
                                      .collection(user)
                                      .document(oval + y)
                                      .snapshots(),
                                  builder: (context, snap) {
                                    if (snap.hasData) {
                                      return Text(
                                        "Rs." +
                                            ((snap.data.data != null)
                                                ? snap.data.data['TotalAmount']
                                                    .toString()
                                                : "0"),
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      );
                                    } else
                                      return Text("Rs.0",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold));
                                  }),
                            ),
                          ),
                        ],
                      ),
                      StreamBuilder<DocumentSnapshot>(
                          stream: Firestore.instance
                              .collection(user)
                              .document(oval + y)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.data != null) {
                                if (snapshot.data.data['TotalAmount'] != 0)
                                  return new LineChartSample2();
                                else
                                  return empty();
                              } else
                                return empty();
                            } else
                              return empty();
                          }),
                      Container(
                        height: 500,
                        child: ListView.builder(
                            itemCount: 31,
                            itemBuilder: (context, index) {
                              return Column(children: <Widget>[
                                StreamBuilder<QuerySnapshot>(
                                  stream: Firestore.instance
                                      .collection(user)
                                      .document(oval + y)
                                      .collection(index.toString())
                                      .snapshots(),
                                  builder: (context, snap) {
                                    if (snap.hasData)
                                      return Column(children: <Widget>[
                                        Display(snap.data.documents, delete)
                                      ]);
                                    else
                                      return Container();
                                  },
                                )
                              ]);
                            }),
                      ),
                    ],
                  );
                else
                  return Container();
              }),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: () => start(context)));
  }
}
