import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'Mycommand.dart';
import 'connection.dart';
import 'dart:io' as io;

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
          //  Connection().connect('192.168.29.79', 6667, "COM6");
            Connection().connect('localhost', 6667, "COM6");

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
          commonButton(onTap: ()async{
            final dir = await getApplicationDocumentsDirectory();
            print("dir : $dir");
            String path=dir.path+"\\main.jar";
            String path1=dir.path+"\\rxtxParallel.dll";
            String path2=dir.path+"\\rxtxSerial.dll";
            if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
              print("not found , so create file from asset to local");
              ByteData data = await rootBundle.load("asset/main.jar");
              List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
              await File(path).writeAsBytes(bytes);
            }
            if (FileSystemEntity.typeSync(path1) == FileSystemEntityType.notFound) {
              print("not found , so create file from asset to local");
              ByteData data = await rootBundle.load("asset/rxtxParallel.dll");
              List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
              await File(path1).writeAsBytes(bytes);
            }
            if (FileSystemEntity.typeSync(path2) == FileSystemEntityType.notFound) {
              print("not found , so create file from asset to local");
              ByteData data = await rootBundle.load("asset/rxtxSerial.dll");
              List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
              await File(path2).writeAsBytes(bytes);
            }

            // print("files : ${file}");
             path=dir.path+"\\main.jar";
             print("path : $path");
             Process.run('java', [
              '-jar',
              path,
            ]).then((ProcessResult results) {
              print(results.stdout);
              print(results.stderr);
            })
                .catchError((e) {
              print(e);
            });

            // Navigator.push(context, MaterialPageRoute(builder: (context){return mainPage();}));
          },text: "Run Process"),
          commonButton(onTap: ()async{

            String javaBinPath = '${Platform.environment['JAVA_HOME']}\\bin';
            String javapath="C:\\Program Files\\Java\\jdk1.8.0_221\\bin";
            print("path : $javapath");
            var jps = Process.runSync('jps', [], workingDirectory: javapath, runInShell: true);

            for (var line in LineSplitter.split(jps.stdout)) {
              List<String> parts = line.split(' ');
              int pid = int.parse(parts[0]);
              String name = parts[1];
              if (name == 'main.jar') {
                print("main jar detected $pid");
                Process.killPid(pid);
                break;
              }
            }
            print("done");
            // Navigator.push(context, MaterialPageRoute(builder: (context){return mainPage();}));
          },text: "Delete Process"),
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


          // if(pid==null) {
          //   // var result = await Process.run(
          //   //     'C:\\Program Files\\Notepad++\\notepad++.exe', []);
          //   print("dir  :$dir");
          //   var result = await Process.run(
          //       "asset\\main.jar", []);
          //
          //   pid=result.pid;
          //   print("Data : $pid");
          // }
          // else
          // {
          //   await Process.killPid(pid!);
          //   pid=null;
          // }

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
