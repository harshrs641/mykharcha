import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import './global_var.dart';

class LineChartSample2 extends StatefulWidget {
  LineChartSample2State createState() => LineChartSample2State();
}

class LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  Map<String, int> spotDataList = {};
  // bool showAvg = false;
  Future<DocumentSnapshot> spotData() async{
    var docSnap=await Firestore.instance.collection(user).document(oval + y).get();
    if(docSnap.data!=null){
      spotDataList={};
      spotDataList[0.toString()]=1;
    for (int i = 1; i <= 31; i++) {
      if (docSnap.data[i.toString()] != null && docSnap.data[i.toString()]!=0 )
        spotDataList[i.toString()] = docSnap.data[i.toString()];
    }}
    return docSnap;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: spotData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.data != null) if (snapshot.data.data.length > 2) {
              // spotData(snapshot.data.data);
              return Stack(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 2.0,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      elevation: 25,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: const Color(0xff232d37)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 10.0, left: 2.0, top: 10.0, bottom: 0.1),
                          child: LineChart(
                            (snapshot.data.data['Highest'] == 5000)
                                ? fiveData()
                                : tenData(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else
              return Container();
            else
              return Container();
          } else
            return Container();
        });
  }

  LineChartData fiveData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 15,
          textStyle: TextStyle(
              color: const Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 7),
          getTitles: (value) {
            return value.toStringAsFixed(0);
          },
          margin: 2,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: const Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 10:
                return '1000';

              case 20:
                return '2000';

              case 30:
                return '3000';
              case 40:
                return '4000';
              case 50:
                return '5000';
            }

            return '';
          },
          reservedSize: 30,
          margin: 10,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 31,
      minY: 0,
      maxY: 50,
      lineBarsData: [
        LineChartBarData(
          isCurved: true,
          spots: spotDataList.entries
              // .where((e) =>
              //     e.key != 'TotalAmount' && e.key != 'Highest' && e.value != 0)
              .map((e) => FlSpot(int.parse(e.key).toDouble(), e.value / 100.0))
              .toList(), //converting map to list in one go!!
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData tenData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 15,
          textStyle: TextStyle(
              color: const Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 7),
          getTitles: (value) {
            return value.toStringAsFixed(0);
          },
          margin: 2,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: const Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 10:
                return '2000';

              case 20:
                return '4000';

              case 30:
                return '6000';
              case 40:
                return '8000';
              case 50:
                return '10000';
            }

            return '';
          },
          reservedSize: 30,
          margin: 10,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 31,
      minY: 0,
      maxY: 50,
      lineBarsData: [
        LineChartBarData(
          isCurved: true,
          spots: spotDataList.entries
              // .where((e) => e.key != 'TotalAmount' && e.key != 'Highest')
              .map((e) => FlSpot(int.parse(e.key).toDouble(), e.value / 200.0))
              .toList(), //converting map to list in one go!!
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
