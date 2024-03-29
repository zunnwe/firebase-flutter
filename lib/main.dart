import 'package:comics_app/screen/login.dart';

import 'package:comics_app/utils/userData_notifier.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
//import 'package:comics_app/utils/auth_notifier.dart';
import 'package:comics_app/screen/home.dart';
import 'package:comics_app/models/user.dart';
import 'package:comics_app/repository/auth.dart';
import 'package:comics_app/screen/wrapper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MultiProvider(
        providers: [
          StreamProvider<Users>.value(value: AuthService().user),
          ChangeNotifierProvider(
            create: (context)=> UserDataNotifier(),
          )
        ],
        child: MyApp(),
        ),
      );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

      return MaterialApp(
        title: 'Story app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.blue
        ),
        home: Wrapper()
      );

  }

}