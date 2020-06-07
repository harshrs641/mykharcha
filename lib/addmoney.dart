import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './global_var.dart';

import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AddMoney {
  Future<void> addMoney(String title, int amt, DateTime d) async {
    String day = DateFormat.d().format(d);
    String mon = DateFormat.MMM().format(d);
    String year = DateFormat.y().format(d);
    var docSnap = await Firestore.instance
        .collection(user)
        .document(mon + year + 'Money')
        .get()
        .then((doc) => doc);
    if (docSnap.data == null) {
      Firestore.instance
          .collection(user)
          .document(mon + year + 'Money')
          .setData({'Savings': 0});
    }
    int savings = await Firestore.instance
        .collection(user)
        .document(mon + year + 'Money')
        .get()
        .then((s) => s.data['Savings']);
    await Firestore.instance
        .collection(user)
        .document(mon + year + 'Money')
        .setData({'Savings': savings += amt});
    await Firestore.instance
        .collection(user)
        .document(mon + year + 'Money')
        .collection(day)
        .add({'Title': title, 'Amount': amt, 'Date': d});
  }

  Widget totalSavings() {
    return Center(
        child: StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance
                .collection(user)
                .document(oval + y + 'Money')
                .snapshots(),
            builder: (context, snap) {
              // if(snap.hasData)
              return StreamBuilder(
                  stream: Firestore.instance
                      .collection(user)
                      .document(oval + y)
                      .snapshots(),
                  builder: (context, snapShot) {
                    if (snap.hasData && snapShot.hasData) {
                      if (snap.data.data != null &&
                          snapShot.data.data != null) {
                        return Text(
                          "Rs." +
                              (snap.data.data['Savings'] -
                                      snapShot.data.data['TotalAmount'])
                                  .toString(),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        );
                      } else if (snap.data.data != null &&
                          snapShot.data.data == null) {
                        return Text(
                          "Rs." + (snap.data.data['Savings']).toString(),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        );
                      } else if (snap.data.data == null &&
                          snapShot.data.data != null) {
                        return Text(
                          "Rs.-" +
                              (snapShot.data.data['TotalAmount']).toString(),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        );
                      } else {
                        return Text("Rs.0",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold));
                      }
                    } else
                      return Text("Rs.0",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold));
                  });
            }));
  }
}
// return Text(
//   "Rs." +
//       ((snap.data.data != null&& snapShot.data.data != null)
//           ? (snap.data.data['Savings']-snapShot.data.data['TotalAmount']).toString()
//           : "0"),
//   style: TextStyle(
//       fontSize: 20,
//       color: Colors.white,
//       fontWeight: FontWeight.bold),
// );
// }else if(snap.data.data != null)
// return
// else
// return Text("Rs.0",
//     style: TextStyle(
//         fontSize: 20,
//         color: Colors.white,
//         fontWeight: FontWeight.bold));
