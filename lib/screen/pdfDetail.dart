import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comics_app/repository/dataRepository.dart';
import 'package:comics_app/screen/partList.dart';
import 'package:comics_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:uuid/uuid.dart';
import '../models/parts.dart';
import '../models/pdfs.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:comics_app/models/user.dart';


typedef DialogCallback = void Function();

class PdfDetails extends StatelessWidget {
  final UserData pdf;
  final uid;
  const PdfDetails(this.uid, this.pdf);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(pdf.fiction_name== null ? "" : pdf.fiction_name),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: PdfDetailForm(uid, pdf),
      ),
    );
  }
}

class PdfDetailForm extends StatefulWidget {
  final UserData pdfs;
  final uid;

  const PdfDetailForm(this.uid, this.pdfs);

  @override
  _PdfDetailFormState createState() => _PdfDetailFormState();
}

class _PdfDetailFormState extends State<PdfDetailForm> {
  final DataRepository repository = DataRepository();
  final _formKey = GlobalKey<FormBuilderState>();
  final dateFormat = DateFormat('yyyy-MM-dd');
  String story_name;
  String image;
  String pdf_path;
  String pdf_url;
  // @override
  // void initState() {
  //   type = widget.pdfs.fiction_name;
  //   super.initState();
  // }

  final pdf = pw.Document();
  File file;
  writeOnPdf() async{
    pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a5,
          margin: pw.EdgeInsets.all(32),

          build: (pw.Context context) {
            return <pw.Widget>[
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
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    file = File("$documentPath/example.pdf");

    file.writeAsBytesSync(pdf.save());
    print("finished and saved in file...");
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("mypdf" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(file);
    pdf_url = await (await uploadTask).ref.getDownloadURL();
    // print("hello" + pdf_url);

  }

  // Future savePdf() async {
  //   print("called savePdf...");
  //   Directory documentDirectory = await getApplicationDocumentsDirectory();
  //
  //   String documentPath = documentDirectory.path;
  //
  //   file = File("$documentPath/example.pdf");
  //
  //   file.writeAsBytesSync(pdf.save());
  //   print("finished and saved in file...");
  //   FirebaseStorage storage = FirebaseStorage.instance;
  //   Reference ref = storage.ref().child("mypdf" + DateTime.now().toString());
  //   UploadTask uploadTask = ref.putFile(file);
  //   pdf_url = await (await uploadTask).ref.getDownloadURL();
  //   print("hello" + pdf_url);
  //   //await serv.insertData(file, file.path);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: FormBuilder(
        key: _formKey,
        //autovalidate: true,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            FormBuilderTextField(
             // attribute: "name",
              initialValue: widget.pdfs.fiction_name,
              decoration: textInputDecoration.copyWith(
                  hintText: 'Name', labelText: "Story Name"),
              validators: [
                FormBuilderValidators.minLength(1),
                FormBuilderValidators.required()
              ],
              onChanged: (val) {
                setState(() => story_name = val);
              },
            ),
            FormBuilderTextField(
              // attribute: "name",
              initialValue: widget.pdfs.image,
              decoration: textInputDecoration.copyWith(
                  hintText: 'Image', labelText: "Image"),
              validators: [
                FormBuilderValidators.minLength(1),
                FormBuilderValidators.required()
              ],
              onChanged: (val) {
                setState(() => image = val);
              },
            ),
            FormBuilderTextField(
              // attribute: "name",
              initialValue: widget.pdfs.fiction_name,
              decoration: textInputDecoration.copyWith(
                  hintText: 'Path', labelText: "Story Path"),
              validators: [
                FormBuilderValidators.minLength(1),
                FormBuilderValidators.required()
              ],
              onChanged: (val) {
                setState(() => pdf_path = val);
              },
            ),

            SizedBox(height: 20.0),

            FormBuilderCustomField(
              attribute: "parts",
              formField: FormField(
                enabled: true,
                builder: (FormFieldState<dynamic> field) {
                  return Column(
                    children: <Widget>[
                      SizedBox(height: 6.0),
                      Text(
                        "Parts",
                        style: TextStyle(fontSize: 16.0),
                      ),

                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 200),
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(16.0),
                          itemCount: widget.pdfs.parts == null
                              ? 0
                              : widget.pdfs.parts.length,
                          itemBuilder: (BuildContext context, int index) {
                            print(index);
                            return buildRow(widget.pdfs.parts[index]);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            FloatingActionButton(
              onPressed: () async {
                writeOnPdf();
                //savePdf();
                _addParts(widget.pdfs, () {
                  setState(() {});
                }
                );
              },
              tooltip: 'Add Part',
              child: Icon(Icons.add),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                    color: Colors.blue.shade600,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    )),
                MaterialButton(
                    color: Colors.blue.shade600,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        if (_formKey.currentState.validate()) {
                          Navigator.of(context).pop();
                          widget.pdfs.fiction_name = story_name?? widget.pdfs.fiction_name;
                          widget.pdfs.image = image?? widget.pdfs.image;
                          //widget.pdfs.pdf_path?? '';

                          repository.updatePdf(widget.pdfs);

                        }
                      }
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow(Parts parts) {
    return Row(
      children: <Widget>[
        // Expanded(
        //   flex: 1,
        //   child: Text(parts.name),
        // ),
        GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=> PartListScreen(parts.name))
            );
          },
          child: Container(
            child: Text( parts.name)
          ),
        ),
        // Container(
        //   flex: 1,
        //   child: Text(parts.pdf_url),
        // ),
        //Text(parts.createdAt == null ? "" : Timestamp.now().toString()),
       // Text(parts.updatedAt == null ? "" : Timestamp.now().toString()),
        // Checkbox(
        //   value: parts.done == null ? false : vaccination.done,
        //   onChanged: (newValue) {
        //     vaccination.done = newValue;
        //   },
        // )
      ],
    );
  }


  void _addParts(UserData pdfs, DialogCallback callback) {
    String part_name;
    // String part_url;
    final uuid = Uuid();
    File file;
    Timestamp created_at = Timestamp.now();
    Timestamp updated_at = Timestamp.now();

    final _formKey = GlobalKey<FormBuilderState>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Part"),
              content: SingleChildScrollView(
                child: FormBuilder(
                  key: _formKey,
                  //autovalidate: true,
                  child: Column(
                    children: <Widget>[

                      FormBuilderTextField(
                        attribute: "parts",
                        validators: [
                          FormBuilderValidators.minLength(1),
                          FormBuilderValidators.required()
                        ],
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Enter a Part Name',
                            labelText: "Part"),
                        onChanged: (text) {
                          setState(() {
                            part_name = text;
                          });
                        },
                      ),

                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel")),
                FlatButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Navigator.of(context).pop();
                        Parts newPart = Parts(uuid.v1(), name: part_name, pdf_url: pdf_url,
                            createdAt: created_at, updatedAt: updated_at);
                        if (pdfs.parts == null) {
                          pdfs.parts = List<Parts>();
                        }
                        pdfs.parts.add(newPart);
                      }
                      callback();
                    },
                    child: Text("Add")),
              ]);
        });
  }
}
