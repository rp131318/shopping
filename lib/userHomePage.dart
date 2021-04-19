import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'globalVariable.dart' as global;

class userHomePage extends StatefulWidget {
  @override
  _userHomePageState createState() => _userHomePageState();
}

class _userHomePageState extends State<userHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final searchController = TextEditingController();
  var foodName = ["Burger", "Pizza", "Snacks", "Chinese"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 33, left: 14, right: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Deliver to",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 20,
                            color: global.colorDark,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "394221, Surat",
                            style: TextStyle(
                                fontSize: 20,
                                color: global.colorBlack2,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(55)),
                    child: Image.network(
                      _auth.currentUser.photoURL,
                      width: 36,
                      height: 36,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    height: 46,
                    decoration: BoxDecoration(
                        color: Color(0xfff3f3f3),
                        // border: Border.all(color: global.colorBlack3, width: 2),
                        borderRadius: BorderRadius.circular(8)),
                    margin: EdgeInsets.only(left: 14, right: 8, top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 6),
                          child: Icon(
                            Icons.search_rounded,
                            size: 22,
                            color: Colors.grey,
                          ),
                        ),
                        Flexible(
                          child: TextField(
                            style: TextStyle(
                                color: global.colorBlack2, fontSize: 18),
                            controller: searchController,
                            textAlign: TextAlign.left,
                            cursorColor: global.colorBlack2,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search restaurants or foods",
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 46,
                    decoration: BoxDecoration(
                        color: global.colorDark,
                        // border: Border.all(color: global.colorBlack3, width: 2),
                        borderRadius: BorderRadius.circular(8)),
                    child: Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.only(top: 30, left: 8, right: 14),
                  ),
                ),
              ],
            ),
            Card(
                margin: EdgeInsets.only(top: 22, left: 14, right: 14),
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Image.asset(
                  "images/foodim.jpg",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 144,
                )),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 14, right: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: global.colorBlack2),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: global.colorDark),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 142,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: foodName.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 124,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 0,
                          color: global.colorLight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.emoji_food_beverage_rounded,
                                  size: 66,
                                  color: global.colorDark,
                                ),
                                Text(
                                  foodName[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: global.colorBlack2),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 14, right: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: global.colorBlack2),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: global.colorDark),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 244,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: foodName.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 222,
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 2,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "images/foodim.jpg",
                                height: 133,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, left: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      foodName[index],
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: global.colorBlack2,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "2 Km",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: 36,
                                  width: 66,
                                  decoration: BoxDecoration(
                                      color: global.colorDark,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10))),
                                  margin: EdgeInsets.only(left: 14, top: 8),
                                  child: Center(
                                    child: Text(
                                      '\u{20B9} 195',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
