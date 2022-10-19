import 'dart:typed_data';

class WritingFormat
{

  static String writeStringFormat(String val){

    String ans;
    ans = "\n\r" + val +"CE\n";
    return ans;
  }

  static Uint8List writeUint8Format(Uint8List val){
    List<int> list = "\n\r".codeUnits;
    Uint8List bytes=Uint8List.fromList(list);
    bytes.addAll(val);
    list = "CE\n".codeUnits;
    bytes.addAll(Uint8List.fromList(list));
    return bytes;
  }

  static String addBlank(String val,int i)
  {
    String ans;
    ans = val + ("-"*i);
    return ans;
  }

  static String stopTN(){
    return "\n\rXX--CE\n";
  }



}