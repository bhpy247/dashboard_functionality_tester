import 'dart:convert';
import 'dart:io';

import 'package:dashboard_functionality_tester/screens/Mycommand.dart';

import 'Constant.dart';

class Connection {
  void connect(String ip, int port, String com) async {
    try {
      Constants.socket = await Socket.connect(ip, port);
      MyCommand.connect(com);
    } catch (e) {
      print("Can't connect : $e");
    }
  }

  void startReading() {
    try {
      if (Constants.socket == null) return;

      Constants.socket!.listen((data) {
        print("Data String:${data}");

        String stringData = utf8.decode(data);
        print("Data String:${stringData}");

        if (stringData.contains("data:")) {
          Map val = json.decode(stringData.replaceAll("data:", ""));
          print("Val  : ${val}");
        }
        else{
          print("machine:${stringData}");
        }
      });
    } catch (e) {
      print("Can't reading : $e");
    }
  }

  void disConnect() {
    try {
      if (Constants.socket != null) {
        Constants.socket!.destroy();
        Constants.socket!.close();
      }
    } catch (e) {
      print("Can't disconnect : $e");
    }
  }

  void sendData(String msg){
    try {
      if (Constants.socket != null) {
        Constants.socket!.write('$msg\n');
      }
    } catch (e) {
      print("Can't send : $e");
    }
  }
}
