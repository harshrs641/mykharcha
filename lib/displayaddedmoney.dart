import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import './global_var.dart';

import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class DisplayAM extends StatefulWidget {
  @override
  _DisplayAMState createState() => _DisplayAMState();
}

class _DisplayAMState extends State<DisplayAM> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Added This Month:', style: TextStyle(fontSize: 20)),
        actions: <Widget>[totalAdded()],
      ),
      body: ListView.builder(
          itemCount: 31,
          itemBuilder: (context, index) {
            return Column(children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection(user)
                    .document(oval+y + 'Money')
                    .collection(index.toString())
                    .snapshots(),
                builder: (context, snap) {
                  if (snap.hasData)
                    return Column(children: [
                      ...snap.data.documents.map((doc) => buildList(doc, index))
                    ]);
                  else
                    return Container();
                },
              )
            ]);
          }),
    );
  }
Widget empty(){return Container(
              child: Center(
                  child: Text(
                'Rs.0' ,
                style: TextStyle(fontSize: 17),
              )),
            );}
  Widget totalAdded() {
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance
          .collection(user)
          .document(oval+y + 'Money')
          .snapshots(),
      builder: (context, snap) {
        if (snap.hasData) {
          if (snap.data.data != null  ){
          if(snap.data.data['Savings']!=null)
            return Container(
              child: Center(
                  child: Text(
                'Rs.' + snap.data.data['Savings'].toString(),
                style: TextStyle(fontSize: 17),
              )),
            );
            else return empty();
           } else
            return empty();
        } else
          return empty();
      },
    );
  }

  Widget buildList(DocumentSnapshot doc, int index) {
    if (doc.data != null)
      return Container(
          margin: const EdgeInsets.only(top: 10),
          child: Stack(children: <Widget>[
            Container(
                height: 75,
                margin: new EdgeInsets.only(left: 50.0),
                child: Card(
                    elevation: 5,
                    child: Dismissible(
                        background: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                            color: Colors.red,
                          ),
                          alignment: Alignment.centerLeft,
                          child: Row(children: <Widget>[
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            Text(
                              'DELETE',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                        ),
                        key: UniqueKey(),
                        child: ListTile(
                          dense: false,
                          contentPadding: EdgeInsets.all(0.0),
                          leading: SizedBox(),
                          title: Text(doc.data['Title']),
                          subtitle: Text(DateFormat.yMMMd()
                              .format(doc.data['Date'].toDate())),
                          trailing: Text(
                            '+Rs.' + (doc.data['Amount']).toString(),
                            style: TextStyle(
                                color: Colors.teal,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onDismissed: (DismissDirection direction)async{await deleteAdded(doc, index.toString());}))),
            Container(
              child: CircleAvatar(
                  backgroundColor: Color(0xff23b6e6),
                  radius: 40,
                  child: Icon(
                    Icons.account_balance_wallet,
                    size: 45,
                    color: Colors.white,
                  )),
            ),
          ]));
    else
      return Container();
  }

  Future<void> deleteAdded(DocumentSnapshot doc, String i) async {
    int total = await Firestore.instance
        .collection(user)
        .document(oval+y + 'Money')
        .get()
        .then((value) => value.data['Savings']);
    int amt = await Firestore.instance
        .collection(user)
        .document(oval+y + 'Money')
        .collection(i)
        .document(doc.documentID)
        .get()
        .then((value) => value.data['Amount']);
    await Firestore.instance
        .collection(user)
        .document(oval+y + 'Money')
        .updateData({'Savings': total -= amt});
    if (total == 0) {
      await Firestore.instance
          .collection(user)
          .document(oval+y + 'Money')
          .collection(i)
          .document(doc.documentID)
          .delete();
      Navigator.of(context).pop();
    } else {
      await Firestore.instance
          .collection(user)
          .document(oval+y + 'Money')
          .collection(i)
          .document(doc.documentID)
          .delete();
    }
  }
}
