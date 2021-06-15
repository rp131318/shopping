import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping/authProfile/completeProfile.dart';
import 'package:shopping/merchant/listedFoods.dart';
import 'package:shopping/merchant/storeListing.dart';
import 'package:shopping/both/settingPage.dart';
import 'package:shopping/globalVariable.dart' as global;

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool profileCon = false;

  @override
  void initState() {
    checkProfileCon();
    // String name = global.appCurrentUser("name").toString();
  }

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 166,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[global.colorDark, global.colorDark],
              )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 36,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14, right: 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Shopping App",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.settings,
                              size: 28,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => settingPage()));
                            })
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(55)),
                      child: Image.network(
                        _auth.currentUser.photoURL,
                        width: 44,
                        height: 44,
                      ),
                    ),
                    title: Text(
                      _auth.currentUser.displayName.toUpperCase(),
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    subtitle: Text(
                      _auth.currentUser.email.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: global.colorLight),
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12, left: 6, right: 6),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 200,
                            child: InkWell(
                              onTap: () {
                                if (profileCon) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => storeListing()));
                                } else {
                                  showSnackbarWithButton();
                                }
                              },
                              child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  elevation: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Hero(
                                        tag: "stList",
                                        child: Image.asset(
                                          "images/store.jpg",
                                          height: 140,
                                          width: 140,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          "Store Listing",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: global.colorBlack1),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 200,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => listedFoods()));
                              },
                              child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  elevation: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Hero(
                                        tag: "lsFood",
                                        child: Image.asset(
                                          "images/food.jpg",
                                          height: 140,
                                          width: 140,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          "Listed Foods",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: global.colorBlack1),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 6, right: 6),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 200,
                            child: InkWell(
                              onTap: () {
                                global.showSnackbar(context,
                                    "Feature comming soon", Colors.grey);
                              },
                              child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  elevation: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "images/dailyr.jpg",
                                        height: 140,
                                        width: 140,
                                        fit: BoxFit.fill,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          "Daily Revenue Report",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: global.colorBlack1),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 200,
                            child: InkWell(
                              onTap: () {
                                global.showSnackbar(context,
                                    "Feature comming soon", Colors.grey);
                              },
                              child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  elevation: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "images/dis.jpeg",
                                        height: 140,
                                        width: 140,
                                        fit: BoxFit.fill,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          "Discount Offer Scheme",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: global.colorBlack1),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 6, right: 6),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 200,
                            child: InkWell(
                              onTap: () {
                                global.showSnackbar(context,
                                    "Feature comming soon", Colors.grey);
                              },
                              child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  elevation: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "images/gst.jpg",
                                        height: 140,
                                        width: 140,
                                        fit: BoxFit.fill,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          "GST Compliance",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: global.colorBlack1),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 200,
                            child: InkWell(
                              onTap: () {
                                global.showSnackbar(context,
                                    "Feature comming soon", Colors.grey);
                              },
                              child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  elevation: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "images/agrement.jpg",
                                        height: 140,
                                        width: 140,
                                        fit: BoxFit.fill,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          "Merchant Agreement ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: global.colorBlack1),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 6, left: 6, right: 6, bottom: 22),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 200,
                            child: InkWell(
                              onTap: () {
                                global.showSnackbar(context,
                                    "Feature comming soon", Colors.grey);
                              },
                              child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  elevation: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "images/holiday.png",
                                        height: 140,
                                        width: 140,
                                        fit: BoxFit.fill,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          "Holiday Management",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: global.colorBlack1),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 200,
                            child: InkWell(
                              onTap: () {
                                global.showSnackbar(context,
                                    "Feature comming soon", Colors.grey);
                              },
                              child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  elevation: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "images/feedback.jpg",
                                        height: 140,
                                        width: 140,
                                        fit: BoxFit.fill,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          "Suggestion Box",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: global.colorBlack1),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkProfileCon() async {
    final User user = FirebaseAuth.instance.currentUser;
    final uid = user.uid.toString();
    FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(uid)
        .once()
        .then((DataSnapshot snap) {
      if (snap.value["con"].toString() == "1") {
        profileCon = true;
      }
    });
  }

  void showSnackbarWithButton() {
    final snackBar = SnackBar(
      backgroundColor: Colors.deepOrange,
      content: Text("Complete profile to use this feature."),
      action: SnackBarAction(
        label: "Complete Now",
        textColor: Colors.white,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => completeProfile()));
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
