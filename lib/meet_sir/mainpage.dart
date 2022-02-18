import 'package:dashboard_functionality_tester/meet_sir/common_dropdown.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class mainPage extends StatefulWidget {

  const mainPage({Key? key}) : super(key: key);
  @override
  _mainPageState createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  List<String> dropdownList=[];
  String? dropdownValue;
  int i=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownList=[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample Desktop", style: TextStyle(fontSize:20,color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          getDropdowRow(),
          SizedBox(
            height: 40,
          ),
          getListColumn()

        ],
      ),
    );
  }

  Widget getDropdowRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 500,
          child: CommonDropDown(
            list: dropdownList,
            dropdownValue: dropdownValue,
            onChanged: (value){
              dropdownValue=value;
              setState(() {
              });
            },
          ),
        ),
        SizedBox(
          width: 15,
        ),
        MaterialButton(
          color: Colors.deepPurple,
          onPressed: (){
            i+=1;
            dropdownList.add("Item $i");
            dropdownValue=dropdownList[0];
            setState(() {});
          },
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 9),
              child: Text("Refresh",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),)),
        )
      ],
    );
  }

  Widget getListColumn(){
    return  Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MaterialButton(
            color: Colors.deepPurple,
            onPressed: (){
            },
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 9),
                child: Text("Button",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),)),
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 300),
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Flexible(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 12,
                        itemBuilder: (context,index){
                          return getList("$index");
                        }
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getList(String item){
    return Text(
      "List Item $item",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black
      ),
    );
  }
}
