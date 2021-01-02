
import 'package:comics_app/models/user.dart';
import 'package:comics_app/screens/discover.dart';
import 'package:comics_app/screens/login.dart';
import 'package:comics_app/screens/registration.dart';
import 'package:comics_app/screens/wrapper.dart';
import 'package:comics_app/services/auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Flutter Demo',
  //     theme: ThemeData(
  //       primarySwatch: Colors.blue,
  //     ),
  //       routes: <String, WidgetBuilder>{
  //         '/register' : (BuildContext context)=> new RegistrationScreen(),
  //         '/signIn' : (BuildContext context)=> new LoginScreen(),
  //         '/discover' : (BuildContext context)=> new DiscoverScreen(),
  //       },
  //     home: LoginScreen()
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

