import 'package:comics_app/repository/dataRepository.dart';
import 'package:flutter/material.dart';
import 'package:comics_app/screen/pdfDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comics_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:comics_app/screen/pdfListScreen.dart';

class EditStoryScreen extends StatefulWidget{

  _editStoryScreenState createState() => _editStoryScreenState();
}

const BoldStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
class _editStoryScreenState extends State<EditStoryScreen>{

  String userId;
  User firebaseuser = FirebaseAuth.instance.currentUser;
  final DataRepository repository = DataRepository();
  String uid;
  Users user;
  UserData pdfs;
  @override
  Widget build(BuildContext context) {
    //DataRepository repo = new DataRepository();
    //UserDataNotifier notifier = Provider.of<UserDataNotifier>(context, listen: false);
    //User firebaseUser = FirebaseAuth.instance.currentUser;
    //userId = firebaseuser.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Story"),
      ),
        body: StreamBuilder(
            stream: getUserDataSnapshots(context),
            builder: (context, snapshot) {
              if(!snapshot.hasData) return const Text("Loading...");
              return new ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildListCard(context, snapshot.data.documents[index]));
            }
        )
    );
  }

  Stream<QuerySnapshot> getUserDataSnapshots(BuildContext context) async* {
    // final uid = await Provider.of(context).auth.getCurrentUID();
    uid = FirebaseAuth.instance.currentUser.uid;
    yield* FirebaseFirestore.instance.collection('userData').doc(uid).collection('pdfs').snapshots();
  }

  Widget buildListCard(BuildContext context, DocumentSnapshot pdfs) {
    return new Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 8.0, bottom: 4.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> PdfDetails(uid, pdfs))
                    );
                  },
                  child: Row(
                      children: <Widget>[
                        Expanded(child: Text(pdfs['fiction_name'],
                          style: new TextStyle(fontSize: 30.0),
                        ),),
                        Expanded(child: ClipOval(
                          child: CachedNetworkImage(imageUrl: pdfs['image'],
                            width: 50.0,
                            height: 50.0,
                          ),
                        )),
                        FlatButton(
                          onPressed: (){
                            UserData pdf = UserData.fromSnapshot(pdfs);
                            repository.deletePdf(pdf);
                            Future<QuerySnapshot> books =
                            Firestore.instance
                                .collection("userData")
                                .document(uid).collection("pdfs").where("id", isEqualTo: pdf.id).getDocuments();
                            books.then((value) {
                              value.documents.forEach((element) {
                                Firestore.instance
                                    .collection("userData")
                                    .document(uid)
                                    .collection("pdfs")
                                    .document(element.documentID)
                                    .delete()
                                    .then((value) => print("success"));
                              });
                            });
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> PdfListScreen()));
                          },
                          child: Text('delete'),
                          color: Colors.lightBlue,
                        )
                      ]
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}


