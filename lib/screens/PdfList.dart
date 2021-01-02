import 'package:comics_app/models/pdfs.dart';
import 'package:comics_app/screens/PdfTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PdfList extends StatefulWidget {
  @override
  _PdfListState createState() => _PdfListState();
}

class _PdfListState extends State<PdfList> {
  @override
  Widget build(BuildContext context) {

    final pdfs = Provider.of<List<Pdfs>>(context) ?? [];
    return ListView.builder(
      itemCount: pdfs.length,
      itemBuilder: (context, index) {
        return PdfTile(pdfs: pdfs[index]);
      },
    );
  }
}