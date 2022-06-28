import 'package:dashboard_functionality_tester/model/bubblePointModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
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
            body: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Screenshot(
                    controller: screenshotController,
                    child: Container(
                       margin: EdgeInsets.symmetric(horizontal: 10).copyWith(left: 10),
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
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  child: VerticalDivider(color: Colors.grey,thickness: 1,),
                ),
                Expanded(
                    child: getGraphInfoBody()
                )
              ],
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

  Widget getGraphInfoBody(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                getBlueDivider(),
                Row(
                  children: [
                    Expanded(flex: 3,child: Text("Sample Name")),
                    Expanded(child: Text("Bubble Pressure")),
                    Expanded(child: Text("Bubble Diameter")),
                  ],
                ),
                getBlueDivider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                      itemBuilder: (context,index){
                        return getFilesList(bdiameter: "newFile",bpressure: "2.45",fileName: "178.25");

                      }
                  ),
                )




              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                getBlueDivider(),
                Row(
                  children: [
                    Expanded(flex: 2,child: Text("Average Bubble Diameter")),
                    Text("178.25 (mn)"),
                  ],
                ),
                getBlueDivider(),
                SizedBox(height: 20,),
                getCircularDiameterView(),

                


              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getBlueDivider(){
    return Divider(color: Colors.blueAccent,thickness: 1,);
  }

  Widget getFilesList({String fileName="",String bpressure="",String bdiameter="",}){
    return Row(
      children: [
        Expanded(flex: 3,child: Text(fileName)),
        Expanded(child: Text(bpressure)),
        Expanded(child: Text(bdiameter)),
      ],
    );
  }

  Widget getCircularDiameterView(){
    return Column(
      children: [
        Text("Bubble Point Diameter"),
        Text("( Macro Pore )"),
        SizedBox(height: 15,),
        Stack(
          children: [
            Container(
              height: 120,
              width: 120,
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                gradient:LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black12,
                    Colors.black12,
                    Colors.black54,
                    Colors.black54,
                    Colors.black54,
                    Colors.black54,
                    Colors.black54,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                  ]
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100)
                ),
                child: SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                    infoProperties:InfoProperties(
                      modifier: (val){
                        return "";
                      }

                    ),
                    customWidths: CustomSliderWidths(
                      shadowWidth: 0,
                      trackWidth: 22,
                      handlerSize: 0,
                      progressBarWidth: 22
                    ),
                    customColors: CustomSliderColors(
                        trackColor: Colors.grey,
                      progressBarColor: Colors.grey.shade800
                    ),
                  ),
                  initialValue: 30,
                  onChange: (double value){
                    print(value);
                  },

                )


              ),
            ),
            Positioned(
              left: 0,
                right: 0,
                top: 35,
                child: Column(
                  children: [
                    Text("BP Diameter",style: TextStyle(fontSize: 7,fontWeight: FontWeight.bold),),
                    Text("178.8",style: TextStyle(fontSize: 23),),
                    Text("mm",style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold),),
                  ],
                )
            ),
          ],
        ),


      ],
    );
  }





}
