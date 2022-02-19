import 'package:flutter/material.dart';

class BhavishaScreen extends StatefulWidget {
  const BhavishaScreen({Key? key}) : super(key: key);

  @override
  _BhavishaScreenState createState() => _BhavishaScreenState();
}

class _BhavishaScreenState extends State<BhavishaScreen> {
  TextEditingController textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        shadowColor: Colors.black54,
        foregroundColor: Colors.white,
        title: Text("Hive Example"),
        centerTitle: true,
      ),
      body: mainBody(),
    );
  }
  Widget mainBody(){
    return Container(
      child: TextField(
        controller: textController,
      ),

    );
  }
}
