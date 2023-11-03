import 'dart:typed_data';

import 'package:dashboard_functionality_tester/command_files/my_command.dart';
import 'package:flutter/material.dart';
import 'package:serial_port_win32/serial_port_win32.dart';

import 'command_files/writing_format.dart';

class NewPackage2 extends StatefulWidget {
  const NewPackage2({Key? key}) : super(key: key);

  @override
  State<NewPackage2> createState() => _NewPackage2State();
}

class _NewPackage2State extends State<NewPackage2> {
  late SerialPort port;

  String outData = "";
  String currentCommand = "";
  DateTime lastCommandTime = DateTime.now();

  void setDelay(int miliseconds, int delay) async {
    Uint8List command;
    List<int> list = "FML".codeUnits;
    List<int> bytes = [
      ...list,
      ...getBitFromInt(miliseconds),
    ];
    command = WritingFormat.writeUint8Format(Uint8List.fromList(bytes));
    sendUint8Data(command, delay);
  }

  void sendUint8Data(Uint8List w, int slp) {
    port.writeBytesFromUint8List(w);
  }

  static List<int> getBitFromInt(int val) {
    String st = val.toRadixString(16);
    String pad = "000000";

    String st1 = (pad + st).substring(st.length);

    print("st : $st1");
    List<int> list = [];

    list.add(int.parse(st1.substring(0, 2), radix: 16));
    list.add(int.parse(st1.substring(2, 4), radix: 16));
    list.add(int.parse(st1.substring(4, 6), radix: 16));

    return list;
  }

  int getIntFromBit(int a1, int a2, int a3) {
    int a = 0;
    a = a1 << 16;
    a2 = a2 << 8;
    a = a | a2;
    a = a | a3;

    return a;
  }



  void setPort() async {
    port = SerialPort(
      "COM7",
      openNow: false,
      ByteSize: 1,
      ReadIntervalTimeout: 1,
      ReadTotalTimeoutConstant: 1,
    );

    if (port.isOpened) {
      port.close();
    }
    port.openWithSettings(
      BaudRate: 9600,
    );

    port.setFlowControlSignal(SerialPort.SETDTR);
    await Future.delayed(const Duration(seconds: 1));
    port.setFlowControlSignal(SerialPort.CLRDTR);

    port.readBytesOnListen(
      64,
      (Uint8List value) {
        // print("readBytesOnListen called at ${DateTime.now().toIso8601String()}");

        print("Reading:\n$value");
        String newString = String.fromCharCodes(value);
        print("newString:\n'$newString'");

        currentCommand += newString;
        print("currentCommand.codeUnits:\n${currentCommand.codeUnits}");
        print("currentCommand:\n'$currentCommand'");

        calculateCommandV2(currentReadings: value).forEach((List<int> adcList) {
          print("ADC List:$adcList at ${DateTime.now().difference(lastCommandTime).inMilliseconds} Milliseconds");
          lastCommandTime = DateTime.now();
        });
      },
      dataPollingInterval: const Duration(milliseconds: 1),
    );
  }

  void showResult(Uint8List value) {
    outData += String.fromCharCodes(value);
    if (outData.contains("\n")) {
      //print("outData: $outData");
      int index = outData.indexOf('\n');
      //print("index: $index");
      String result = outData.substring(0, index);
      if (result.contains("FMA")) {
        List<int> list = result.codeUnits;
        Uint8List bytes = Uint8List.fromList(list);
        // print(" in fma : ${result.length}");
        list = MyCommands().getAdcData(bytes);
        print("ADC List:$list");
      }
      outData = outData.substring(index + 1, outData.length);
      // print("val: $result");
    }
  }

