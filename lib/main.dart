import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/authProfile/completeProfile.dart';
import 'authProfile/completeAllDetails.dart';
import 'authProfile/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // ignore: invalid_use_of_visible_for_testing_member
  SharedPreferences.setMockInitialValues({});
  await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // MediaQuery.of(context).platformBrightness == Brightness.light? FlutterStatusbarcolor.setStatusBarColor(Colors.indigo[800]):
    // FlutterStatusbarcolor.setStatusBarColor(Colors.black);
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: completeProfile(),
      // home: completeAllDetails(),
      home: LoginPage(),
    );
  }
}
