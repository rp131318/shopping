import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/authProfile/auth.dart';
import 'package:shopping/authProfile/login.dart';
import 'package:shopping/globalVariable.dart';
import 'package:shopping/globalVariable.dart' as global;
import '../authProfile/completeProfile.dart';

class settingPage extends StatefulWidget {
  @override
  _settingPageState createState() => _settingPageState();
}

class _settingPageState extends State<settingPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String add = "--",
      food = "--",
      phone = "--",
      city = "--",
      state = "--",
      dob = "--",
      fav = "--",
      gender = "--";
  bool merchant = false;
  String userString = "User";
  @override
  void initState() {
    // TODO: implement initState
    getData();
    checkMerchant();
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
                height: 55,
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
              Visibility(
                visible: merchant,
                child: Text(
                  "Merchant Account",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 55,
              ),
              Flexible(
                child: ListView(
                  children: [
                    buildProfileText("Email", _auth.currentUser.email),
                    buildDivider(),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 0, left: 22, right: 22),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(
                                "Phone",
                                textAlign: TextAlign.left,
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
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
                                          fontSize: 16,
                                          color: global.colorBlack2),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    buildDivider(),
                    buildProfileText("Address", add),
                    buildDivider(),
                    Visibility(
                      visible: merchant,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 0, left: 22, right: 22),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: Text(
                                  "Food Category",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
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
                    ),
                    Visibility(
                      visible: merchant,
                      child: buildDivider(),
                    ),
                    buildProfileText("City", city),
                    buildDivider(),
                    buildProfileText("State", state),
                    buildDivider(),
                    buildProfileText("DOB", dob),
                    buildDivider(),
                    buildProfileText("Fav. Food", fav),
                    buildDivider(),
                    buildProfileText("Gender", gender),
                    buildDivider(),
                    Card(
                      margin: EdgeInsets.only(left: 22, right: 22, top: 22),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: global.colorBlack1),
                        child: Center(
                          child: InkWell(
                            onTap: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => completeProfile()));
                            },
                            child: Text(
                              "Edit Profile",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.only(
                          left: 22, right: 22, top: 8, bottom: 33),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: colorBlack1, width: 2),
                        ),
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
                                  TextStyle(fontSize: 20, color: colorBlack1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Padding buildProfileText(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 22, right: 22),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              )),
          Expanded(
              flex: 7,
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 16, color: global.colorBlack2),
              )),
        ],
      ),
    );
  }

  Divider buildDivider() {
    return Divider(
      indent: 22,
      endIndent: 22,
      height: 44,
      thickness: 2,
    );
  }

  Future<void> checkMerchant() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    merchant = prefs.getBool('merchant');
    print("merchant :: $merchant");
    setState(() {});
  }

  void getData() {
    FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(_auth.currentUser.uid)
        .once()
        .then((DataSnapshot snap) {
      Map<dynamic, dynamic> values = snap.value;
      add = values["address1"].toString() +
          " " +
          values["address2"].toString() +
          " " +
          values["pincode"].toString();
      food = values["food"].toString();
      phone = values["phone"].toString();
      city = values["city"].toString();
      dob = values["dob"].toString();
      fav = values["fav"].toString();
      state = values["state"].toString();
      gender = values["gender"].toString();
      setState(() {
        print(food);
      });
    });
  }
}
