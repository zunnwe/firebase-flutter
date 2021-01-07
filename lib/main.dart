import 'package:comics_app/screen/wrapper.dart';
import 'package:comics_app/models/user.dart';
import 'package:comics_app/repository/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:comics_app/models/pdfs.dart';
import 'package:comics_app/repository/dataRepository.dart';
import 'package:flutter/cupertino.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers:[
      ChangeNotifierProvider<DataRepository>(
        create: (context) => DataRepository(),
      ),
      StreamProvider<Users>.value(value: AuthService().user)
    ],
    child:  MaterialApp( home: Wrapper())
  ));
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     // return StreamProvider<Users>.value(
//     //   value: AuthService().user,
//     //   child: MaterialApp(
//     //     home: Wrapper(),
//     //   ),
//     // );
//     return MultiProvider(
//       providers: [
//         StreamProvider<Users>.value(value: AuthService().user),
//
//       ],
//         child: MaterialApp( home: Wrapper())
//     );
//   }
//
// }