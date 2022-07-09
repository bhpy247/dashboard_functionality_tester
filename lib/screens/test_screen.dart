import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    final port = SerialPort("COM13");
    print("hello $port");
    return Column(
      children:  [
        const Text("Test Screen"),
        Row(
          children: [
            commonButton(text: "Connect",onTap: (){
              print("port ${port.isOpen}");

            }),

          ],
        ),

      ],
    );
  }

  Widget commonButton({Function()? onTap, String text = ""})
  {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            const BoxShadow(
                color:  Colors.black54,
                offset: Offset(4.0, 4.0),
                blurRadius: 20.0,
                spreadRadius: 1.0),
            BoxShadow(
                color:  Colors.grey[800]!,
                offset: const Offset(-4.0, -4.0),
                blurRadius: 15.0,
                spreadRadius: 0.5),
          ]
      ),

      child: MaterialButton(
        padding: const EdgeInsets.all(30),
        // height: 50,
        //   minWidth: 50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onTap,
        color: Colors.grey[850],
        child: Text(text, style: const TextStyle(fontSize: 20,color: Colors.white),),
      ),
    );
  }

}
