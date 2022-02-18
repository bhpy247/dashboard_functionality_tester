import 'package:flutter/material.dart';
class CommonDropDown extends StatefulWidget {
  List<String> list;
  String? dropdownValue;
  String? hint = "";

  Function(String?)? onChanged;

  CommonDropDown({Key? key,required this.list,required this.dropdownValue,this.onChanged,this.hint}) : super(key: key);

  @override
  State<CommonDropDown> createState() => _CommonDropDownState();
}

class _CommonDropDownState extends State<CommonDropDown> {
  @override
  Widget build(BuildContext context) {

    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 0),
      decoration: BoxDecoration(
          border: Border.all(width: 2,color: Colors.deepPurple),
          borderRadius: BorderRadius.circular(6)
      ),
      child: DropdownButton(
          alignment: Alignment.center,
          //menuMaxHeight: 200,

          isExpanded: true,
          iconSize: 30  ,
          underline: Container(color: Colors.transparent),
          value: widget.dropdownValue,
          hint: Text(widget.hint ?? ""),
          items: widget.list.map((itemvalue) {
            return DropdownMenuItem(value: itemvalue, child: Text(itemvalue,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),));
          }).toList(),
          onChanged:  (String? newValue){
            widget.onChanged!(newValue);
            setState(() {
              widget.dropdownValue= newValue!;
            });
          }
      ),
    );
  }
}
