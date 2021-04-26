import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'globalVariable.dart' as global;

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

  @override
  void initState() {
    // TODO: implement initState
    getListedFood();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      body: Column(
        children: [
          Hero(
              tag: "lsFood",
              child: Image.asset(
                "images/food.jpg",
                height: 200,
              )),
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Listed Foods",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: global.colorDark),
              ),
            ),
          ),
          Flexible(
              child: p.length > 0 && product.length > 0
                  ? ListView.builder(
                      itemCount: product.length,
                      itemBuilder: (context, index) {
                        return Card(
                          // color: global.colorBlack2,
                          margin: EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.0),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text(
                                n[index],
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: global.colorDark),
                              ),
                              trailing: IconButton(
                                tooltip: "Change Food Details",
                                onPressed: () {},
                                icon: Icon(
                                  Icons.edit,
                                  size: 28,
                                  color: global.colorDark,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(c[index],
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: global.colorBlack3)),
                                  Text(l[index],
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: global.colorBlack3)),
                                  Text(e[index],
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: global.colorBlack3)),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    p[index] + " INR",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: global.colorBlack2),
                                  ),
                                ],
                              ),
                              leading: Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: Image.network(
                                  im[index],
                                  width: 66,
                                  height: 66,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        );
                      })
                  : Center(child: CircularProgressIndicator()))
        ],
      ),
    );
  }

  Future<void> getListedFood() async {
    product.clear();
    c.clear();
    e.clear();
    im.clear();
    l.clear();
    n.clear();
    p.clear();
    await FirebaseDatabase.instance
        .reference()
        .child("Listed Food")
        .child(_auth.currentUser.uid)
        .once()
        .then((DataSnapshot snap) {
      Map<dynamic, dynamic> values = snap.value;
      values.forEach((key, value) async {
        product.add(key);
      });
      print("Product :: $product");
      getProductDetails();
    });
  }

  Future<void> getProductDetails() async {
    for (int i = 0; i < product.length; i++) {
      await FirebaseDatabase.instance
          .reference()
          .child("Listed Food")
          .child(_auth.currentUser.uid)
          .child(product[i].toString())
          .once()
          .then((DataSnapshot snap) {
        Map<dynamic, dynamic> values = snap.value;
        c.add(values["c"].toString());
        e.add(values["e"].toString());
        im.add(values["i"].toString());
        l.add(values["l"].toString());
        n.add(values["n"].toString());
        p.add(values["p"].toString());
        // print(c);
      });
      if (i == product.length - 1) {
        setState(() {
          print("C :: $c");
          print("E :: $e");
          print("I :: $im");
          print("L :: $l");
          print("N :: $n");
          print("P :: $p");
        });
      }
    }
  }
}
