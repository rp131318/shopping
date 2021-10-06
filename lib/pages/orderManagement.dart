import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/widget/progressHud.dart';
import '../globalVariable.dart';
import 'orderDetails.dart';

class orderManagement extends StatefulWidget {
  @override
  _orderManagementState createState() => _orderManagementState();
}

class _orderManagementState extends State<orderManagement> {
  var userId = [];
  var productId = [];
  var qnt = [];
  var paymentMethod = [];
  var qntPrice = [];
  var productName = [];
  var productMeas = [];
  var productCat = [];
  var productPrice = [];
  var productImage = [];
  var productGst = [];
  var productCode = [];
  var productDes = [];

  var userName = [];
  var userNumber = [];
  var userEmail = [];
  var userAddress = [];
  var userPincode = [];
  var userCity = [];
  var userState = [];
  var userGender = [];
  var userOrderDate = [];

  @override
  void initState() {
    // TODO: implement initState
    getOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(22),
                    bottomRight: Radius.circular(22)),
                color: colorDark,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18, top: 46),
                      child: Text(
                        "Your Active Orders",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Text(
                        "The order details available bellow.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                ],
              ),
            ),
            productImage.length > 0
                ? SizedBox(
                    height: 166 * productImage.length.toDouble(),
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: productImage.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => orderDetails()));
                            },
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              margin: EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                  top: 14,
                                  bottom: index == 4 ? 22 : 0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 25,
                                      child: Card(
                                        semanticContainer: true,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Image.network(
                                          productImage[index],
                                          width: 88,
                                          height: 88,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Column(
                                          // mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              productName[index],
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: colorDark),
                                            ),
                                            Text(
                                              productPrice[index] +
                                                  rupees +
                                                  "/" +
                                                  productMeas[index],
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.account_circle_rounded,
                                                  color: colorDark,
                                                  size: 16,
                                                ),
                                                Text(
                                                  userName[index],
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on_rounded,
                                                  color: colorDark,
                                                  size: 16,
                                                ),
                                                Text(
                                                  userCity[index].toString() +
                                                      "," +
                                                      userPincode[index]
                                                          .toString(),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.payment,
                                                  color: colorDark,
                                                  size: 16,
                                                ),
                                                Text(
                                                  paymentMethod[index]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 33),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              // Icon(
                                              //   Icons.indeterminate_check_box_rounded,
                                              //   size: 30,
                                              //   color: Colors.grey,
                                              // ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 4),
                                                child: Text(
                                                  qnt[index].toString(),
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: colorDark,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              // GestureDetector(
                                              //   onTap: () {},
                                              //   child: Icon(
                                              //     Icons
                                              //         .indeterminate_check_box_rounded,
                                              //     size: 30,
                                              //     color: Colors.red,
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                          Text(
                                            qntPrice[index] + rupees,
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 166),
                    child: Column(
                      children: [
                        Image.network(
                          "https://cdn-icons-png.flaticon.com/512/2345/2345152.png",
                          width: 100,
                          height: 100,
                          color: colorDark,
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Text(
                          "There is no active orders available.",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  )
            // ...............................
            // SizedBox(
            //   height: 700,
            //   child: GridView.count(
            //       primary: false,
            //       shrinkWrap: true,
            //       crossAxisCount: 2,
            //       childAspectRatio: 0.85,
            //       children: List.generate(5, (index) {
            //         return GestureDetector(
            //           onTap: () {
            //             // Navigator.of(context).push(MaterialPageRoute(
            //             //     builder: (context) => foodDetailPage()));
            //           },
            //           child: Padding(
            //             padding: const EdgeInsets.all(4.0),
            //             child: Card(
            //               semanticContainer: true,
            //               clipBehavior: Clip.antiAliasWithSaveLayer,
            //               shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(12),
            //               ),
            //               elevation: 3,
            //               // color: colorCard,
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Padding(
            //                     padding:
            //                         const EdgeInsets.only(top: 0, bottom: 12),
            //                     child: Card(
            //                       margin: EdgeInsets.zero,
            //                       semanticContainer: true,
            //                       clipBehavior: Clip.antiAliasWithSaveLayer,
            //                       elevation: 0,
            //                       shape: RoundedRectangleBorder(
            //                           borderRadius: BorderRadius.circular(12)),
            //                       child: Image.network(
            //                         "https://t3.ftcdn.net/jpg/02/28/08/82/360_F_228088258_9q1Ili4fd6d4KwkFB5YvgiYxOienp1qo.jpg",
            //                         height: 111,
            //                         width: double.infinity,
            //                         fit: BoxFit.fill,
            //                       ),
            //                     ),
            //                     // child: Image.network(
            //                     //   ImageLink.storeListingImage,
            //                     //   height: 111,
            //                     //   width: 100,
            //                     //   fit: BoxFit.fill,
            //                     // ),
            //                   ),
            //                   Padding(
            //                     padding: const EdgeInsets.only(
            //                         left: 8, right: 8, bottom: 4),
            //                     child: Text(
            //                       "Kaju Katri",
            //                       maxLines: 1,
            //                       style: TextStyle(
            //                           fontSize: 20,
            //                           color: colorDark,
            //                           fontWeight: FontWeight.bold),
            //                     ),
            //                   ),
            //                   Padding(
            //                     padding:
            //                         const EdgeInsets.only(left: 8, right: 8),
            //                     child: Text(
            //                       "5 KG",
            //                       style: TextStyle(
            //                           fontSize: 18,
            //                           fontWeight: FontWeight.bold),
            //                     ),
            //                   )
            //                 ],
            //               ),
            //             ),
            //           ),
            //         );
            //       })),
            // )
          ],
        ),
      ),
    );
  }

  Widget buildProfileText(String title, String value) {
    return Row(
      children: [
        Expanded(
            flex: 5,
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
        SizedBox(
          width: 6,
        ),
        Expanded(
            flex: 5,
            child: Text(
              value,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18),
            )),
      ],
    );
  }

  Future<void> getOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String shopId = prefs.getString('shop_id');
    print("shopId :: $shopId");
    get(Config.mainUrl + Config.getActiveOrder + "?shop_id=$shopId")
        .then((value) {
      print(value.body);
      final data = jsonDecode(value.body.toString());
      int dd = getJsonLength(data);
      print("DD :: $dd");
      for (int i = 0; i < dd; i++) {
        Map<String, dynamic> map = data[i] as Map<String, dynamic>;
        print("Map :: $map");
        productId.add(map["product_id"].toString());
        qnt.add(map["amount"].toString());
        qntPrice.add(map["price"].toString());
        paymentMethod.add(map["payment_method"].toString());
        getUserDetailsByUserId(map["user_id"].toString());
        getProductDetailsById(map["product_id"].toString());
        // productPrice.add(map["price"].toString());
        // productImage.add(map["product_image"].toString());
        // productId.add(map["id"].toString());
        // productMeas.add(map["measurement"].toString());
        // productGst.add(map["gst_percent"].toString());
        // productCode.add(map["sac_code"].toString());
        // productDes.add(map["product_desc"].toString());
        // productCat.add(map["pr_category"].toString());
        // productQnt.add(map["quantity"].toString());
        // productQntPrice.add(map["quantity_price"].toString());
        // productShopId.add(map["shop_id"].toString());
        if (i == dd - 1) {
          setState(() {
            // print("productName :: $productName");
          });
        }
      }
    });
  }

  void getUserDetailsByUserId(String userId) {
    get(Config.mainUrl + Config.getUserDetails + "?uid=$userId").then((value) {
      print("User Response :: ${value.body}");
      final data = jsonDecode(value.body.toString());
      int dd = getJsonLength(data);
      print("DD :: $dd");
      for (int i = 0; i < dd; i++) {
        Map<String, dynamic> map = data[i] as Map<String, dynamic>;
        print("Map :: $map");
        userName.add(map["name"].toString());
        userNumber.add(map["number"].toString());
        userEmail.add(map["email"].toString());
        userAddress.add(map["address"].toString());
        userPincode.add(map["pincode"].toString());
        userCity.add(map["city"].toString());
        userState.add(map["state"].toString());
        userGender.add(map["gender"].toString());
        userOrderDate.add(map["date"].toString());
        if (i == dd - 1) {
          setState(() {
            // print("productName :: $productName");
          });
        }
      }
    });
  }

  void getProductDetailsById(String id) {
    get(Config.mainUrl + Config.getProductDetailsById + "?id=$id")
        .then((value) {
      print("Product Response :: ${value.body}");
      final data = jsonDecode(value.body.toString());
      int dd = getJsonLength(data);
      print("DD :: $dd");
      for (int i = 0; i < dd; i++) {
        Map<String, dynamic> map = data[i] as Map<String, dynamic>;
        print("Map :: $map");
        productName.add(map["product_name"].toString());
        productPrice.add(map["price"].toString());
        productImage.add(map["product_image"].toString());
        productId.add(map["id"].toString());
        productMeas.add(map["measurement"].toString());
        productGst.add(map["gst_percent"].toString());
        productCode.add(map["sac_code"].toString());
        productDes.add(map["product_desc"].toString());
        productCat.add(map["pr_category"].toString());
        if (i == dd - 1) {
          setState(() {
            print("productName :: ${productName.length}");
            print("productImage :: ${productImage.length}");
            // print("productName :: $productName");
          });
        }
      }
    });
  }
}
