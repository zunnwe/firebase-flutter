import 'package:comics_app/repository/dataRepository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comics_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:comics_app/utils/userData_notifier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:comics_app/screen/pdfDetail.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditStoryScreen extends StatefulWidget{

  _editStoryScreenState createState() => _editStoryScreenState();
}

const BoldStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
class _editStoryScreenState extends State<EditStoryScreen>{

  String userId;
  User firebaseuser = FirebaseAuth.instance.currentUser;
  final DataRepository repository = DataRepository();

  Users user;
  UserData pdfs;
  @override
  Widget build(BuildContext context) {
    //DataRepository repo = new DataRepository();
    //UserDataNotifier notifier = Provider.of<UserDataNotifier>(context, listen: false);
    //User firebaseUser = FirebaseAuth.instance.currentUser;
    //userId = firebaseuser.uid;
    return Container(
        child: StreamBuilder(
            stream: getUserDataSnapshots(context),
            builder: (context, snapshot) {
              if(!snapshot.hasData) return const Text("Loading...");
              return new ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildTripCard(context, snapshot.data.documents[index]));
            }
        )
    );
  }

  Stream<QuerySnapshot> getUserDataSnapshots(BuildContext context) async* {
    // final uid = await Provider.of(context).auth.getCurrentUID();
    final uid = FirebaseAuth.instance.currentUser.uid;
    yield* FirebaseFirestore.instance.collection('userData').doc(uid).collection('pdfs').snapshots();
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot pdfs) {
    return new Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(pdfs['fiction_name'], style: new TextStyle(fontSize: 30.0),),
                  Spacer(),
                ]),
              ),

            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildHome(BuildContext context) {
  //
  //   user = Provider.of<Users>(context);
  //   return Scaffold(
  //     // body: StreamBuilder(
  //     //     stream: getuserDataList(),
  //     //     builder: (context,  AsyncSnapshot<DocumentSnapshot> snapshot) {
  //     //       if (!snapshot.hasData) return LinearProgressIndicator();
  //     //       else if(snapshot.hasData){
  //     //         //return _buildList(context, snapshot.data.documents);
  //     //         return Container(
  //     //           child: Column(
  //     //             children: <Widget>[
  //     //               Text(snapshot.data['fiction_name']),
  //     //             ],
  //     //           ),
  //     //         );
  //     //       }
  //     //       return LinearProgressIndicator();
  //     //     }),
  //     body: StreamBuilder(
  //         stream: getUserDataSnapshots(context),
  //         builder: (context, snapshot) {
  //           if(!snapshot.hasData) return const Text("Loading...");
  //           return new ListView.builder(
  //               itemCount: snapshot.data.documents.length,
  //               itemBuilder: (BuildContext context, int index) =>
  //                   _buildListItem(context, snapshot.data.documents[index]));
  //         }
  //     ),
  //   );
  // }

  // Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  //   return ListView(
  //     padding: const EdgeInsets.only(top: 20.0),
  //     children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  //   );
  // }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final pdf = UserData.fromSnapshot(snapshot);
    print('pdfs');
    print(pdf);
    if (pdf == null) {
      return Center(child: Text('no data found'),);
    }
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          child: Row(
            children: <Widget>[
              Expanded(child: Text(pdf.fiction_name == null ? "ficton_name" : pdf.fiction_name, style: BoldStyle)),
              Expanded(
                  child: ClipOval(
                    child: CachedNetworkImage(imageUrl: pdf.image,
                      width: 80.0,
                      height: 80.0,
                    ),
                  )
              )
              // _getPetIcon(pdf.type)
            ],
          ),
          onTap: () {
            _navigate(BuildContext context)  {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfDetails(user.uid, pdf),
                  ));
            }

            _navigate(context);
          },
          highlightColor: Colors.green,
          splashColor: Colors.blue,
        ));
  }

}


