import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
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
      shopName = "--",
      gender = "--";
  SharedPreferences prefs;

  bool merchant = false;
  String userString = "User";

  @override
  void initState() {
    // setPickupLocation();
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
          Container(
            width: double.infinity,
            height: 188,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(22),
                  bottomRight: Radius.circular(22)),
              color: colorDark,
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 33,
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
                    width: 66,
                    height: 66,
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
              Text(
                "Merchant Account",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 33,
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
                            ),
                          ),
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
                                      _auth.currentUser.phoneNumber ?? "NA",
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
                    buildProfileText("Shop Name", shopName),
                    buildDivider(),
                    buildProfileText("Address", add),
                    buildDivider(),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 0, left: 22, right: 22),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(
                                "Food Category",
                                textAlign: TextAlign.left,
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              )),
                          Expanded(
                            flex: 7,
                            child: Text(
                              food,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 16, color: global.colorBlack2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    buildDivider(),
                    buildProfileText("City", city),
                    buildDivider(),
                    buildProfileText("State", state),
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
                            color: global.colorDark),
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
                          border: Border.all(color: colorDark, width: 2),
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
                              style: TextStyle(fontSize: 20, color: colorDark),
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
    print("shop Id :: $global_shop_id");
    get(Config.mainUrl +
            Config.getMerchantDetails +
            "?shop_id=" +
            global_shop_id)
        .then((value) {
      print("Value :: ${value.body}");
      final data = jsonDecode(value.body.toString());
      print("Data :: $data");

      Map<String, dynamic> map = data[0] as Map<String, dynamic>;

      add = map['address'].toString() +
          ", " +
          map['area'].toString() +
          ", " +
          map['pincode'].toString();
      shopName = map['name'].toString();
      state = map['state'].toString();
      city = map['city'].toString();
      gender = map['gender'].toString();
      food = map['category'].toString();
      setState(() {
        print("Map :: $map");
        print("city :: $city");
      });
    });
  }

  // Future<void> setPickupLocation() async {
  //   DateTime time = DateTime.now();
  //   String phoneNumber =
  //       _auth.currentUser.phoneNumber.toString().substring(3, 13);
  //   String pin = add.toString().split(",")[2].toString().trim();
  //   print("phoneNumber :: $phoneNumber");
  //   // final token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjE5NjQ2NDksIml"
  //   //     "zcyI6Imh0dHBzOi8vYXBpdjIuc2hpcHJvY2tldC5pbi92MS9leHRlcm5hbC9hdXRoL2xvZ"
  //   //     "2luIiwiaWF0IjoxNjM0MDU3MTY2LCJleHAiOjE2MzQ5MjExNjYsIm5iZiI6MTYzNDA1NzE"
  //   //     "2NiwianRpIjoiZkpEYTdtM2FvNTJ0SndYQyJ9.6f6sfSOZl4oCaSwB1-HEZ3aABuQCTPi"
  //   //     "zRjk1Aarqj3Q";
  //   prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');
  //   final header = {
  //     "Content-Type": "application/json",
  //     "Authorization": "Bearer $token",
  //   };
  //   final body = {
  //     "pickup_location": "Office",
  //     "name": "${_auth.currentUser.displayName}",
  //     "email": "${_auth.currentUser.email}",
  //     "phone": phoneNumber,
  //     "address": add,
  //     "address_2": "",
  //     "city": city,
  //     "state": state,
  //     "country": "India",
  //     "pin_code": pin,
  //   };
  //   post(Config.setPickupLocation, body: jsonEncode(body), headers: header)
  //       .then((value) {
  //     print("Pickup :: ${value.body}");
  //   });
  // }
}
