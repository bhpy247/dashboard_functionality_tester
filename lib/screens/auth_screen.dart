
import 'dart:core';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_desktop/firebase_core_desktop.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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
      body: body(),
    );
  }
  DataCollection? data;

  Widget body(){
    return Column(
      children: [
        Container(
          child: MaterialButton(
            onPressed: ()async{
              // Firestore.initialize("testing-project-2200b");

              for(int i=0;i<30;i++) {
                Map<String,dynamic>data = {
                  "data $i": "value data $i"
                };
                print("Successfully completed");

                String uuid = Uuid().v4();
               await Firestore.instance.collection("data").document(uuid).set(data).then((value) {
                 print("Successfully completed");
               }).catchError((error){print("error in uploading: $error");});
              }
//               var map = await Firestore.instance.collection("data").get();
//               print(map);
//                data = DataCollection(data:map.first.map);
// setState(() {
//
// });
//               // var users = UserCollection.fromMap(map);
            },
            child: Text("Firebase upload"),
          ),
        ),
       data != null? Visibility(
            visible: data != null,
            child: Text("Data: ${data!.data!.keys}")):Container(),
      ],

    );
  }
}


class DataCollection{
  Map<String,dynamic>? data;

  DataCollection({this.data});

  static DataCollection fromMap(Map<String,dynamic> map){
  Map<String,dynamic>? data;
  data = {};
  try{
    Map<String,dynamic> dataMap = Map.from(Map.castFrom(map["data"] ?? {}));
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