  Iterable<List<int>> calculateCommand({required Uint8List currentReadings}) sync* {
    String start = "\n\r";
    String end = "E\n";

    int startIndex = currentCommand.indexOf(start);
    int endIndex = currentCommand.indexOf(end);

    while(startIndex > -1 || endIndex > -1) {
      if(startIndex > -1 && endIndex > -1) {
        if(endIndex <= startIndex) {
          currentCommand = currentCommand.substring(endIndex + end.length);
        }
        else {
          String mainCommand = currentCommand.substring(startIndex + start.length, endIndex);
          print("main command:\n'$mainCommand'");

          if (mainCommand.contains("FMA")) {
            List<int> list = "\r$mainCommand".codeUnits;
            Uint8List bytes = Uint8List.fromList(list);
            // print(" in fma : ${result.length}");
            list = MyCommands().getAdcData(bytes);
            yield list;
          }

          currentCommand = currentCommand.substring(endIndex + end.length);
        }
      }
      else if(startIndex > -1) {
        break;
      }
      else if(endIndex > -1) {
        currentCommand = currentCommand.substring(endIndex + end.length);
      }

      startIndex = currentCommand.indexOf(start);
      endIndex = currentCommand.indexOf(end);
    }





    /*if (currentCommand.contains(start) && currentCommand.contains(end)) {
      int startIndex = currentCommand.indexOf(start);
      int endIndex = currentCommand.indexOf(end, startIndex + start.length);

      // String command = start + currentCommand.substring(startIndex + start.length, endIndex) + end;

      String mainCommand = currentCommand.substring(startIndex + start.length, endIndex);
      print("main command:\n'$mainCommand'");

      if (mainCommand.contains("FMA")) {
        List<int> list = "\r$mainCommand".codeUnits;
        Uint8List bytes = Uint8List.fromList(list);
        // print(" in fma : ${result.length}");
        list = MyCommands().getAdcData(bytes);
        print("ADC List:$list at ${DateTime.now().difference(lastCommandTime).inMilliseconds} Milliseconds");

        lastCommandTime = DateTime.now();
      }

      currentCommand = currentCommand.substring(endIndex + end.length);
    }*/
  }

  Iterable<List<int>> calculateCommandV2({required Uint8List currentReadings}) sync* {
    String start = "\n\rFMA";

    int startIndex = currentCommand.indexOf(start);

    while(startIndex > -1) {
      if(currentCommand.length >= (startIndex + start.length + 45)) {
        String commandForADCBits = currentCommand.substring(startIndex + 1);
        List<int> list = commandForADCBits.codeUnits;
        Uint8List bytes = Uint8List.fromList(list);
        List<int> adcData = MyCommands().getAdcData(bytes);
        yield adcData;

        currentCommand = currentCommand.substring(startIndex + start.length + 45);
      }
      else {
        break;
      }

      startIndex = currentCommand.indexOf(start);
    }
  }

  void sendData() async {
    //String data="\n\rFMS--CE\n";
    setDelay(600, 0);
    await Future.delayed(const Duration(seconds: 2));
    String data = "\n\rFMAE111110000000000CE\n";
    port.writeBytesFromString(data);
    await Future.delayed(const Duration(seconds: 2));
    data = "\n\rFMS--CE\n";
    port.writeBytesFromString(data);
    await Future.delayed(const Duration(seconds: 2));

    // print("Setting Valve Latching");
    // bool isValveLatchingSuccess = port.writeBytesFromString("\n\rLV00000000000000CE\n");
    // print("Setted Valve Latching:$isValveLatchingSuccess");
  }

  Future<void> refresh() async {
    String data = "\n\rFMX--CE\n";
    port.writeBytesFromString(data);

    await Future.delayed(const Duration(seconds: 5));

    port.readBytesOnListen(64, (value) => null);
    port.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sample Desktop 2",
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
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
            print("Ports:${SerialPort.getAvailablePorts()}");
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
            child: const Text(
              "Get Port",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
        ),
        MaterialButton(
          color: Colors.deepPurple,
          onPressed: () {
            setPort();
          },
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
              child: const Text(
                "Set Port",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
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
                "start data",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
              )),
        ),
        MaterialButton(
          color: Colors.deepPurple,
          onPressed: () {
            refresh();
          },
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
              child: const Text(
                "Reset",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
              )),
        ),
      ],
    );
  }
}
