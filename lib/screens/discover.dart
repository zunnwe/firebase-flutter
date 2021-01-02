import 'dart:io';

import 'package:comics_app/models/pdfs.dart';
import 'package:comics_app/screens/PdfList.dart';
import 'package:comics_app/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';

class DiscoverScreen extends StatefulWidget {

  @override
  _LoadFirebaseStoragePdfState createState() => _LoadFirebaseStoragePdfState();
}

class _LoadFirebaseStoragePdfState extends State<DiscoverScreen>{
  File file;
  String pdf_url = '';
  final pdf = pw.Document();
  final DatabaseService serv = new DatabaseService();
  String userID = '';
  List pdfList = [];

  writeOnPdf(){
    pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a5,
          margin: pw.EdgeInsets.all(32),

          build: (pw.Context context){
            return <pw.Widget>  [
              pw.Header(
                  level: 0,
                  child: pw.Text("Easy Approach Document")
              ),

              pw.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),

              pw.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),

              pw.Header(
                  level: 1,
                  child: pw.Text("Second Heading")
              ),

              pw.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),

              pw.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),

              pw.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),
            ];
          },


        )
    );
  }

  Future savePdf() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    file = File("$documentPath/example.pdf");

    file.writeAsBytesSync(pdf.save());
    await serv.insertData(file, file.path);
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return StreamProvider<List<Pdfs>>.value(
        value: DatabaseService().pdfs,
        catchError: (_, err) => null,
        child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
              title: Text('Brew Crew'),
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
            ),
            body:Container(
              child: PdfList(),
            ),

            floatingActionButton: FloatingActionButton(
              onPressed: ()async{
                writeOnPdf();
                await savePdf();

              },
              child: Icon(Icons.save),

            ),
        ));
    }

  }



