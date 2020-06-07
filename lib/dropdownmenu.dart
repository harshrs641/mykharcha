
import 'package:flutter/material.dart';

import './global_var.dart';


class DropMenu extends StatefulWidget {
  @override
  Function updatemain;
  DropMenu(this.updatemain);
  _DropMenuState createState() => _DropMenuState(updatemain);
}

class _DropMenuState extends State<DropMenu> {
  Function updatemain;
  _DropMenuState(this.updatemain);
  Widget build(BuildContext context) {
    return Container(
                width: 100,
                height: 48,
                child: Column(children: <Widget>[
          DropdownButton(style: TextStyle(color:Colors.white,fontSize: 20),
                value: oval,
                onChanged: (String nval) {
                  setState(() {
                    oval = nval;
                    updatemain();
                  });
                },
                items: <String>['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']
                    .map<DropdownMenuItem<String>>((String month) =>
                        DropdownMenuItem<String>(value: month, child:  Text(month, style: TextStyle(color:Colors.teal,fontWeight:FontWeight.bold,))))
                    .toList(),
              ),
          
          
        ]));
  }
}





