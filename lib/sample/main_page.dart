// import 'dart:ffi';
// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:dashboard_functionality_tester/sample/common_dropdown.dart';
// import 'package:flutter/cupertino.dart';
// import "package:flutter/material.dart";
// import 'package:flutter/painting.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_libserialport/flutter_libserialport.dart';
//
// class mainPage extends StatefulWidget {
//   const mainPage({Key? key}) : super(key: key);
//
//   @override
//   _mainPageState createState() => _mainPageState();
// }
//
// class _mainPageState extends State<mainPage> {
//   List<String> dropdownList = [];
//   String? dropdownValue;
//   int i = 0;
//
//   List<String> portList = [];
//   late SerialPort port;
//   late SerialPortReader reader;
//   String displayData = "";
//
//   @override
//   void initState() {
//     // initPorts();
//
//     super.initState();
//    // dropdownList = [];
//   }
//
//   void initPorts() {
//     portList = SerialPort.availablePorts;
//     print(portList);
//   }
//
//   void setPort()async {
//     print("set port");
//     port = SerialPort("COM13");
//     print('COM13');
//     print('\tDescription: ${port.description}');
//     print('\tManufacturer: ${port.manufacturer}');
//     print('\tSerial Number: ${port.serialNumber}');
//     print('\tProduct ID: 0x${port.productId!.toRadixString(16)}');
//     print('\tVendor ID: 0x${port.vendorId!.toRadixString(16)}');
//
//     port.open(mode:3);
//
//     port.config.baudRate = 9600;
//     port.config.bits=8;
//     port.config.stopBits=1;
//     port.config.parity=0;
//     port.config.dtr =0;
//     port.config.setFlowControl(0);
//
//     print(port.config.dtr);
//
//     print("refreshing....");
//     port.config.dtr = 1;
//     print(port.config.dtr);
//
//     await Future.delayed(Duration(microseconds: 600));
//     port.config.dtr = 0;
//     print(port.config.dtr);
//     print("done");
//
//     port.close();
//     port.openReadWrite();
//
//
//
//
//   /*  if (!port.openReadWrite()) {
//       print("error ${SerialPort.lastError}");
//       exit(-1);
//     }*/
//
//
//
//
//     reader = SerialPortReader(port);
//    //
//    //  /*reader.stream.forEach((element) {
//    //    print('received: ${String.fromCharCodes(element)}');
//    //  }).asStream();*/
//    //
//     reader.stream.listen(
//             (data) {
//           print('received: $data');
//           print('received: ${String.fromCharCodes(data)}');
//           displayData += data.toString();
//           print('received after: $data');
//         },
//         onDone: (){print("on done");}
//     ).onError((e){
//       print("on Error $e");
//     });
//
//
//     // await Future.delayed(Duration(seconds: 4));
//     // print("refreshing....");
//     //  port.config.dtr = 1;
//     // await Future.delayed(Duration(microseconds: 600));
//     // port.config.dtr =0;
//     // print("done");
//
//
//
//
//   }
//
//   void startReading()  {
//     reader = SerialPortReader(port,timeout: 5000);
//
// /*
//     reader.stream.forEach((element) {
//       print('received: ${String.fromCharCodes(element)}');
//     }).asStream();
// */
//
//     print("start reading");
//
//     reader.stream.listen(
//     (data) {
//       print('received: $data');
//       print('received: ${String.fromCharCodes(data)}');
//       // displayData += data.toString();
//       //print('received: $data');
//     },
//     onDone: (){print("on done");}
//     ).onError((e){
//       print("on Error $e");
//     });
//
//   }
//
//  /* void sendData() {
//     try {
//       String data = "\n\rCOP11CE\n";
//
//       List<int> sendData = [];
//
//       //   sendData.add(int.parse('\n'));
//       // sendData.add(int.parse('\r'));
//
//       for (int i = 0; i < data.length; i++) {
//         //  sendData.add(int.parse(data[i]));
//       }
//       //  sendData.add(int.parse('C'));
//       //  sendData.add(int.parse('E'));
//       // sendData.add(int.parse('\n'));
//
//       sendData = data.codeUnits;
//       port.write(Uint8List.fromList(sendData));
//       print("Send done $sendData");
//     } catch (e) {
//       print("Error  : $e");
//     }
//   }*/
//
//   void sendData() async{
//     print("send data");
//
//
//     String data="\n\rFMS--CE\n";
//     //String data="\n\rXX---CE\n";
//      List<int> list = data.codeUnits;
//      Uint8List bytes=Uint8List.fromList(list);
//
//     port.write(bytes);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Sample Desktop",
//           style: TextStyle(
//               fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: 40,
//             ),
//             //getDropdowRow(),
//             SizedBox(
//               height: 40,
//             ),
//             getListColumn(),
//             SizedBox(
//               height: 40,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget getDropdowRow() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SizedBox(
//           width: 500,
//           child: CommonDropDown(
//             list: portList,
//             dropdownValue: dropdownValue,
//             onChanged: (value) {
//               dropdownValue = value;
//
//               setState(() {});
//             },
//           ),
//         ),
//         SizedBox(
//           width: 15,
//         ),
//         MaterialButton(
//           color: Colors.deepPurple,
//           onPressed: () {
//             i += 1;
//             dropdownList.add("Item $i");
//             dropdownValue = dropdownList[0];
//             setState(() {});
//           },
//           child: Container(
//               padding: EdgeInsets.symmetric(vertical: 10, horizontal: 9),
//               child: Text(
//                 "Refresh",
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 17),
//               )),
//         )
//       ],
//     );
//   }
//
//   Widget getListColumn() {
//     return Flexible(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           MaterialButton(
//             color: Colors.deepPurple,
//             onPressed: () {
//               setPort();
//             },
//             child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 9),
//                 child: Text(
//                   "Set Port",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 17),
//                 )),
//           ),
//           MaterialButton(
//             color: Colors.deepPurple,
//             onPressed: () {
//               startReading();
//             },
//             child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 9),
//                 child: Text(
//                   "start reading",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 17),
//                 )),
//           ),
//           MaterialButton(
//             color: Colors.deepPurple,
//             onPressed: () {
//               sendData();
//             },
//             child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 9),
//                 child: Text(
//                   "Send Data",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 17),
//                 )),
//           ),
//           MaterialButton(
//             color: Colors.deepPurple,
//             onPressed: () {
//
//               port.config.dtr=1;
//               //port.refreshConfig();
//
//               print("off");
//               Future.delayed(Duration(seconds: 3),(){
//                 port.config.dtr=0;
//                 print("on");
//                // port.refreshConfig();
//               });
//
//             },
//             child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 9),
//                 child: Text(
//                   "Restart port",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 17),
//                 )),
//           ),
//           MaterialButton(
//             color: Colors.deepPurple,
//             onPressed: () {
//               reader.close();
//               print("stream close");
//               SerialPortReader reader1 = SerialPortReader(port);
//               reader1.stream.listen(
//                       (data) {
//                     print('received: $data');
//                     print('received: ${String.fromCharCodes(data)}');
//                     // displayData += data.toString();
//                     //print('received: $data');
//                   },
//                   onDone: (){print("on done");}
//               ).onData((data) {
//                 print("onData from close stream ${String.fromCharCodes(data)}");
//               });
//
//             },
//             child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 9),
//                 child: Text(
//                   "Restart sream",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 17),
//                 )),
//           ),
//           MaterialButton(
//             color: Colors.deepPurple,
//             onPressed: () {
//               port.dispose();
//               port.close();
//
//             },
//             child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 9),
//                 child: Text(
//                   "Dispose",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 17),
//                 )),
//           ),
//
//            // SizedBox(
//           //   height: 10,
//           // ),
//           // Flexible(
//           //   child: Container(
//           //     margin: EdgeInsets.symmetric(horizontal: 300),
//           //     padding: EdgeInsets.symmetric(vertical: 20),
//           //     decoration: BoxDecoration(
//           //         color: Colors.white, border: Border.all(color: Colors.black)),
//           //     child: Column(
//           //       mainAxisSize: MainAxisSize.min,
//           //       crossAxisAlignment: CrossAxisAlignment.center,
//           //       children: [
//           //         Flexible(
//           //           child: ListView.builder(
//           //               shrinkWrap: true,
//           //               itemCount: 12,
//           //               itemBuilder: (context, index) {
//           //                 return getList("$index");
//           //               }),
//           //         ),
//           //       ],
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
//
//   Widget getList(String item) {
//     return Text(
//       "List Item $item",
//       textAlign: TextAlign.center,
//       style: TextStyle(
//           fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
//     );
//   }
// }
