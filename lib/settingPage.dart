import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'auth.dart';
import 'globalVariable.dart' as global;
import 'login.dart';

class settingPage extends StatefulWidget {
  @override
  _settingPageState createState() => _settingPageState();
}

class _settingPageState extends State<settingPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String add = "--", food = "--", phone = "--";

  @override
  void initState() {
    // TODO: implement initState
    getData();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      body: Stack(
        children: [
          const SizedBox(
            width: double.infinity,
            height: 244,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[global.colorBlack1, global.colorBlack1],
              )),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 66,
              ),
              Center(
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: Image.network(
                    _auth.currentUser.photoURL,
                    width: 88,
                    height: 88,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                _auth.currentUser.displayName,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 66, left: 22, right: 22),
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Text(
                          "Email",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        )),
                    Expanded(
                        flex: 7,
                        child: Text(
                          "rp131318@gmail.com",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 16, color: global.colorBlack2),
                        )),
                  ],
                ),
              ),
              Divider(
                indent: 22,
                endIndent: 22,
                height: 44,
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 22, right: 22),
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Text(
                          "Phone",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        )),
                    Expanded(
                        flex: 7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              "images/flag.png",
                              height: 22,
                              width: 26,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Text(
                                "+91 " + phone,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 16, color: global.colorBlack2),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              Divider(
                indent: 22,
                endIndent: 22,
                height: 44,
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 22, right: 22),
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Text(
                          "Address",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        )),
                    Expanded(
                        flex: 7,
                        child: Text(
                          add,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 16, color: global.colorBlack2),
                        )),
                  ],
                ),
              ),
              Divider(
                indent: 22,
                endIndent: 22,
                height: 44,
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 22, right: 22),
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Text(
                          "Food Category",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        )),
                    Expanded(
                        flex: 7,
                        child: Text(
                          food,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 16, color: global.colorBlack2),
                        )),
                  ],
                ),
              ),
              Divider(
                indent: 22,
                endIndent: 22,
                height: 44,
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, right: 55, left: 55),
                child: Container(
                  height: 55,
                  width: 300,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 6,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: global.colorBlack1),
                        child: Center(
                          child: InkWell(
                            onTap: () async {
                              await FirebaseAuth.instance.signOut();
                              signOutGoogle();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                            },
                            child: Text(
                              "Logout",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void getData() {
    FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(_auth.currentUser.uid)
        .once()
        .then((DataSnapshot snap) {
      Map<dynamic, dynamic> values = snap.value;
      add = values["address"].toString();
      food = values["food"].toString();
      phone = values["phone"].toString();
      setState(() {
        print(food);
      });
    });
  }
}
