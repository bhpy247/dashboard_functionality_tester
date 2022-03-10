import 'package:dashboard_functionality_tester/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class BhavishaScreen extends StatefulWidget {
  const BhavishaScreen({Key? key}) : super(key: key);

  @override
  _BhavishaScreenState createState() => _BhavishaScreenState();
}

class _BhavishaScreenState extends State<BhavishaScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController sirNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController somethingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      theme: NeumorphicThemeData(
        baseColor: Color(0xff333333),
        accentColor: Colors.teal,
        lightSource: LightSource.topLeft,
        depth: 4,
        intensity: 0.3,
      ),
      title: 'Bhavisha Home',
      home: mainBody(),

    );
  }
  Widget mainBody(){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        shadowColor: Colors.grey[800]!,
        foregroundColor: Colors.teal,
        centerTitle: true,
        title: Text("Bhavisha Home",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: NeumorphicText(
                      "Enter name:",
                      textStyle: NeumorphicTextStyle(
                        fontSize: 20,
                      ),
                      style: NeumorphicStyle(
                        color: Colors.teal,
                        depth: 0,
                  )),
                ),
                SizedBox(
                  width: 1000,
                  child: Neumorphic(
                    child: TextField(
                      controller: nameController,
                    ),

                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: NeumorphicText(
                      "Enter sirname:",
                      textStyle: NeumorphicTextStyle(
                        fontSize: 20,
                      ),
                      style: NeumorphicStyle(
                        color: Colors.teal,
                        depth: 0,
                  )),
                ),
                SizedBox(
                  width: 1000,
                  child: Neumorphic(
                    child: TextField(
                      controller: sirNameController,
                    ),

                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: NeumorphicText(
                      "Enter number:",
                      textStyle: NeumorphicTextStyle(
                        fontSize: 20,
                      ),
                      style: NeumorphicStyle(
                        color: Colors.teal,
                        depth: 0,
                      )),
                ),
                SizedBox(
                  width: 1000,
                  child: Neumorphic(
                    child: TextField(
                      controller: numberController,
                    ),

                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: NeumorphicText(
                      "Description:",
                      textStyle: NeumorphicTextStyle(
                        fontSize: 20,
                      ),
                      style: NeumorphicStyle(
                        color: Colors.teal,
                        depth: 0,
                      )),
                ),
                SizedBox(
                  width: 1000,
                  child: Neumorphic(
                    child: TextField(
                      controller: descriptionController,
                    ),

                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: NeumorphicText(
                      "Email:",
                      textStyle: NeumorphicTextStyle(
                        fontSize: 20,
                      ),
                      style: NeumorphicStyle(
                        color: Colors.teal,
                        depth: 0,
                      )),
                ),
                SizedBox(
                  width: 1000,
                  child: Neumorphic(
                    child: TextField(
                      controller: emailController,
                    ),

                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: NeumorphicText(
                      "something:",
                      textStyle: NeumorphicTextStyle(
                        fontSize: 20,
                      ),
                      style: NeumorphicStyle(
                        color: Colors.teal,
                        depth: 0,
                      )),
                ),
                SizedBox(
                  width: 1000,
                  child: Neumorphic(
                    child: TextField(
                      controller: somethingController,
                    ),

                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            NeumorphicButton(
              onPressed: (){},
              child: NeumorphicText("save",textStyle: NeumorphicTextStyle(
                fontSize: 20,
              ),
                  style: NeumorphicStyle(
                    color: Colors.teal,
                    depth: 0,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
