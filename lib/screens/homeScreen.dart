import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
          commonButton(onTap: (){},text: "V"),
          commonButton(onTap: (){},text: "H"),
          commonButton(onTap: (){},text: "B"),
          commonButton(onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){return HomeScreen();}));
          },text: "M"),
        ],
      ),
    );
  }

  Widget commonButton({Function()? onTap, String text = ""}){
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
