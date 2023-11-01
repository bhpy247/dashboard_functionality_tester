import 'package:dashboard_functionality_tester/command_files/my_command.dart';
import 'package:flutter/material.dart';
import 'package:serial_port_win32/serial_port_win32.dart';

import 'dart:typed_data';

class NewPackage extends StatefulWidget {
  const NewPackage({Key? key}) : super(key: key);

  @override
  State<NewPackage> createState() => _NewPackageState();
}

class _NewPackageState extends State<NewPackage> {

  late SerialPort port;

  String outData="";

  void showResult(Uint8List value){

    outData += String.fromCharCodes(value);
    if(outData.contains("\n"))
    {
      //print("outData: $outData");
      int index = outData.indexOf('\n');
      //print("index: $index");
      String result = outData.substring(0,index);
      if(result.contains("FMA")){
        List<int> list = result.codeUnits;
        Uint8List bytes=Uint8List.fromList(list);
        print(" in fma : ${result.length}");
        list = MyCommands().getAdcData(bytes);
        print("ADC List:$list");
      }
      outData = outData.substring(index+1,outData.length);
      print("val: $result");
    }

  }

  int getIntFromBit(int a1,int a2,int a3){
    int a=0;
    a=a1<<16;
    a2=a2<<8;
    a=a|a2;
    a=a|a3;

    return a;

  }


  void setPort()async{
    port = SerialPort("COM5", openNow: false, ByteSize: 8, ReadIntervalTimeout: 10, ReadTotalTimeoutConstant: 100);
//port.open()

    if(port.isOpened)
      {

        port.close();
      }
    port.openWithSettings(BaudRate: 9600,);

    port.setFlowControlSignal(SerialPort.SETDTR);

    await Future.delayed(Duration(seconds: 1));
    port.setFlowControlSignal(SerialPort.CLRDTR);

    port.readBytesOnListen(16, (value)
    {
      showResult(value);

    });
/*    port.readOnListenFunction = (value) {

      if(String.fromCharCodes(value)=="\n")
        {
          print("val : ${data}");
          data="";
        }
      else
        {
          data=data+String.fromCharCodes(value);
        }

      print(String.fromCharCodes(value));

    };*/
  }

  void sendData() async{
    //String data="\n\rFMS--CE\n";
    String data="\n\rFMAE111110000000000CE\n";
    port.writeBytesFromString(data);
    await Future.delayed(Duration(seconds: 2));
    data="\n\rFMS--CE\n";
    port.writeBytesFromString(data);
    await Future.delayed(Duration(seconds: 2));

    print("Setting Valve Latching");
    bool isValveLatchingSuccess = port.writeBytesFromString("\n\rLV00000000000000CE\n");
    print("Setted Valve Latching:$isValveLatchingSuccess");
  }

  void refresh(){
    String data="\n\rFMX--CE\n";
    port.writeBytesFromString(data);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sample Desktop",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: getListColumn(),
      ),
    );
  }

  Widget getListColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        MaterialButton(
          color: Colors.deepPurple,
          onPressed: () {
            setPort();
          },
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 9),
              child: Text(
                "Set Port",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              )),
        ),

        MaterialButton(
          color: Colors.deepPurple,
          onPressed: () {
            sendData();
          },
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 9),
              child: Text(
                "start data",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              )),
        ),

        MaterialButton(
          color: Colors.deepPurple,
          onPressed: () {
            refresh();
          },
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 9),
              child: Text(
                "Reset",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              )),
        ),
      ],
    );
  }
}
