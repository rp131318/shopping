import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/authProfile/phoneAuth.dart';
import 'package:shopping/pages/homePage.dart';
import '../globalVariable.dart';
import 'auth.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:shopping/globalVariable.dart' as global;

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(body: Body()),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  User user;
  var roomImage = [];
  int randomNumber;
  bool loading = false;
  bool userLog = false;
  bool merchant = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  initState() {
    checkUser();
  }

  Future<void> click() async {
    signInWithGoogle().then((user) async => {
          this.user = user,
          await http.post(Config.mainUrl + Config.checkProfileUrl, body: {
            "email": user.email.toString(),
          }).then((value) async {
            await print("exist or not :: ${value.body}");
            if (value.body == "dontexist") {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => phoneAuth()));
            } else {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => homePage()));
            }
          }),
          print(user)
        });
  }

  Widget googleLoginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        height: 55,
        width: 300,
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 6,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: global.colorDark),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Image.asset(
                        "images/google.png",
                        width: 33,
                        height: 33,
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: this.click,
                      child: Text(
                        "Sign in with Google",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Stack(
        children: [
          // const SizedBox(
          //   width: double.infinity,
          //   height: double.infinity,
          //   child: const DecoratedBox(
          //     decoration: BoxDecoration(
          //         gradient: LinearGradient(
          //       begin: Alignment.topLeft,
          //       end: Alignment.bottomRight,
          //       colors: <Color>[global.colorDark1, global.colorDark],
          //     )),
          //   ),
          // ),
          Visibility(
            child: Center(
              child: FlutterLogo(
                size: 166,
              ),
            ),
            visible: !userLog,
          ),
          Visibility(
            visible: userLog,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 55,
                ),

                Image.asset(
                  "images/login.png",
                  height: 288,
                ),
                SizedBox(
                  height: 8,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Good food never fail in bringing people together.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: global.colorBlack1),
                  ),
                ),
                SizedBox(
                  height: 88,
                ),
                // Image.asset('images/google.png', width: 80, height: 70),
                googleLoginButton(),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "By creating an account, you are agreeing to our Terms of Service",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: global.colorBlack1),
                    ),
                  ),
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text("I  am Merchant"),
                //     Checkbox(
                //         value: merchant,
                //         activeColor: global.colorDark,
                //         onChanged: (value) {
                //           setState(() {
                //             merchant = value;
                //           });
                //           print("value :: $value");
                //         }),
                //   ],
                // )

                // Align(
                //   alignment: Alignment.center,
                //   child: Text(
                //     "First we eat. Then we do everything else.",
                //     textAlign: TextAlign.left,
                //     style: TextStyle(
                //         fontSize: 18,
                //         fontWeight: FontWeight.bold,
                //         color: global.colorBlack2),
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> checkUser() async {
    final User user = FirebaseAuth.instance.currentUser;
    Future.delayed(const Duration(milliseconds: 333), () {
      if (user != null) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => homePage()));
      } else {
        setState(() {
          userLog = true;
        });
      }
    });
  }
}
