import 'dart:io';
import 'dart:typed_data';

import 'package:dashboard_functionality_tester/graphs/componants/open_my_pdf.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart';

class CreatePdf {
  Future<File?> generatePdf({required String text}) {
    final pdf = Document();

    pdf.addPage(Page(build: (context) {
      return Text(text, style: TextStyle(fontSize: 30));
    }));

    return OpenMyPdf.saveDocument(pdf: pdf, name: "MyPdf");
  }
}

class CreateImagePdf {
  Future<File?> generatePdf(Uint8List newImage) async{
    final pdf = Document();
    final image=(await rootBundle.load('assets/images/abc.jpg')).buffer.asUint8List();

   pdf.addPage(
     MultiPage(build: (context) {
       return [
          Image(MemoryImage(newImage)),

       ];
     })
   );

    return OpenMyPdf.saveDocument(pdf: pdf, name: "MyImagePdf");
  }
}
