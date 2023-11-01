import 'dart:typed_data';

import 'package:dashboard_functionality_tester/command_files/writing_format.dart';
import 'package:serial_port_win32/serial_port_win32.dart';

import 'constants.dart';

class MyCommands
{

  static Future<void> hardReset({int delay=200}) async
  {

    MyConstants().port.setFlowControlSignal(SerialPort.SETDTR);
    await Future.delayed(Duration(microseconds: delay));
    MyConstants().port.setFlowControlSignal(SerialPort.CLRDTR);

  }

  static void refresh() {

    String command;
    command = WritingFormat.writeStringFormat('XX---');
    sendStringData(command, 100);
  }

  static void setLatching(String ss,int slp)
  {
    String command;
    command = WritingFormat.writeStringFormat("LV"+ss);
    sendStringData(command, slp);
  }

  List<int> getAdcData(Uint8List data,{bool isPrint=false}){
    List<int> adcData=[];
    for (int i = 4; i < 49; i+=3){
      int ans = getIntFromBit(data[i],data[i+1],data[i+2]);
      adcData.add(ans);
    }
    if(isPrint){
      print("getAdcData: $adcData");
    }
    return adcData;
  }

  static void setStability(int no,int val,int delay)
  {
    String command;
    command = WritingFormat.writeStringFormat("FMT$no$val");
    sendStringData(command, delay);

  }

  static void systemReset(){
    String command;
    command = WritingFormat.writeStringFormat("CVD11110000000000");
    sendStringData(command,200);

  }

  static void valveOn(int no, int delay)
  {
    String command;
    command = WritingFormat.writeStringFormat("V${no}100");
    sendStringData(command, delay);

  }
  static void valveOff(int no, int delay)
  {
    String command;
    command = WritingFormat.writeStringFormat("V${no}000");
    sendStringData(command, delay);


  }

  static void getADCSingleVal(int adcno, int delay)
  {
    String command;
    command = WritingFormat.writeStringFormat("RSA${adcno}1");
    sendStringData(command, delay);

  }

  static void setDACIncrement(int v1, int v2, int v3, int v4, int delay) {
    Uint8List command;
    List<int> list = "FMDI".codeUnits;
    Uint8List bytes=Uint8List.fromList(list);
    bytes.addAll(Uint8List.fromList(getBitFromInt(v1)));
    bytes.addAll(Uint8List.fromList(getBitFromInt(v2)));
    bytes.addAll(Uint8List.fromList(getBitFromInt(v3)));
    bytes.addAll(Uint8List.fromList(getBitFromInt(v4)));
    command = WritingFormat.writeUint8Format(bytes);
    sendUint8Data(command, delay);
  }

  static void setDACValue(String dacno, int val, int delay)
  {
    Uint8List command;
    List<int> list = "FMDI${dacno}".codeUnits;
    Uint8List bytes=Uint8List.fromList(list);
    bytes.addAll(Uint8List.fromList(getBitFromInt(val)));
    command = WritingFormat.writeUint8Format(bytes);
    sendUint8Data(command, delay);
  }

  static void sendStringData(String w, int slp) {
    MyConstants().port.writeBytesFromString(w);
  }

  static void sendUint8Data(Uint8List w, int slp) {
    MyConstants().port.writeBytesFromUint8List(w);
  }

  static void startADC(int delay) {

    String command;
    command = WritingFormat.writeStringFormat("FMS--");
    sendStringData(command, delay);
  }

  static void stopADC(int delay) {

    String command;
    command = WritingFormat.writeStringFormat("FMX--");
    sendStringData(command, delay);

  }

  static void setDelay(int miliseconds, int delay) async {

    Uint8List command;
    List<int> list = "FML".codeUnits;
    List<int> bytes = [
      ..."FML".codeUnits,
      ...getBitFromInt(miliseconds),
    ];
    command = WritingFormat.writeUint8Format(Uint8List.fromList(bytes));
    sendUint8Data(command, delay);

  }

  static void sendAdcEnableBits(String bit, int delay) {

    String command;
    command = WritingFormat.writeStringFormat("FMAE$bit");
    sendStringData(command, delay);

  }

  static void sendAdcEnableBits2(String ch1, String ch2, String ch3, String ch4, String ch5, String ch6, String ch7, String ch8,
      String ch9, String ch10, String ch11, String ch12, String ch13, String ch14, String ch15, int delay) {
    String command;
    command = WritingFormat.writeStringFormat("FMAE$ch1$ch2$ch3$ch4$ch5$ch6$ch7$ch8$ch9$ch10$ch11$ch12$ch13$ch14$ch15");
    sendStringData(command, delay);

  }

  static List<int> getBitFromInt(int val) {
    String st=val.toRadixString(16);
    String pad="000000";

    String st1 = (pad + st).substring(st.length);

    print("st : $st1");
    List<int> list=[];

    list.add(int.parse(st1.substring(0, 2), radix: 16));
    list.add(int.parse(st1.substring(2,4), radix: 16));
    list.add(int.parse(st1.substring(4,6), radix: 16));

    return list;

  }


  int getIntFromBit(int a1,int a2,int a3){
    int a=0;
    a=a1<<16;
    a2=a2<<8;
    a=a|a2;
    a=a|a3;

    return a;

  }

}