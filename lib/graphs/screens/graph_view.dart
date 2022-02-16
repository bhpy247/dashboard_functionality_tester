import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class GraphView extends StatefulWidget {


  const GraphView({Key? key}) : super(key: key);

  @override
  _GraphViewState createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text("Graphs"),
        actions: [
          InkWell(
              onTap: (){
                
              },
              child: Icon(Icons.print,color: Colors.white,)),
          Container(width: 80,)
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
        child: Column(
          children: [
            Expanded(
              child: LineChart(
                LineChartData(
                    minX:0,
                  maxX: 10,
                  minY: 0,
                  maxY: 18,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 1),
                        FlSpot(1, 3),
                        FlSpot(2, 5),
                        FlSpot(2.5, 8),
                        FlSpot(4, 10),
                        FlSpot(6, 15),
                        FlSpot(8, 0),
                        FlSpot(10, 5),
                      ]
                    )
                  ]
                )
              ),
            )
          ],

        ),
      ),
    );
  }
}
