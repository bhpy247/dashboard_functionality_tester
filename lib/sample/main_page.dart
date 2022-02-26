import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:dashboard_functionality_tester/sample/common_dropdown.dart';
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
  List<String> dropdownList = [];
  String? dropdownValue;
  int i = 0;

  List<String> portList = [];
  late SerialPort port;
  late SerialPortReader reader;
  String displayData = "";

  Socket? socket;

  @override
  void initState() {
    initPorts();
    super.initState();
   // dropdownList = [];
  }

  void initPorts() {
    portList = SerialPort.availablePorts;
   // print("obje   $portList");


    //print(port.isOpen);
  }

  void setPort() {
    print("set port");
    if (port.isOpen) {
      print("port is open");
    } else {
      print("port is close");
    }

    port.config.baudRate = 115200;
    port.config.bits=8;
    port.config.stopBits=1;
    port.config.parity=0;

    port.openRead();

    print(port.isOpen);
    print(port.isOpen);
  }

  void startReading()  {
    reader = SerialPortReader(port,timeout: 5000);

    /*reader.stream.forEach((element) {
      print('received: ${String.fromCharCodes(element)}');
    }).asStream();*/

    reader.stream.listen(
    (data) {
      print('received: $data');
      print('received: ${String.fromCharCodes(data)}');
      // displayData += data.toString();
      //print('received: $data');
    },
    onDone: (){print("on done");}
    ).onError((e){
      print("on Error $e");
    });

    print("start reading");
  }

  void sendData() {
    try {
      String data = "\n\rCOP11CE\n";

      List<int> sendData = [];

      //   sendData.add(int.parse('\n'));
      // sendData.add(int.parse('\r'));

      for (int i = 0; i < data.length; i++) {
        //  sendData.add(int.parse(data[i]));
      }
      //  sendData.add(int.parse('C'));
      //  sendData.add(int.parse('E'));
      // sendData.add(int.parse('\n'));

      sendData = data.codeUnits;
      port.write(Uint8List.fromList(sendData));
      print("Send done $sendData");
    } catch (e) {
      print("Error  : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    port = SerialPort("COM6");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sample Desktop",
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          getDropdowRow(),
          const SizedBox(
            height: 40,
          ),
          Expanded(child: getListColumn())
        ],
      ),
    );
  }

  Widget getDropdowRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 500,
          child: CommonDropDown(
            list: portList,
            dropdownValue: dropdownValue,
            onChanged: (value) {
              dropdownValue = value;

              setState(() {});
            },
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        MaterialButton(
          color: Colors.deepPurple,
          onPressed: () {
            i += 1;
            dropdownList.add("Item $i");
            dropdownValue = dropdownList[0];
            setState(() {});
          },
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
              child: const Text(
                "Refresh",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              )),
        )
      ],
    );
  }

  Widget getListColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MaterialButton(
          color: Colors.deepPurple,
          onPressed: () async {
            //setPort();

            socket = await Socket.connect("localhost", 6667);
            Uint8List data = await socket!.first;
            print("Data:${data}");
            String stringData = utf8.decode(data);
            print("Data String:${stringData}");
          },
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
              child: const Text(
                "Set Port",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              )),
        ),
        MaterialButton(
          color: Colors.deepPurple,
          onPressed: () async {
            //startReading();
            if(socket != null) {
              print("In Socket Write");
              //socket!.write(utf8.encode("In Socker Write"));
              socket!.write("Dishant\n");
              //socket!.write(utf8.encode("Dishant"));

              await Future.delayed(Duration(seconds: 2));

              socket!.write("Agrawal\n");
              print("In Socket Write Completed");
            }
          },
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
              child: const Text(
                "start reading",
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
              child: const Text(
                "Send Data",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              )),
        ),
        MaterialButton(
          color: Colors.deepPurple,
          onPressed: () {

            port.config.dtr=1;
            //port.refreshConfig();

            print("off");
            Future.delayed(const Duration(seconds: 3),(){
              port.config.dtr=0;
              print("on");
             // port.refreshConfig();
            });

          },
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
              child: const Text(
                "Restart port",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              )),
        ),
        MaterialButton(
          color: Colors.deepPurple,
          onPressed: () {
            reader.close();
            print("stream close");
            SerialPortReader reader1 = SerialPortReader(port);
            reader1.stream.listen(
                    (data) {
                  print('received: $data');
                  print('received: ${String.fromCharCodes(data)}');
                  // displayData += data.toString();
                  //print('received: $data');
                },
                onDone: (){print("on done");}
            ).onData((data) {
              print("onData from close stream ${String.fromCharCodes(data)}");
            });

          },
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
              child: const Text(
                "Restart sream",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              )),
        ),

        // SizedBox(
        //   height: 10,
        // ),
        // Flexible(
        //   child: Container(
        //     margin: EdgeInsets.symmetric(horizontal: 300),
        //     padding: EdgeInsets.symmetric(vertical: 20),
        //     decoration: BoxDecoration(
        //         color: Colors.white, border: Border.all(color: Colors.black)),
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Flexible(
        //           child: ListView.builder(
        //               shrinkWrap: true,
        //               itemCount: 12,
        //               itemBuilder: (context, index) {
        //                 return getList("$index");
        //               }),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget getList(String item) {
    return Text(
      "List Item $item",
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
    );
  }
}
