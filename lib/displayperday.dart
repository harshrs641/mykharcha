import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './global_var.dart';
import 'package:intl/intl.dart';

class DisplayPD extends StatefulWidget {
  int i;
  Function dele;
  DisplayPD(this.i, this.dele);

  @override
  _DisplayPDState createState() => _DisplayPDState(i, dele);
}

class _DisplayPDState extends State<DisplayPD> {
  int i;
  Function dele;
  _DisplayPDState(this.i, this.dele);

  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection(user)
            .document(oval+y)
            .collection(i.toString())
            .snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData)
          return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xff23b6e6),
                title: Text(DateFormat.yMMMd()
                    .format(snapshot.data.documents[0].data['Date'].toDate())),
              ),
              body: Column(children: <Widget>[
                Container(
                    height: 775,
                    child: SingleChildScrollView(
                        child: (snapshot.hasData)
                            ? (snapshot.data.documents.isNotEmpty)
                                ? Column(children: <Widget>[
                                    ...snapshot.data.documents
                                        .map(
                                            (tx1) =>
                                                tx1.data['Amount'] != 0 &&
                                                        tx1.data['Title'] != '1'
                                                    ? Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 10),
                                                        child: Stack(
                                                            children: <Widget>[
                                                              Container(
                                                                height: 75,
                                                                margin: new EdgeInsets
                                                                        .only(
                                                                    left: 50.0),
                                                                child: Card(
                                                                    elevation:
                                                                        5,
                                                                    child: Dismissible(
                                                                        background: Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                const BorderRadius.all(
                                                                              Radius.circular(5),
                                                                            ),
                                                                            color:
                                                                                Colors.red,
                                                                          ),
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              Row(children: <Widget>[
                                                                            Icon(
                                                                              Icons.delete,
                                                                              color: Colors.white,
                                                                            ),
                                                                            Text(
                                                                              'DELETE',
                                                                              style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                                                            )
                                                                          ]),
                                                                        ),
                                                                        key: UniqueKey(),
                                                                        child: ListTile(
                                                                          dense:
                                                                              false,
                                                                          contentPadding:
                                                                              EdgeInsets.all(0.0),
                                                                          leading:
                                                                              SizedBox(),
                                                                          title:
                                                                              Text(tx1.data['Title']),
                                                                          subtitle: Text(DateFormat.yMMMd().format(tx1
                                                                              .data['Date']
                                                                              .toDate())),
                                                                        ),
                                                                        onDismissed: (DismissDirection direction) async {
                                                                          int ta = await Firestore
                                                                              .instance
                                                                              .collection(user)
                                                                              .document(oval+y)
                                                                              .get()
                                                                              .then((dt) => dt.data['TotalAmount']);
                                                                          await Firestore
                                                                              .instance
                                                                              .collection(
                                                                                  user)
                                                                              .document(
                                                                                  oval+y)
                                                                              .updateData({
                                                                            'TotalAmount':
                                                                                ta - tx1.data["Amount"]
                                                                          });
                                                                          int thatDay = await Firestore
                                                                              .instance
                                                                              .collection(user)
                                                                              .document(oval+y)
                                                                              .get()
                                                                              .then((dt) => dt.data[DateFormat.d().format(tx1.data['Date'].toDate())]);
                                                                          await Firestore
                                                                              .instance
                                                                              .collection(
                                                                                  user)
                                                                              .document(
                                                                                  oval+y)
                                                                              .updateData({
                                                                            DateFormat.d().format(tx1.data['Date'].toDate()):
                                                                                thatDay - tx1.data["Amount"]
                                                                          });

                                                                          if ((snapshot.data.documents.singleWhere((d) => d.data['Title'] == '1').data['Amount'] !=
                                                                              tx1.data['Amount'])) {
                                                                            // dele(tx1);

                                                                            int a =
                                                                                snapshot.data.documents.singleWhere((d) => d.data['Title'] == '1').data['Amount'] - tx1.data['Amount'];
                                                                            await Firestore.instance.collection(user).document(oval+y).collection(DateFormat.d().format(tx1.data['Date'].toDate())).document('Total').updateData({
                                                                              'Amount': a
                                                                            });
                                                                            await Firestore.instance.collection(user).document(oval+y).collection(DateFormat.d().format(tx1.data['Date'].toDate()).toString()).document(tx1.documentID).delete();
                                                                            setState(() {});
                                                                          } else {
                                                                            int a =
                                                                                snapshot.data.documents.singleWhere((d) => d.data['Title'] == '1').data['Amount'] - tx1.data['Amount'];
                                                                            await Firestore.instance.collection(user).document(oval+y).collection(DateFormat.d().format(tx1.data['Date'].toDate())).document('Total').updateData({
                                                                              'Amount': a
                                                                            });

                                                                            await Firestore.instance.collection(user).document(oval+y).collection(DateFormat.d().format(tx1.data['Date'].toDate()).toString()).document(tx1.documentID).delete();
                                                                            Navigator.of(context).pop();
                                                                          }
                                                                        })),
                                                              ),
                                                              Container(
                                                                child:
                                                                    CircleAvatar(
                                                                  backgroundColor:
                                                                      Color(
                                                                          0xff23b6e6),
                                                                  radius: 40,
                                                                  child: Text(
                                                                    'Rs.' +
                                                                        (tx1.data['Amount'])
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              ),
                                                            ]),
                                                      )
                                                    : Container())
                                        .toList()
                                  ])
                                : Container()
                            : Container()))
              ]));
              else
 return Container(
        height: 650,
        width: 200,
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.white.withOpacity(0.2), BlendMode.dstATop),
                image: AssetImage('lib/images/rupeeEmpty.png'))));
        });
  }
}
