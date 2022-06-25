import 'package:dashboard_functionality_tester/connection/connection_screen.dart';
import 'package:dashboard_functionality_tester/graphs/screens/graph_view.dart';
import 'package:dashboard_functionality_tester/pdfs/create_sample_pdf.dart';
import 'package:dashboard_functionality_tester/sample_graph/graph_view_page.dart';
import 'package:flutter/material.dart';

import '../graphs/componants/open_my_pdf.dart';
import '../model/bubblePointModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BubblePointModel  bubblePointModel = BubblePointModel(
      ans: [
        578.5234966216216,3763.581428571427,-4506.393552631579,4969.262608695657,-5708.098500000003,7278.568085106381
      ],
      t: [
        6.0,7.0,7.0,8.0,8.0,9.0
      ]
  );
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      //Colors.grey[850]
      appBar: AppBar(title: Text("Home"),),
      body: Center(
        child: commonButton(text: "Generate PDF",
            onTap: ()async{

              Navigator.push(context, MaterialPageRoute(builder: (context){
                return GraphViewPage(
                  bubblePointModel: bubblePointModel,

                );
              }));
            }
        ),
      ),
    );
  }

 /* Widget mainBody(context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          commonButton(onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){return GraphView();}));
          },text: "Graph Test",),
          commonButton(onTap: (){},text: "Manual Control"),
          commonButton(onTap: (){},text: "Settings"),
          commonButton(onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){return mainPage();}));
          },text: "Live Test"),
        ],
      ),
    );
  }*/
  Widget commonButton({Function()? onTap, String text = ""}){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
          BoxShadow(
              color:  Colors.black54,
              offset: Offset(4.0, 4.0),
              blurRadius: 20.0,
              spreadRadius: 1.0),
          BoxShadow(
              color:  Colors.grey[800]!,
              offset: Offset(-4.0, -4.0),
              blurRadius: 15.0,
              spreadRadius: 0.5),
        ]
      ),

      child: MaterialButton(
        padding: EdgeInsets.all(30),
      // height: 50,
      //   minWidth: 50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onTap,
        color: Colors.grey[850],
        child: Text(text, style: TextStyle(fontSize: 20,color: Colors.white),),
      ),
    );
  }
}
