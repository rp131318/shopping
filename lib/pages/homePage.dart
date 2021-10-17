import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/authProfile/completeAllDetails.dart';
import 'package:shopping/authProfile/completeProfile.dart';
import 'package:shopping/globalVariable.dart';
import 'package:shopping/pages/settingPage.dart';
import 'package:shopping/pages/storeListing.dart';
import 'package:http/http.dart' as http;
import 'listedFoods.dart';
import 'orderManagement.dart';

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool profileCon = false;

  String shopId;

  @override
  void initState() {
    checkProfileCon();
    // String name = global.appCurrentUser("name").toString();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ));
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 166,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(22),
                      bottomRight: Radius.circular(22)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[colorDark, colorDark],
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
                          },
                        )
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
                          color: colorLight),
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Text(
                      "Store Management",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: colorDark),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 6, right: 6),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: new BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if (profileCon) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => storeListing()));
                              } else {
                                showSnackbarWithButton();
                              }
                            },
                            child: buildCard(
                                "Store Listing", ImageLink.storeListingImage),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => listedFoods()));
                            },
                            child: buildCard(
                                "Listed Food", ImageLink.listedFoodImage),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => orderManagement()));
                            },
                            child: buildCard("Order Management",
                                ImageLink.orderManagementImage),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18, top: 18),
                    child: Text(
                      "Finance & Revenue",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: colorDark),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 6, right: 6),
                    child: SingleChildScrollView(
                      physics: new BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: buildCard(
                                "Daily Revenue", ImageLink.dailyRevenueImage),
                          ),
                          InkWell(
                            onTap: () {},
                            child: buildCard(
                                "GST Compliance", ImageLink.gstComplianceImage),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18, top: 18),
                    child: Text(
                      "Doc. Management",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: colorDark),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 6, right: 6),
                    child: SingleChildScrollView(
                      physics: new BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: buildCard("Merchant Agreement",
                                ImageLink.merchantAgreementImage),
                          ),
                          InkWell(
                            onTap: () {},
                            child: buildCard("Discount Offer Scheme",
                                ImageLink.discountOfferSchemeImage),
                          ),
                          InkWell(
                            onTap: () {},
                            child: buildCard("Holiday Management",
                                ImageLink.holidayManagementImage),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 6, left: 6, right: 6),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: SizedBox(
                  //           height: 200,
                  //           child: InkWell(
                  //             onTap: () {
                  //               global.showSnackbar(context,
                  //                   "Feature comming soon", Colors.grey);
                  //             },
                  //             child: Card(
                  //                 semanticContainer: true,
                  //                 clipBehavior: Clip.antiAliasWithSaveLayer,
                  //                 shape: RoundedRectangleBorder(
                  //                     borderRadius:
                  //                         BorderRadius.circular(15.0)),
                  //                 elevation: 4,
                  //                 child: Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.center,
                  //                   children: [
                  //                     Image.asset(
                  //                       "images/dailyr.jpg",
                  //                       height: 140,
                  //                       width: 140,
                  //                       fit: BoxFit.fill,
                  //                     ),
                  //                     Padding(
                  //                       padding:
                  //                           const EdgeInsets.only(bottom: 8),
                  //                       child: Text(
                  //                         "Daily Revenue Report",
                  //                         textAlign: TextAlign.center,
                  //                         style: TextStyle(
                  //                             fontSize: 18,
                  //                             fontWeight: FontWeight.bold,
                  //                             color: global.colorBlack1),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 )),
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: SizedBox(
                  //           height: 200,
                  //           child: InkWell(
                  //             onTap: () {
                  //               global.showSnackbar(context,
                  //                   "Feature comming soon", Colors.grey);
                  //             },
                  //             child: Card(
                  //                 semanticContainer: true,
                  //                 clipBehavior: Clip.antiAliasWithSaveLayer,
                  //                 shape: RoundedRectangleBorder(
                  //                     borderRadius:
                  //                         BorderRadius.circular(15.0)),
                  //                 elevation: 4,
                  //                 child: Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.center,
                  //                   children: [
                  //                     Image.asset(
                  //                       "images/dis.jpeg",
                  //                       height: 140,
                  //                       width: 140,
                  //                       fit: BoxFit.fill,
                  //                     ),
                  //                     Padding(
                  //                       padding:
                  //                           const EdgeInsets.only(bottom: 8),
                  //                       child: Text(
                  //                         "Discount Offer Scheme",
                  //                         textAlign: TextAlign.center,
                  //                         style: TextStyle(
                  //                             fontSize: 18,
                  //                             fontWeight: FontWeight.bold,
                  //                             color: global.colorBlack1),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 )),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 6, left: 6, right: 6),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: SizedBox(
                  //           height: 200,
                  //           child: InkWell(
                  //             onTap: () {
                  //               global.showSnackbar(context,
                  //                   "Feature comming soon", Colors.grey);
                  //             },
                  //             child: Card(
                  //                 semanticContainer: true,
                  //                 clipBehavior: Clip.antiAliasWithSaveLayer,
                  //                 shape: RoundedRectangleBorder(
                  //                     borderRadius:
                  //                         BorderRadius.circular(15.0)),
                  //                 elevation: 4,
                  //                 child: Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.center,
                  //                   children: [
                  //                     Image.asset(
                  //                       "images/gst.jpg",
                  //                       height: 140,
                  //                       width: 140,
                  //                       fit: BoxFit.fill,
                  //                     ),
                  //                     Padding(
                  //                       padding:
                  //                           const EdgeInsets.only(bottom: 8),
                  //                       child: Text(
                  //                         "GST Compliance",
                  //                         textAlign: TextAlign.center,
                  //                         style: TextStyle(
                  //                             fontSize: 18,
                  //                             fontWeight: FontWeight.bold,
                  //                             color: global.colorBlack1),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 )),
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: SizedBox(
                  //           height: 200,
                  //           child: InkWell(
                  //             onTap: () {
                  //               global.showSnackbar(context,
                  //                   "Feature coming soon", Colors.grey);
                  //             },
                  //             child: Card(
                  //                 semanticContainer: true,
                  //                 clipBehavior: Clip.antiAliasWithSaveLayer,
                  //                 shape: RoundedRectangleBorder(
                  //                     borderRadius:
                  //                         BorderRadius.circular(15.0)),
                  //                 elevation: 4,
                  //                 child: Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.center,
                  //                   children: [
                  //                     Image.asset(
                  //                       "images/agrement.jpg",
                  //                       height: 140,
                  //                       width: 140,
                  //                       fit: BoxFit.fill,
                  //                     ),
                  //                     Padding(
                  //                       padding:
                  //                           const EdgeInsets.only(bottom: 8),
                  //                       child: Text(
                  //                         "Merchant Agreement ",
                  //                         textAlign: TextAlign.center,
                  //                         style: TextStyle(
                  //                             fontSize: 18,
                  //                             fontWeight: FontWeight.bold,
                  //                             color: global.colorBlack1),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 )),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       top: 6, left: 6, right: 6, bottom: 22),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: SizedBox(
                  //           height: 200,
                  //           child: InkWell(
                  //             onTap: () {
                  //               global.showSnackbar(context,
                  //                   "Feature comming soon", Colors.grey);
                  //             },
                  //             child: Card(
                  //                 semanticContainer: true,
                  //                 clipBehavior: Clip.antiAliasWithSaveLayer,
                  //                 shape: RoundedRectangleBorder(
                  //                     borderRadius:
                  //                         BorderRadius.circular(15.0)),
                  //                 elevation: 4,
                  //                 child: Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.center,
                  //                   children: [
                  //                     Image.asset(
                  //                       "images/holiday.png",
                  //                       height: 140,
                  //                       width: 140,
                  //                       fit: BoxFit.fill,
                  //                     ),
                  //                     Padding(
                  //                       padding:
                  //                           const EdgeInsets.only(bottom: 8),
                  //                       child: Text(
                  //                         "Holiday Management",
                  //                         textAlign: TextAlign.center,
                  //                         style: TextStyle(
                  //                             fontSize: 18,
                  //                             fontWeight: FontWeight.bold,
                  //                             color: global.colorBlack1),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 )),
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: SizedBox(
                  //           height: 200,
                  //           child: InkWell(
                  //             onTap: () {
                  //               global.showSnackbar(context,
                  //                   "Feature comming soon", Colors.grey);
                  //             },
                  //             child: Card(
                  //                 semanticContainer: true,
                  //                 clipBehavior: Clip.antiAliasWithSaveLayer,
                  //                 shape: RoundedRectangleBorder(
                  //                     borderRadius:
                  //                         BorderRadius.circular(15.0)),
                  //                 elevation: 4,
                  //                 child: Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.center,
                  //                   children: [
                  //                     Image.asset(
                  //                       "images/feedback.jpg",
                  //                       height: 140,
                  //                       width: 140,
                  //                       fit: BoxFit.fill,
                  //                     ),
                  //                     Padding(
                  //                       padding:
                  //                           const EdgeInsets.only(bottom: 8),
                  //                       child: Text(
                  //                         "Suggestion Box",
                  //                         textAlign: TextAlign.center,
                  //                         style: TextStyle(
                  //                             fontSize: 18,
                  //                             fontWeight: FontWeight.bold,
                  //                             color: global.colorBlack1),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 )),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card buildCard(String name, String imageLink) {
    return Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.all(10),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 188,
              width: 156,
              child: Stack(
                children: <Widget>[
                  Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageLink),
                    height: MediaQuery.of(context).size.width * 0.8,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.width * 0.8,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xCC000000),
                          const Color(0x99000000),
                          const Color(0x00000000),
                          const Color(0x00000000),
                          const Color(0x00000000),
                        ],
                      ),
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      name,
                      style: TextStyle(
                          fontSize: 16,
                          color: white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            // Stack(
            //   alignment: Alignment.center,
            //   children: [
            //     Container(
            //       height: 188,
            //       width: 156,
            //       decoration: new BoxDecoration(
            //         image: new DecorationImage(
            //           image: new NetworkImage(imageLink, scale: 1),
            //           fit: BoxFit.cover,
            //         ),
            //       ),
            //       child: new BackdropFilter(
            //         filter: new ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
            //         child: new Container(
            //           decoration: new BoxDecoration(
            //               color: Colors.white.withOpacity(0.0)),
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       height: 188,
            //       width: 156,
            //       child: Center(
            //         child: Padding(
            //           padding: const EdgeInsets.only(left: 8, right: 8),
            //           child: Text(
            //             name,
            //             textAlign: TextAlign.center,
            //             style: TextStyle(
            //                 fontSize: 24,
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.bold),
            //           ),
            //         ),
            //       ),
            //     )
            //   ],
            // ),
          ],
        ));
  }

  Future<void> checkProfileCon() async {
    print("Email :: ${_auth.currentUser.email}");

    http
        .get(Config.mainUrl +
            Config.profileCompletedUrl +
            "?email=" +
            _auth.currentUser.email)
        .then((value) {
      print("User Condition  :: ${value.body}");
      shopId = value.body;
      global_shop_id = shopId;
      if ((value.body != "0") && (value.body != "No results")) {
        profileCon = true;
        http
            .get(Config.mainUrl + Config.getCat + "?shopid=" + shopId)
            .then((value) async {
          print("category ID  :: ${value.body}");
          global_cat_id = value.body.toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('cat_id', value.body);
          await prefs.setString('shop_id', shopId);
        });
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
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => completeAllDetails()));
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
