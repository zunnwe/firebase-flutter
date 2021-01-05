import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comics_app/pdfDetail.dart';
import 'package:comics_app/repository/dataRepository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uuid/uuid.dart';
import 'models/pdfs.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

const BoldStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Pet Medical Central',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeList());
  }
}

class HomeList extends StatefulWidget {
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  final DataRepository repository = DataRepository();

  @override
  Widget build(BuildContext context) {
    return _buildHome(context);
  }

  Widget _buildHome(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pets"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: repository.getStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();

            return _buildList(context, snapshot.data.documents);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addPdf(context);

        },
        tooltip: 'Add Pdf',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _addPdf(BuildContext context) {
    AlertDialogWidget dialogWidget = AlertDialogWidget();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Add Story"),
              content: dialogWidget,
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel")),
                FlatButton(
                    onPressed: () {
                      Pdfs newPdf = Pdfs(uuid.v1(), fiction_name: dialogWidget.fiction_name, image: dialogWidget.image_url, createdAt: dialogWidget.createdAt, updatedAt: dialogWidget.updatedAt);
                      repository.addPdf(newPdf);
                      Navigator.of(context).pop();
                    },
                    child: Text("Add")),
              ]);
        });
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final pdf = Pdfs.fromSnapshot(snapshot);
    if (pdf == null) {
      return Container();
    }

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: InkWell(
          child: Row(
            children: <Widget>[
              Expanded(child: Text(pdf.fiction_name == null ? "" : pdf.fiction_name, style: BoldStyle)),
              // _getPetIcon(pdf.type)
            ],
          ),
          onTap: () {
            _navigate(BuildContext context)  {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfDetails(pdf),
                  ));
            }

            _navigate(context);
          },
          highlightColor: Colors.green,
          splashColor: Colors.blue,
        ));
  }

}

class AlertDialogWidget extends StatefulWidget {
  //String pdfName;
  String image_url;
  //String pdf_path;
  String id;
  String fiction_name;
  Timestamp createdAt = Timestamp.now();
  Timestamp updatedAt = Timestamp.now();
  var uuid = Uuid();

  @override
  _AlertDialogWidgetState createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {
  File _image;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          TextField(
            autofocus: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter a Pdf Name"),
            onChanged: (text) => widget.fiction_name = text,
          ),
          RaisedButton(
            onPressed: () async{
              var cover_image = await ImagePicker.pickImage(source: ImageSource.gallery);
              setState(() {
              _image = cover_image;
              });
              String fileName = basename(_image.path);
              FirebaseStorage storage = FirebaseStorage.instance;
              Reference ref = storage.ref().child("myimg" + DateTime.now().toString());
              UploadTask uploadTask = ref.putFile(_image);
              widget.image_url =  await (await uploadTask).ref.getDownloadURL();
            },
            child: const Text('Add Image', style: TextStyle(fontSize: 20)),
            ),
        ],
      ),
    );
  }
  
}


