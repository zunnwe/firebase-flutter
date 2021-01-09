import 'package:comics_app/repository/dataRepository.dart';
import 'package:comics_app/screen/errorScreen.dart';
import 'package:comics_app/screen/pdfListScreen.dart';
import 'package:comics_app/models/user.dart';
import 'package:comics_app/screen/login.dart';
import 'package:comics_app/utils/userData_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comics_app/screen/registration.dart';
import 'package:flutter/cupertino.dart';


class Wrapper extends StatefulWidget {

  _WrapperState createState() => _WrapperState();
}
class _WrapperState extends State<Wrapper>{

  @override
  void initState() {
    // TODO: implement initState
    DataRepository repo = new DataRepository();
    UserDataNotifier notifier = Provider.of<UserDataNotifier>(context, listen: false);
    repo.getusersData(notifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Users>(context);
    
    // return either the Home or Authenticate widget
    if (user == null){
      return LoginScreen();
    } else {
      return PdfListScreen();
      // return MaterialApp(
      //   title: 'comics app',
      //   theme: ThemeData(
      //     primarySwatch: Colors.blue,
      //     accentColor: Colors.grey
      //   ),
      //   home: Consumer<List<UserData>>(
      //     builder: (context,notifier, child){
      //       return notifier.length != 0 ? PdfListScreen() : ErrorScreen();
      //     },
      //   ),
      // );
      // return Provider(
      //   create: (context) => List<UserData>(),
      //   child: Scaffold(
      //     appBar: AppBar(
      //       title: Text('test'),
      //     ),
      //     body: PdfListScreen(),
      //   ),
      // );

    }
    
  }
}

// if(userDataList != []) {
// Navigator.of(context)
//     .push(MaterialPageRoute(builder: (context) => PdfListScreen()));
// }