import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './displayperday.dart';

import 'package:intl/intl.dart';

class Display extends StatelessWidget {
  Function delete;
  List<DocumentSnapshot> doc;
  Display(this.doc, this.delete);

  Widget build(BuildContext context) {
    if (doc.isNotEmpty) if (doc
            .singleWhere((d) => d.data['Title'] == '1')
            .data["Amount"] !=
        0) {
      return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          elevation: 5,
          child: Container(
            height: 70,
            padding: EdgeInsets.all(0.0),
            margin: EdgeInsets.all(2.0),
            child: ListTile(
                dense: false,
                leading: CircleAvatar(
                    radius: 25,
                    child: Icon(
                      Icons.account_balance_wallet,
                      size: 35,
                    )),
                title: Text(DateFormat.yMMMd().format(doc
                    .singleWhere((d) => d.data['Title'] == '1')
                    .data['Date']
                    .toDate())),
                subtitle: Text('Last Trans--' +
                    DateFormat.jms().format(doc
                        .singleWhere((d) => d.data['Title'] == '1')
                        .data['Date']
                        .toDate())),
                trailing: Text(
                  '-Rs.' +
                      doc
                          .singleWhere((d) => d.data['Title'] == '1')
                          .data["Amount"]
                          .toString(),
                  style: TextStyle(
                      color: Colors.red[600],
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  var route = new MaterialPageRoute(
                    builder: (BuildContext context) => new DisplayPD(
                        int.parse(DateFormat.d().format(doc
                            .singleWhere((d) => d.data['Title'] == '1')
                            .data['Date']
                            .toDate())),
                        delete),
                  );
                  Navigator.of(context).push(route);
                }),
          ));
    } else
      return Container();
    else
      return Container();
  }
}
