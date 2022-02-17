
import 'dart:core';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_desktop/firebase_core_desktop.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Authentication"),
      ),
    );
  }

  Widget body(){
    return Container(
      child: MaterialButton(
        onPressed: ()async{
          Firestore.initialize("testing-project-2200b");
          var map = await Firestore.instance.collection("data").get();
          print(map);
          // var data = DataCollection(data:map);

          // var users = UserCollection.fromMap(map);
        },
        child: Text("Firebase upload"),
      ),
    );
  }
}


class DataCollection{
  Map<String,double>? data;

  DataCollection({this.data});

  static DataCollection fromMap(Map<String,dynamic> map){
  Map<String,double>? data;
  data = {};
  try{
    Map<String,double> dataMap = Map.from(Map.castFrom(map["data"] ?? {}));
    dataMap.forEach((key, value)  {
      if(key != null && key.isNotEmpty){
        data!.addAll({key: value});
      }
    });
  } catch (e, s){
    print("Error in parsing data in User Model.fromMap : ${e}");
    print(s);
  }
  return DataCollection(data:data );
  }
}