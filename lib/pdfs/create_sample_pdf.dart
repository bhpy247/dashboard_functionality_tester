import 'dart:io';
import 'dart:typed_data';
import 'package:dashboard_functionality_tester/pdfs/pdf_colors.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../graphs/componants/open_my_pdf.dart';

class CreateSamplePdf{
  Future<File?> generatePdf({required String text,required Uint8List graphImage}) async{
    final pdf = Document();
    final firstPageLogoImage=(await rootBundle.load('assets/common/M19_Logo_pdf.png')).buffer.asUint8List();
    final firstPageBackGroundImage=(await rootBundle.load('assets/common/bubblepoint_image.png')).buffer.asUint8List();
    final headerLogoImage=(await rootBundle.load('assets/common/M19_singlelogo.png')).buffer.asUint8List();

    pdf.addPage(
      Page(
         pageFormat: PdfPageFormat.a4,
          margin: EdgeInsets.symmetric(vertical: 40),
          build: (context){
             return getFirstPage(backgroundImage: firstPageBackGroundImage,logoImage: firstPageLogoImage);
          },
      ),
    );

    pdf.addPage(
      MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: EdgeInsets.symmetric(horizontal: 30,vertical: 40),
          header: (context){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                    children: [
                      Expanded(child:Divider(thickness: 1.2,color: PdfColors.blueGrey800),),
                      SizedBox(width: 5),
                      Image(MemoryImage(headerLogoImage),height: 55,width: 55)
                    ]
                ),
                SizedBox(height: 15),
                getText(text: "Material Intelligence Lab",color: PdfColors.blueGrey900,fontSize: 11),
                getText(text: "www.m19.io",color: PdfColors.blueGrey900,fontSize: 11),
                getText(text: "info@m19.io",color: PdfColors.blueGrey900,fontSize: 11),
                SizedBox(height: 15),
              ]
            );

            },
          build: (context){
            return [
              getSampleInformation(),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child:
                  getSampleBriefInfoBox(heading: "Bubble Point Pressure",value: "0.2",unit: "torr"),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                   child:getSampleBriefInfoBox(heading: "Bubble Point Diameter",value: "27.66",unit: "mm"),
                  )
                ]
              )


            ];
          },
          footer: (context){
            //final text="Page ${context.pageNumber}";
            return Column(
              children: [
                getText(text: "* * ISO : 17025 Acceredited Laboratories * *",fontWeight: FontWeight.bold,color: PdfColors.blueGrey800,fontSize: 11),
                Divider(thickness: 0.8,color: PdfColors.blueGrey800),
                getText(text: "Sample specimen are not drawn by M19 Lab. Result relates to the sample tested. The report shall not bereproduced except in full, without the written approval of the laboratory. The report is strically confidential and technical inforamtion of client only. Not for advertisement, promotion, publicity or litigation.",
                    fontWeight: FontWeight.normal,color: PdfColors.blueGrey800,textAlign: TextAlign.center,fontSize: 10),
                Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                      "Page ${context.pageNumber}",
                      textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 8
                    )
                  )
                ]
               )  
              ]
            );
              
          }

      ),
    );

    pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
          margin: EdgeInsets.symmetric(horizontal: 30,vertical: 40),
          header: (context){
          return Row(
              children: [
                Expanded(child:Divider(thickness: 1.2,color: PdfColors.blueGrey800),),
                SizedBox(width: 5),
                Image(MemoryImage(headerLogoImage),height: 55,width: 55)
              ]
          );},
        build: (context){
          return [
            SizedBox(height: 25),
            Image(MemoryImage(graphImage)),

          ];
        },
          footer: (context){
            //final text="Page ${context.pageNumber}";
            return
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        "Page ${context.pageNumber}",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 8
                        )
                    )
                  ]
              );
          }

      ),
    );

    pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
          margin: EdgeInsets.symmetric(horizontal: 30,vertical: 40),
          header: (context){
          return
            Column(
              children: [
                Row(
                    children: [
                      Expanded(child:Divider(thickness: 1.2,color: PdfColors.blueGrey800),),
                      SizedBox(width: 5),
                      Image(MemoryImage(headerLogoImage),height: 55,width: 55)
                    ]
                ),
                SizedBox(height: 20)
              ]
            );},
          
          build:(context){

          return [
            Table.fromTextArray(
              cellDecoration: (index, data, rowNum) {
                return BoxDecoration(
                  color: rowNum%2==0?PdfColors.grey200:PdfColors.white,
                );
              },
              headers: [
                  "Flow\ncfm",
                  "Differential Pressure\n(torr)",
                  "F/PT",
              ],
              data: List.generate(50, (index) => ["0.4581215","0.4581","7854.155"]),
              headerStyle: TextStyle(fontWeight: FontWeight.bold,color: PdfColors.white),
              headerAlignment: Alignment.center,
              headerDecoration: BoxDecoration(color: PdfColors.grey600),
              border: TableBorder.symmetric(inside: BorderSide.none,outside: BorderSide(color: PdfColors.grey300)),
              cellAlignment: Alignment.center,

            ),
          ];

          },
          footer: (context){
            //final text="Page ${context.pageNumber}";
            return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        "Page ${context.pageNumber}",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 8
                        )
                    )
                  ]
              );
          }
        ),
    );

    return OpenMyPdf.saveDocument(pdf: pdf, name: "MyPdf");
  }

  Widget getText({required String text,double fontSize = 12,PdfColor? color,FontWeight? fontWeight,TextAlign? textAlign}){
    return Text(text, style: TextStyle(fontSize: fontSize,color:color,fontWeight:fontWeight,),textAlign:textAlign );
  }

  Widget getBlueText({String text = "",double fontSize = 15}){
    return   Text(text, style: TextStyle(fontSize: fontSize,color: PdfColor.fromHex(CustomPDFColors.blueColor)),);
  }

  Widget getFirstPage({final logoImage,final backgroundImage}){
     return Column(
       children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.end,
             children:[
               Image(MemoryImage(logoImage),width: 300,height: 63),
               SizedBox(width: 25)
             ]
         ),
         SizedBox(height: 35),
         Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
             Image(MemoryImage(backgroundImage),height: 800),
           ]
         ),
         SizedBox(height: 40),
         Container(
           padding: EdgeInsets.symmetric(horizontal: 40),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Expanded(
                   flex:5,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       getText(text: "SAMPLE REPORT",fontSize: 9),
                       getText(text: "DATE : 22 JUN 2017 | 02:00:00",fontSize: 9),
                     ]
                   )
                 ),
                 Expanded(
                   flex:4,
                     child:Text("Friendly It Solution", style: TextStyle(fontSize: 35,color: PdfColor.fromHex("#3e4095"),),maxLines: 3,textAlign: TextAlign.right))
               ]
           )
         ),
         /*Spacer(),
         Row(
           mainAxisAlignment: MainAxisAlignment.end,
             children: [
               Text(
                   "Page 1",
                   textAlign: TextAlign.right
                 ),
                 SizedBox(width: 30)
               ]
            )*/




       ]
     ) ;
   }

  Widget getSampleInformation(){
    return Container(

        child:Column(
      children:[
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
            color: PdfColors.grey600
          ),
          child: getText(text: "Sample Information",textAlign: TextAlign.center,color: PdfColors.white,fontWeight: FontWeight.bold),
        ),
        getSampleInfoRow(title: "Customer ID",value: "N008",color: PdfColors.white),
        getSampleInfoRow(title: "Customer ID",value: "N008",color: PdfColors.grey200),

      ]
    ));
  }

  Widget getSampleInfoRow({required String title,required String value,required PdfColor color}){
    return Container(
      color: color,
        child: Row(
      children: [
        Expanded(child:
        Container(
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
            decoration: BoxDecoration(
            border: Border(right: BorderSide(color: PdfColors.grey400))
          ),
            child:getText(text: title,textAlign: TextAlign.left,fontWeight: FontWeight.bold)
        )
        ),
        Expanded(child:
        Container(
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
          child: getText(text: value,textAlign: TextAlign.left)),

        )
      ]
    ));
  }

  Widget getSampleBriefInfoBox({required String heading,required String value,required String unit,}){
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
              color: PdfColors.grey600
          ),
          child: getText(text: heading,textAlign: TextAlign.center,color: PdfColors.white,fontWeight: FontWeight.bold),
        ),
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
              color: PdfColors.grey200
          ),
          child: getText(text: "$value\n$unit",textAlign: TextAlign.center,color: PdfColors.grey900,fontWeight: FontWeight.bold),
        ),

      ]
    );
  }



}

