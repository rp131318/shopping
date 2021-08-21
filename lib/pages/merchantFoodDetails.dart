import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/globalVariable.dart' as global;

import 'listedFoods.dart';

class merchantFoodDetails extends StatefulWidget {
  @override
  _merchantFoodDetailsState createState() => _merchantFoodDetailsState();
}

class _merchantFoodDetailsState extends State<merchantFoodDetails> {
  String name = "--",
      price = "--",
      cat = "--",
      exp = "--",
      image,
      location = "--",
      productKey;
  String changeField = "name";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final locationController = TextEditingController();
  final categoryController = TextEditingController();
  final expiryController = TextEditingController();
  bool dialog = true;
  double popHeight;
  StateSetter _setState;
  String _key, unit;

  var list = ["Name", "Price", "Food Category", "Food Expiry", "Location"];
  var subList = [
    "Change food name",
    "Change food price",
    "Change food category",
    "Change food expiry",
    "Change food location"
  ];

  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      body: location != "--"
          ? Column(
              children: [
                Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(33),
                          bottomLeft: Radius.circular(33))),
                  child: Image.network(
                    image,
                    height: 244,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Flexible(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 28, top: 20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: global.colorBlack5),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 28, top: 8),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '\u{20B9} ' + price + "/" + unit,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: global.colorDark),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ListTile(
                          horizontalTitleGap: 0,
                          title: Text(
                            "Location",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: global.colorBlack5),
                          ),
                          subtitle: Text(
                            location,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          leading: Icon(
                            Icons.location_on_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ListTile(
                          horizontalTitleGap: 0,
                          title: Text(
                            "Food Category",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: global.colorBlack5),
                          ),
                          subtitle: Text(
                            cat,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          leading: Icon(
                            Icons.category_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ListTile(
                          horizontalTitleGap: 0,
                          title: Text(
                            "Food Expiry",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: global.colorBlack5),
                          ),
                          subtitle: Text(
                            exp,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          leading: Icon(
                            Icons.watch_later_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                bottom(),
              ],
            )
          : loading(),
    );
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("foodName");
    price = prefs.getString("foodPrice");
    cat = prefs.getString("foodCategory");
    exp = prefs.getString("foodExp");
    image = prefs.getString("foodImage");
    location = prefs.getString("foodLocation");
    productKey = prefs.getString("foodKey");
    unit = prefs.getString("unit");
    setState(() {
      print(location);
      print("productKey $productKey");
      print(image);
    });
  }

  Widget loading() {
    return Center(
        child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.only(top: 66),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(global.colorDark),
            ),
            SizedBox(
              height: 12,
            ),
            Text("Loading your food details..."),
          ],
        ),
      ),
    ));
  }

  Widget bottom() {
    return Align(
      alignment: Alignment.topRight,
      child: SizedBox(
        height: 66,
        width: double.infinity,
        child: Card(
            color: global.colorDark,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(22))),
            margin: EdgeInsets.only(left: 6, right: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 28, top: 8),
                      child: Text(
                        "Food Status",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 28),
                      child: Row(
                        children: [
                          Text(
                            "Active",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.verified_rounded,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: FlatButton(
                    splashColor: global.colorDark,
                    onPressed: () {
                      _showDialog();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    color: Colors.white,
                    child: Text("Edit Details",
                        style: TextStyle(
                            color: global.colorDark,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            )),
      ),
    );
  }

  void _showDialog() {
    dialog = true;
    popHeight = 300;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            title: Text("Select field you want to change"),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                _setState = setState;
                return setupAlertDialoadContainer();
              },
            ),
          );
        });
  }

  setupAlertDialoadContainer() {
    return Container(
      height: popHeight,
      child: Column(
        children: [
          Visibility(
            visible: dialog,
            child: Flexible(
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      horizontalTitleGap: 0,
                      onTap: () {
                        changeField = list[index].toString();
                        _setState(() {
                          popHeight = 133;
                          dialog = false;
                        });
                      },
                      title: Text(
                        list[index],
                        style:
                            TextStyle(fontSize: 18, color: global.colorBlack5),
                      ),
                      subtitle: Text(
                        subList[index],
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      leading: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.grey,
                      ),
                    );
                  }),
            ),
          ),
          Visibility(
            visible: !dialog,
            child: Column(
              children: [
                Container(
                  height: 46,
                  width: 222,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: global.colorDark, width: 2),
                      borderRadius: BorderRadius.circular(8)),
                  margin:
                      EdgeInsets.only(left: 14, right: 4, top: 8, bottom: 8),
                  child: TextField(
                    style: TextStyle(color: global.colorBlack2, fontSize: 18),
                    controller: nameController,
                    keyboardType: changeField == "Price"
                        ? TextInputType.number
                        : changeField == "Food Expiry"
                            ? TextInputType.datetime
                            : TextInputType.text,
                    textAlign: TextAlign.center,
                    cursorColor: Colors.white,
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        hintText: changeField == "Food Expiry"
                            ? "YYYY-MM-DD"
                            : "Enter $changeField",
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 14, top: 22),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: FlatButton(
                      splashColor: global.colorDark,
                      onPressed: () {
                        if (nameController.text.length > 0) {
                          updateFiled(nameController.text, changeField);
                          nameController.clear();
                          Navigator.pop(context);
                          global.showSnackbar(context,
                              "Data Changed Successfully...", Colors.green);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => listedFoods()),
                              ModalRoute.withName("/Home"));
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      color: global.colorDark,
                      child: Text("Update",
                          style: TextStyle(
                              color: global.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateFiled(String text, String changeField) {
    if (changeField.split(" ").length > 1) {
      _key = changeField.split(" ")[1].substring(0, 1).toLowerCase();
      print("Key11 :: $_key");
    } else {
      _key = changeField.substring(0, 1).toLowerCase();
      print("Key22 :: $_key");
    }

    FirebaseDatabase.instance
        .reference()
        .child("Listed Food")
        .child(_auth.currentUser.uid)
        .child(productKey)
        .child(_key)
        .set(text);
  }
}
