import 'dart:io';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
//import 'package:flutter_libserialport/flutter_libserialport.dart';

class mainPage extends StatefulWidget {
  const mainPage({Key? key}) : super(key: key);

  @override
  _mainPageState createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  List<String> dropdownList = [];
  String? dropdownValue;

  int i = 0;

  List<String> portList = [];
  // late SerialPort port;
  // late SerialPortReader reader;
  String displayData = "";

  Socket? socket;

  @override
  void initState() {
    super.initState();
  //  port = SerialPort("COM13");
   // dropdownList = [];
  }

  @override
  void dispose() {
    super.dispose();
  }


  // Future<void> setPort() async {
  //   print("set port");
  //   if (port.isOpen) {
  //     print("port is open");
  //   } else {
  //     print("port is close");
  //   }
  //   port.openReadWrite();
  //
  //   startReading();
  //   print("*********Before config***********");
  //   print("BaudRate:${port.config.baudRate}");
  //   print("Bits:${port.config.bits}");
  //   print("StopBits:${port.config.stopBits}");
  //   print("Parity:${port.config.parity}");
  //   print("DTR:${port.config.dtr}");
  //   port.config.baudRate = 9600;
  //   port.config.bits=8;
  //   port.config.stopBits=1;
  //   port.config.parity=0;
  //   port.config.dtr=1;
  //   print("DTR after set:${port.config.dtr}");
  //   await Future.delayed(Duration(seconds: 2));
  //   port.config.dtr=0;
  //   print("*********After config***********");
  //   print("BaudRate:${port.config.baudRate}");
  //   print("Bits:${port.config.bits}");
  //   print("StopBits:${port.config.stopBits}");
  //   print("Parity:${port.config.parity}");
  //   print("DTR:${port.config.dtr}");
  //   print(port.isOpen);
  // }
  //
  // Future<void> refresh() async {
  //   print("refresh");
  //   print("*********Before config***********");
  //   print("BaudRate:${port.config.baudRate}");
  //   print("Bits:${port.config.bits}");
  //   print("StopBits:${port.config.stopBits}");
  //   print("Parity:${port.config.parity}");
  //   print("DTR:${port.config.dtr}");
  //   port.config.dtr=0;
  //   print("DTR after set:${port.config.dtr}");
  //   await Future.delayed(Duration(seconds: 2));
  //   port.config.dtr=1;
  //   print("*********After config***********");
  //   print("BaudRate:${port.config.baudRate}");
  //   print("Bits:${port.config.bits}");
  //   print("StopBits:${port.config.stopBits}");
  //   print("Parity:${port.config.parity}");
  //   print("DTR:${port.config.dtr}");
  //   print(port.isOpen);
  // }
  //
  // void startReading()  {
  //   reader = SerialPortReader(port,timeout: -1);
  //   reader.stream.listen(
  //   (data) {
  //     try {
  //       String receivedData="";
  //       print("data $data");
  //     data.forEach((element) {
  //       if (element != 10) {
  //         //print("element $element");
  //         receivedData += String.fromCharCode(element);
  //         //print("final Data in if: $receivedData");
  //       }
  //       else {
  //         print("final Data: $receivedData");
  //         receivedData="";
  //       }
  //     });
  //   }
  //   catch(e)
  //   {
  //     print("error: $e");
  //   }
  //
  //
  //   },
  //   onDone: (){
  //     print("on done");}
  //   ).onError((e){
  //     print("on Error $e");
  //   });
  //
  //   print("start reading");
  // }
  //
  // void closeReading(){
  //   reader.close();
  // }
  // void closePort(){
  //   port.dispose();
  //   port.close();
  // }
  //
  // void sendData(String cmd) async{
  //   try {
  //
  //     String data = "\n\rXX---CE\n";
  //
  //     List<int> sendData = [];
  //
  //     for (int i = 0; i < data.length; i++) {
  //       sendData = data[i].codeUnits;
  //       int b=port.write(Uint8List.fromList(sendData));
  //       print("Send done ${(sendData)}: $b");
  //     }
  //     //  sendData.add(int.parse('C'));
  //     //  sendData.add(int.parse('E'));
  //     // sendData.add(int.parse('\n'));
  //
  //    /*sendData = data.codeUnits;
  //     int b=port.write(Uint8List.fromList(sendData));
  //     print("Send done $sendData: $b");*/
  //   } catch (e) {
  //     print("Error  : $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sample Desktop",
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(child: Container()),
    );
  }
  //
  // Widget getDropdowRow() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       SizedBox(
  //         width: 500,
  //         child: CommonDropDown(
  //           list: portList,
  //           dropdownValue: dropdownValue,
  //           onChanged: (value) {
  //             dropdownValue = value;
  //
  //             setState(() {});
  //           },
  //         ),
  //       ),
  //       const SizedBox(
  //         width: 15,
  //       ),
  //       MaterialButton(
  //         color: Colors.deepPurple,
  //         onPressed: () {
  //           i += 1;
  //           dropdownList.add("Item $i");
  //           dropdownValue = dropdownList[0];
  //           setState(() {});
  //         },
  //         child: Container(
  //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
  //             child: const Text(
  //               "Refresh",
  //               style: TextStyle(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 17),
  //             )),
  //       )
  //     ],
  //   );
  // }
  //
  // Widget getListColumn() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       MaterialButton(
  //         color: Colors.deepPurple,
  //         onPressed: () async {
  //           setPort();
  //           /*socket = await Socket.connect("localhost", 6667);
  //           Uint8List data = await socket!.first;
  //           print("Data:${data}");
  //           String stringData = utf8.decode(data);
  //           print("Data String:${stringData}");*/
  //         },
  //         child: Container(
  //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
  //             child: const Text(
  //               "Set Port",
  //               style: TextStyle(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 17),
  //             )),
  //       ),
  //       SizedBox(height: 20,),
  //       MaterialButton(
  //         color: Colors.deepPurple,
  //         onPressed: () async {
  //           Uint8List data = port.read(100);
  //           print("Data:${data}");
  //
  //           /*socket = await Socket.connect("localhost", 6667);
  //           Uint8List data = await socket!.first;
  //           print("Data:${data}");
  //           String stringData = utf8.decode(data);
  //           print("Data String:${stringData}");*/
  //         },
  //         child: Container(
  //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
  //             child: const Text(
  //               "Custom",
  //               style: TextStyle(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 17),
  //             )),
  //       ),
  //       SizedBox(height: 20,),
  //       MaterialButton(
  //         color: Colors.deepPurple,
  //         onPressed: () async {
  //           startReading();
  //           /*if(socket != null) {
  //             print("In Socket Write");
  //             //socket!.write(utf8.encode("In Socker Write"));
  //             socket!.write("Dishant\n");
  //             //socket!.write(utf8.encode("Dishant"));
  //
  //             await Future.delayed(Duration(seconds: 2));
  //
  //             socket!.write("Agrawal\n");
  //             print("In Socket Write Completed");
  //           }*/
  //         },
  //         child: Container(
  //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
  //             child: const Text(
  //               "start reading",
  //               style: TextStyle(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 17),
  //             )),
  //       ),
  //       SizedBox(height: 20,),
  //       MaterialButton(
  //         color: Colors.deepPurple,
  //         onPressed: () {
  //           //sendData("FMAE111110000000000");
  //           //sendData("FMS--");
  //           sendData("XX---");
  //
  //         },
  //         child: Container(
  //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
  //             child: const Text(
  //               "Send Data",
  //               style: TextStyle(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 17),
  //             )),
  //       ),
  //       SizedBox(height: 20,),
  //       MaterialButton(
  //         color: Colors.deepPurple,
  //         onPressed: () async{
  //           port.config.dtr=1;
  //           print("off");
  //           await Future.delayed(Duration(seconds: 2));
  //           port.config.dtr=0;
  //           print("on");
  //           print("*********After DTR config***********");
  //           print("BaudRate:${port.config.baudRate}");
  //           print("Bits:${port.config.bits}");
  //           print("StopBits:${port.config.stopBits}");
  //           print("Parity:${port.config.parity}");
  //           print("DTR:${port.config.dtr}");
  //           print(port.isOpen);
  //
  //         },
  //         child: Container(
  //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
  //             child: const Text(
  //               "Restart DTR",
  //               style: const TextStyle(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 17),
  //             )),
  //       ),
  //       SizedBox(height: 20,),
  //       MaterialButton(
  //         color: Colors.deepPurple,
  //         onPressed: () {
  //           reader.close();
  //           print("stream close");
  //           SerialPortReader reader1 = SerialPortReader(port);
  //           reader1.stream.listen(
  //                   (data) {
  //                 print('received: $data');
  //                 print('received: ${String.fromCharCodes(data)}');
  //                 // displayData += data.toString();
  //                 //print('received: $data');
  //               },
  //               onDone: (){print("on done");}
  //           ).onData((data) {
  //             print("onData from close stream ${String.fromCharCodes(data)}");
  //           });
  //
  //         },
  //         child: Container(
  //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
  //             child: const Text(
  //               "Restart sream",
  //               style: TextStyle(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 17),
  //             )),
  //       ),
  //       SizedBox(height: 20,),
  //       MaterialButton(
  //         color: Colors.deepPurple,
  //         onPressed: () {
  //           closeReading();
  //         },
  //         child: Container(
  //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
  //             child: const Text(
  //               "Close read",
  //               style: TextStyle(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 17),
  //             )),
  //       ),
  //       SizedBox(height: 20,),
  //       MaterialButton(
  //         color: Colors.deepPurple,
  //         onPressed: () {
  //           refresh();
  //         },
  //         child: Container(
  //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
  //             child: const Text(
  //               "Refresh",
  //               style: TextStyle(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 17),
  //             )),
  //       ),
  //       SizedBox(height: 20,),
  //       MaterialButton(
  //         color: Colors.deepPurple,
  //         onPressed: () {
  //           closePort();
  //         },
  //         child: Container(
  //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
  //             child: const Text(
  //               "Close port",
  //               style: TextStyle(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 17),
  //             )),
  //       ),
  //
  //
  //       // SizedBox(
  //       //   height: 10,
  //       // ),
  //       // Flexible(
  //       //   child: Container(
  //       //     margin: EdgeInsets.symmetric(horizontal: 300),
  //       //     padding: EdgeInsets.symmetric(vertical: 20),
  //       //     decoration: BoxDecoration(
  //       //         color: Colors.white, border: Border.all(color: Colors.black)),
  //       //     child: Column(
  //       //       mainAxisSize: MainAxisSize.min,
  //       //       crossAxisAlignment: CrossAxisAlignment.center,
  //       //       children: [
  //       //         Flexible(
  //       //           child: ListView.builder(
  //       //               shrinkWrap: true,
  //       //               itemCount: 12,
  //       //               itemBuilder: (context, index) {
  //       //                 return getList("$index");
  //       //               }),
  //       //         ),
  //       //       ],
  //       //     ),
  //       //   ),
  //       // ),
  //     ],
  //   );
  // }
  //
  // Widget getList(String item) {
  //   return Text(
  //     "List Item $item",
  //     textAlign: TextAlign.center,
  //     style: const TextStyle(
  //         fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
  //   );
  // }
}
