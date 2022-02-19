import 'package:dashboard_functionality_tester/graphs/componants/create_pdf.dart';
import 'package:dashboard_functionality_tester/graphs/componants/open_my_pdf.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';


class GraphView extends StatefulWidget {


  const GraphView({Key? key}) : super(key: key);

  @override
  _GraphViewState createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphView> {
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text("Graphs"),
        actions: [
          InkWell(
              onTap: ()async{
                final image=await screenshotController.capture();
                final pdf= await CreateImagePdf().generatePdf(image!);
                OpenMyPdf.openFile(pdf!);
              },
              child: Icon(Icons.print,color: Colors.white,)),
          Container(width: 80,)
        ],
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Container(
          height: 300,
          width: 500,
          color: Colors.teal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Hello there",style: TextStyle(fontSize: 30,color: Colors.white),),
              Text("It's Viren",style: TextStyle(fontSize: 30,color: Colors.white),),
              Text("testing screenshot pdf",style: TextStyle(fontSize: 30,color: Colors.white),),
            ],
          ),

        ),
      )

     /* Container(
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
      ),*/
    );
  }
}
