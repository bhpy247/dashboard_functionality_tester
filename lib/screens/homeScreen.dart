import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'Mycommand.dart';
import 'connection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  Socket? socket;
  int? pid;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      //Colors.grey[850]
      appBar: AppBar(title: Text("Home"),),
      body: mainBody(context),
    );
  }

  Widget mainBody(context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          commonButton(text: "connect",onTap: (){
            Connection().connect('192.168.29.79', 6667, "COM6");

          }),
          commonButton(text: "Start Sending",onTap: ()async{
            MyCommand.setDACValue("2", 30000, 0);
            await Future.delayed(Duration(seconds: 1));
            MyCommand.valveOff(4, 0);
            await Future.delayed(Duration(seconds: 1));
            MyCommand.valveOn(2, 0);
            await Future.delayed(Duration(seconds: 1));
            MyCommand.valveOn(5, 0);
            await Future.delayed(Duration(seconds: 1));
            MyCommand.setDACValue("1", 5000, 0);
            await Future.delayed(Duration(seconds: 1));
            MyCommand.valveOff(5, 0);
            await Future.delayed(Duration(seconds: 1));
            MyCommand.setDelay(500, 0);
            await Future.delayed(Duration(seconds: 1));
            MyCommand.sendAdcEnableBits("101", 1000);
            await Future.delayed(Duration(seconds: 1));
            MyCommand.startADC(3000);
          }),
          commonButton(text: "Stop Adc",onTap: (){
            MyCommand.stopADC(3000);
          }),
          commonButton(text: "Refresh",onTap: (){
           MyCommand.refresh();
          }),
          commonButton(text: "HardRest",onTap: (){
            MyCommand.hardReset();
          }),
          commonButton(text: "Normal Msg",onTap: (){
            MyCommand.sendNormalMsg("hello");
          }),
          commonButton(text: "Start Reading",onTap: (){
            Connection().startReading();
          }),
          commonButton(text: "Disconnect",onTap: (){
            Connection().disConnect();
          }),
        ],
      )
    );
  }

  Widget oldButtons(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        commonButton(onTap: ()async{

          print("start connecting");
          socket = await Socket.connect("192.168.29.126", 6667);
          print("Connected");
        },text: "Connect"),
        commonButton(onTap: (){
          print("Start  listing");
          socket!.listen((data) {
            String stringData = utf8.decode(data);
            print("Data String:${stringData}");

            if(stringData.contains("data:"))
            {
              Map val=json.decode(stringData.replaceAll("data:", ""));
              print("Val  : ${val}");
            }


          });

        },text: "Start Recieving"),
        commonButton(onTap: (){
          socket!.write('Hello, Server!\n');
        },text: "Send"),
        commonButton(onTap: (){
          socket!.destroy();
          socket!.close();
        },text: "Stop"),
        commonButton(onTap: ()async{

          if(pid==null) {
            var result = await Process.run(
                'C:\\Program Files\\Notepad++\\notepad++.exe', []);

            pid=result.pid;
            print("Data : $pid");
          }
          else
          {
            await Process.killPid(pid!);
            pid=null;
          }

          // Navigator.push(context, MaterialPageRoute(builder: (context){return mainPage();}));
        },text: "M"),
        commonButton(onTap: (){
          Navigator.pushNamed(context, '/testScreen');

        },
            text: "Test"),
      ],
    );

  }

  Widget commonButton({Function()? onTap, String text = ""})
  {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
          BoxShadow(
              color:  Colors.black54,
              offset: Offset(4.0, 4.0),
              blurRadius: 20.0,
              spreadRadius: 1.0),
          BoxShadow(
              color:  Colors.grey[800]!,
              offset: Offset(-4.0, -4.0),
              blurRadius: 15.0,
              spreadRadius: 0.5),
        ]
      ),

      child: MaterialButton(
        padding: EdgeInsets.all(30),
      // height: 50,
      //   minWidth: 50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onTap,
        color: Colors.grey[850],
        child: Text(text, style: TextStyle(fontSize: 20,color: Colors.white),),
      ),
    );
  }
}
