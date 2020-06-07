import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mykhacha/addmoney.dart';

class NewList extends StatefulWidget {
  final Function addone;

  NewList(this.addone);

  @override
  _NewListState createState() => _NewListState();
}

class _NewListState extends State<NewList> {
  String title;

  int amount;

  DateTime date;

  var titlecontrol = TextEditingController();

  var amtcontrol = TextEditingController();
  DateTime selecteddate = DateTime.now();

  void showdatepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((picked) {
      if (picked == null)
        return;
      else
        selecteddate = picked;
    });
  }

  void submitdata() {
    var enteredtitle = titlecontrol.text;
    var enteredamount = int.parse(amtcontrol.text);
    if (enteredtitle.isEmpty || enteredamount <= 0 || selecteddate == null)
      return;
    else {
     (savings)?AddMoney().addMoney(enteredtitle, enteredamount, selecteddate): widget.addone(enteredtitle, enteredamount, selecteddate);
    }
    Navigator.of(context).pop();
  }

  bool savings = false;
  Color colour;
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          width: 200,
          child: RaisedButton(
              elevation: 5,
              color: Colors.teal,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)),
              child: Text(
                'ADD TRANSACTION',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: submitdata)), 
      TextField(
          decoration: InputDecoration(
              icon: Icon(Icons.add_shopping_cart), labelText: 'TITLE'),
          controller: titlecontrol,
          onSubmitted: (_) => submitdata()),
      TextField(
          decoration: InputDecoration(
              icon: Icon(Icons.account_balance_wallet), labelText: 'AMOUNT'),
          controller: amtcontrol,
          keyboardType: TextInputType.numberWithOptions(),
          onSubmitted: (_) => submitdata()),
      Row(children: <Widget>[
        Icon(
          Icons.date_range,
          color: Colors.teal,
        ),
        SizedBox(width: 15),
        (selecteddate == null
            ? Text('NOT CHOOSEN')
            : Text(DateFormat.yMMMd().format(selecteddate))),
        FlatButton(
            onPressed: () => showdatepicker(),
            textColor: Theme.of(context).primaryColor,
            child: Text('CHOOSE DATE'))
      ]),
     Row(children: <Widget>[
        Icon(Icons.label, color: (savings) ? Colors.teal : Color(0xff23b6e6)),
        Container(
            child: FlatButton(
                onPressed: () => setState(() => savings = !savings),
                child: (savings)
                    ? Text(
                        'Add Money',
                        style: TextStyle(color: Colors.teal,fontSize: 18),
                      )
                    : Text('Expense',
                        style: TextStyle(color: Color(0xff23b6e6),fontSize: 18))))
      ]),
    ]);
  }
}
