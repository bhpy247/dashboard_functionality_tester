import 'package:dashboard_functionality_tester/screens/Constant.dart';

import 'connection.dart';

class MyCommand {
  static void hardReset() {
    Connection().sendData("hardReset");
  }
  static void connect(String port) {
    Connection().sendData("connect,$port");

  }

  static void sendNormalMsg(String msg){
    Connection().sendData("normal,$msg");
  }

  static void refresh() {
    Connection().sendData("refresh");
  }

  static void setLacthing(String ss, int slp) {
    Connection().sendData("setLacthing,$ss,$slp");
  }

  static void setStability(int no, int val, int delay) {
    Connection().sendData("setStability,$no,$val,$delay");
  }

  static void systemReset() {
    Connection().sendData("systemReset");
  }

  static void valveOn(int no, int delay) {
    Connection().sendData("valveOn,$no,$delay");
  }

  static void valveOff(int no, int delay) {
    Connection().sendData("valveOff,$no,$delay");
  }

  static void getADCSingleVal(int adcno, int delay) {
    Connection().sendData("getADCSingleVal,$adcno,$delay");
  }

  static void setDACIncrement(int v1, int v2, int v3, int v4, int delay) {
    Connection().sendData("setDACIncrement,$v1,$v2,$v3,$v4,$delay");
  }

  static void setDACValue(dynamic dacno, int val, int delay) {
    Connection().sendData("setDACValue,$dacno,$val,$delay");
  }

  static void startADC(int delay) {
    Connection().sendData("startADC,$delay");
  }

  static void stopADC(int delay) {
    Connection().sendData("stopADC,$delay");
  }

  static void setDelay(int miliseconds, int delay) {
    Connection().sendData("setDelay,$miliseconds,$delay");
  }

  static void sendAdcEnableBits(String bit, int delay) {
    Connection().sendData("sendAdcEnableBits,$bit,$delay");
  }
}
