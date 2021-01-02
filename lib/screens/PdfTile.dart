import 'package:comics_app/models/pdfs.dart';
import 'package:comics_app/screens/pdfPreviewScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class PdfTile extends StatelessWidget {
  String pathPDF = "";
  Pdfs pdfs;
  PdfTile({this.pdfs});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
     children: <Widget> [
       GestureDetector(
         onTap: () async{
           pathPDF = await createFileOfPdfUrl().then((f) => f.path);
           Navigator.push(context, MaterialPageRoute(
               builder: (context) => PdfPreviewScreen(path: pathPDF)
              )
           );
         },
         child: Container(
           decoration: BoxDecoration(
               border: Border.all(width: 10.0, color: const Color(0xFFFFFFFF))
           ),
           child: Text(
               pdfs.pdf_path
           ),
         ),
       )

     ],
    );
  }


  Future<File> createFileOfPdfUrl() async {
    final url = pdfs.pdf_url;
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }
}