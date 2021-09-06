import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globalVariable.dart';
import 'merchantFoodDetails.dart';

class listedFoods extends StatefulWidget {
  @override
  _listedFoodsState createState() => _listedFoodsState();
}

class _listedFoodsState extends State<listedFoods> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var product = [];
  var n = [];
  var p = [];
  var l = [];
  var im = [];
  var e = [];
  var c = [];
  var unit = [];
  var gst = [];
  var hsc = [];
  var des = [];

  @override
  void initState() {
    getListedFood();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 44,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Food Listed",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: colorBlack5),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Your delicious listed foods",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
          ),
          gridOfFood(),
          bottom(),
        ],
      ),
    );
  }

  Future<void> getListedFood() async {
    print("Cat Id :: $global_cat_id");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String shop_id = prefs.getString('shop_id');
    get(Config.mainUrl + Config.merchantProductsUrl + "?shop_id=" + shop_id)
        .then((value) {
      // print("Merchant Products :: ${value.body}");

      final data = jsonDecode(value.body.toString());
      // print("Map :: ${data}");

      // var obj = JSON.parse(json);
      // var length = Object.keys(data).length; //you get length json result 4
      // data.then((onValue) {
      //   if (onValue != null) {
      //     onValue.data.forEach((k, v) {
      //       // add .data here
      //       // print(onValue['AED']);
      //       print('$k,$v');
      //     });
      //   }
      // });

      // Map<String, String> map =
      //     jsonDecode(value.body.toString()) as Map<String, String>;
      // print("Map :: $map");
      // int len = 0;
      // try {
      //   while (data[len] != null) {
      //     len++;
      //   }
      //   // print("Len :: $len");
      // } catch (e) {
      //   print("Len Catch :: $len");
      // }

      var dd = getJsonLength(data);
      print("DD :: $dd");

      for (int i = 0; i < dd; i++) {
        Map<String, dynamic> map = data[i] as Map<String, dynamic>;
        print("Map :: $map");
        c.add(map["pr_category"].toString());
        // e.add(map["e"].toString());
        im.add(map["product_image"].toString());
        // l.add(map["l"].toString());
        n.add(map["product_name"].toString());
        p.add(map["price"].toString());
        unit.add(map["measurement"].toString());
        gst.add(map["gst_percent"].toString());
        hsc.add(map["sac_code"].toString());
        product.add(map["id"].toString());
        des.add(map["product_desc"].toString());

        // map.forEach((key, value) {
        //   print("--------------------------------");
        //   print("key :: $key \nValue :: $value");
        //   print("--------------------------------");
        // });
        if (i == dd - 1) {
          setState(() {
            print("C :: $c");
            print("I :: $im");
            print("N :: $n");
            print("P :: $p");
            print("unit :: $unit");
          });
        }
      }
    });
  }

  // Future<void> getProductDetails() async {
  //   for (int i = 0; i < product.length; i++) {
  //     await FirebaseDatabase.instance
  //         .reference()
  //         .child("Listed Food")
  //         .child(_auth.currentUser.uid)
  //         .child(product[i].toString())
  //         .once()
  //         .then((DataSnapshot snap) {
  //       Map<dynamic, dynamic> values = snap.value;
  //       c.add(values["c"].toString());
  //       e.add(values["e"].toString());
  //       im.add(values["i"].toString());
  //       l.add(values["l"].toString());
  //       n.add(values["n"].toString());
  //       p.add(values["p"].toString());
  //       unit.add(values["unit"].toString());
  //       // print(c);
  //     });
  //     if (i == product.length - 1) {
  //       setState(() {
  //         print("C :: $c");
  //         print("E :: $e");
  //         print("I :: $im");
  //         print("L :: $l");
  //         print("N :: $n");
  //         print("P :: $p");
  //         print("unit :: $unit");
  //       });
  //     }
  //   }
  // }

  Widget gridOfFood() {
    return p.length > 0
        ? Flexible(
            child: GridView.count(
                childAspectRatio: 10 / 14,
                crossAxisCount: 2,
                children: List.generate(n.length, (index) {
                  return InkWell(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      // int counter = (prefs.getInt('counter') ?? 0) + 1;
                      // print('Pressed $counter times.');
                      await prefs.setString('foodName', n[index].toString());
                      await prefs.setString('foodPrice', p[index].toString());
                      await prefs.setString(
                          'foodCategory', c[index].toString());
                      // await prefs.setString('foodImage',
                      //     "https://media.self.com/photos/60c24d1e82f971325a0a6ebd/4:3/w_384/bowl-rice-vegetables.jpg");
                      await prefs.setString('foodImage', im[index].toString());
                      await prefs.setString('gst', gst[index]);
                      // await prefs.setString('foodExp', "No Data");
                      await prefs.setString('unit', unit[index].toString());
                      await prefs.setString('hsc', hsc[index].toString());
                      await prefs.setString('id', product[index].toString());
                      await prefs.setString('des', des[index].toString());

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => merchantFoodDetails()));
                    },
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.only(
                          left: 12, right: 12, top: 12, bottom: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 14,
                          ),
                          Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            child: Image.network(
                              im[index],
                              height: 122,
                              width: 122,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                n[index].toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: colorBlack5),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                '\u{20B9} ' +
                                    p[index].toString() +
                                    "/" +
                                    unit[index].toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: colorDark),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })),
          )
        : showLoading("Loading your listed foods...");
  }

  Widget bottom() {
    return p.length > 0
        ? Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              height: 66,
              width: 166,
              child: Card(
                  color: colorDark,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(16),
                          bottomLeft: Radius.circular(28),
                          bottomRight: Radius.circular(22))),
                  margin: EdgeInsets.zero,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Total Items",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        n.length.toString(),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )),
            ),
          )
        : Text(" ");
  }
}
