import 'package:dashboard_functionality_tester/model/bubblePointModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import '../graphs/componants/open_my_pdf.dart';
import '../pdfs/create_sample_pdf.dart';

class GraphViewPage extends StatefulWidget {
  BubblePointModel bubblePointModel;
  //GraphViewPage({Key? key});
  GraphViewPage({required this.bubblePointModel});

  @override
  _GraphViewPageState createState() => _GraphViewPageState();
}

class _GraphViewPageState extends State<GraphViewPage> {

  Future? getFutureData;
  List<FlSpot> flSpotList = [];
  ScreenshotController screenshotController = ScreenshotController();

  Future<void> getFlSpots() async {
    for(int i=0;i<widget.bubblePointModel.ans.length;i++){
      flSpotList.add(FlSpot(widget.bubblePointModel.t[i],widget.bubblePointModel.ans[i]));
    }
  }

  @override
  void initState() {
    super.initState();
    getFutureData = getFlSpots();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFutureData,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Results",style: TextStyle(color: Colors.black)),
              automaticallyImplyLeading: true,
              elevation: 2,
              leading: Icon(Icons.arrow_back,color: Colors.black),
              backgroundColor: Colors.white,
              actions: [
                Tooltip(
                    message: "Generate PDF",
                    child: InkWell(
                        onTap: ()async{
                          final graphImage=await screenshotController.capture();
                          final pdf = await CreateSamplePdf().generatePdf(text: "My Pdf",graphImage: graphImage!);
                          OpenMyPdf.openFile(pdf!);
                        },
                        child: Icon(Icons.description,color: Colors.black.withOpacity(.8),size: 30))),
                SizedBox(width: 30,)

              ],
            ),
            body: Screenshot(
              controller: screenshotController,
              child: Container(
                 margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Text("F/PT vs Time",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25)),
                    Expanded(child: Padding(
                      padding:  EdgeInsets.symmetric(vertical: 30.0,horizontal: 10  ),
                      child: getGraph(),
                    )),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          );
        }else{
          return CircularProgressIndicator();
        }
        },
    );
  }

  Widget getGraph(){
    return LineChart(
      LineChartData(
        borderData: FlBorderData(
          show: true,
        ),
        axisTitleData: FlAxisTitleData(
          leftTitle: AxisTitle(
            showTitle: true,
            titleText: "F/PT",
            textStyle: TextStyle(
              fontSize: 30,
              color: Colors.black
            )
          ),
          bottomTitle: AxisTitle(
            showTitle: true,
          titleText: "Time (seconds)",
              textStyle: TextStyle(
                  fontSize: 30,
                  color: Colors.black
              )
        )
        ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
            //textAlign: TextAlign.start,
            showTitles: true,
                textAlign: TextAlign.center,
                getTextStyles:(contex,val){
                  return TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold
                  );

                }


            ),
          leftTitles: SideTitles(
            reservedSize: 30,
            textAlign: TextAlign.center,
            getTextStyles:(contex,val){
              return TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold
              );

            } ,
            showTitles: true,
          ),
          rightTitles: SideTitles(
            showTitles: false,
          ),
          topTitles: SideTitles(
            showTitles: false,
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: flSpotList,
            colors: [Colors.blueAccent]
          ),
        ]
      )

    );
  }

}
