import 'package:dashboard_functionality_tester/connection/common_dropdown.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

class mainPage extends StatefulWidget {

  const mainPage({Key? key}) : super(key: key);
  @override
  _mainPageState createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  List<String> dropdownList=[];
  String? dropdownValue;
  int i=0;
  List<String> portList=[];

  late SerialPort port;
  late SerialPortReader reader;

  void setPort(){

    port=SerialPort("COM11");

    if(port.isOpen){
      print("port is open");
    }else{
      print("port is close");
    }
    port.config.baudRate=115200;
    port.config.bits=8;
    port.config.stopBits=1;
    port.config.parity=0;

    port.openRead();
    print("port open ${port.isOpen}");
  }

  void startReading(){
    reader=SerialPortReader(port);

    reader.stream.listen((event) {
      print("data ${event}");
    });

    print("stream over");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    portList=SerialPort.availablePorts;
    print("portlist $portList");
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            color: Colors.deepPurple,
            onPressed: (){
              setPort();
            },
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 9),
                child: Text("Set Port",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),)),
          ),
          SizedBox(
            width: 10,
          ),
          MaterialButton(
            color: Colors.deepPurple,
            onPressed: (){
              startReading();
            },
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 9),
                child: Text("Start Reading",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),)),
          ),
          SizedBox(
            width: 10,
          ),
          MaterialButton(
            color: Colors.deepPurple,
            onPressed: (){
            },
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 9),
                child: Text("Restart Port",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),)),
          ),
          SizedBox(
            width: 10,
          ),
          /*MaterialButton(
            color: Colors.deepPurple,
            onPressed: (){
            },
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 9),
                child: Text("Button",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),)),
          ),
          SizedBox(
            width: 10,
          ),
          MaterialButton(
            color: Colors.deepPurple,
            onPressed: (){
            },
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 9),
                child: Text("Button",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),)),
          ),*/

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
