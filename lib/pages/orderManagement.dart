import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/widget/button_widget.dart';
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
  SharedPreferences prefs;

  var userName = [];
  var userNumber = [];
  var userEmail = [];
  var userAddress = [];
  var userPincode = [];
  var userCity = [];
  var userState = [];
  var userGender = [];
  var userOrderDate = [];
  bool showOrderDetails = false;
  bool isShip = false;
  bool isDeli = false;
  int currentDetails = 0;
  final heightController = TextEditingController();
  final breathController = TextEditingController();
  final lengthController = TextEditingController();
  final weightController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    getOrder();
    generateToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ));
    return WillPopScope(
      onWillPop: () {
        if (showOrderDetails) {
          setState(() {
            showOrderDetails = false;
            // isStore = false;
          });
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        body: userName.length > 0 && productImage.length > 0
            ? SingleChildScrollView(
                child: Stack(
                  children: [
                    Visibility(
                      visible: !showOrderDetails,
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
                                    padding: const EdgeInsets.only(
                                        left: 18, top: 46),
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
                                            setState(() {
                                              currentDetails = index;
                                              showOrderDetails = true;
                                            });
                                            // Navigator.of(context).push(
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             orderDetails()));
                                          },
                                          child: Card(
                                            elevation: 4,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            margin: EdgeInsets.only(
                                                left: 8,
                                                right: 8,
                                                top: 14,
                                                bottom: index == 4 ? 22 : 0),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 25,
                                                    child: Card(
                                                      semanticContainer: true,
                                                      clipBehavior: Clip
                                                          .antiAliasWithSaveLayer,
                                                      elevation: 0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
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
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8),
                                                      child: Column(
                                                        // mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            productName[index],
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    colorDark),
                                                          ),
                                                          Text(
                                                            productPrice[
                                                                    index] +
                                                                rupees +
                                                                "/" +
                                                                productMeas[
                                                                    index],
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .account_circle_rounded,
                                                                color:
                                                                    colorDark,
                                                                size: 16,
                                                              ),
                                                              Text(
                                                                userName[index],
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .location_on_rounded,
                                                                color:
                                                                    colorDark,
                                                                size: 16,
                                                              ),
                                                              Text(
                                                                userCity[index]
                                                                        .toString() +
                                                                    "," +
                                                                    userPincode[
                                                                            index]
                                                                        .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.payment,
                                                                color:
                                                                    colorDark,
                                                                size: 16,
                                                              ),
                                                              Text(
                                                                paymentMethod[
                                                                        index]
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 33),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            // Icon(
                                                            //   Icons.indeterminate_check_box_rounded,
                                                            //   size: 30,
                                                            //   color: Colors.grey,
                                                            // ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right: 4),
                                                              child: Text(
                                                                qnt[index]
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    color:
                                                                        colorDark,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
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
                                                          qntPrice[index] +
                                                              rupees,
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
                    Visibility(
                      visible: showOrderDetails,
                      child: orderDetailsPage(),
                    ),
                  ],
                ),
              )
            : loadingWidget(),
      ),
    );
  }

  Widget buildProfileText1(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Row(
        children: [
          Expanded(
              flex: 5,
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: grey),
              )),
          SizedBox(
            width: 6,
          ),
          Expanded(
              flex: 5,
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 16),
              )),
        ],
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

  Widget orderDetailsPage() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 33, left: 18, bottom: 18),
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              "Active Order",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorBlack5),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 33, left: 18),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Order Details",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorBlack5),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Image.network(
                    "${productImage[currentDetails]}",
                    width: 88,
                    height: 88,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${productName[currentDetails]}",
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: colorBlack5),
                      ),
                      Text(
                        productPrice[currentDetails] +
                            rupees +
                            "/" +
                            productMeas[currentDetails],
                        style: TextStyle(
                          fontSize: 16,
                          color: grey,
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     // Icon(
                      //     //   Icons.location_on_rounded,
                      //     //   color: colorDark,
                      //     //   size: 16,
                      //     // ),
                      //     Text(
                      //       userCity[currentDetails].toString() +
                      //           "," +
                      //           userPincode[currentDetails].toString(),
                      //       style: TextStyle(fontSize: 16, color: grey),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18, left: 18),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Order Status",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorBlack5),
            ),
          ),
        ),
        ListTile(
          title: Text(
            "Shipped",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: colorBlack5),
          ),
          trailing: isShip
              ? Container(
                  margin: EdgeInsets.only(right: 14),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(
                    Icons.done_rounded,
                    size: 22,
                    color: Colors.white,
                  ))
              : ButtonWidget(context, "Pending", productDimensionFunction, true,
                  14, 14, 80, 30, 16),
          minVerticalPadding: 0,
          leading: Icon(
            Icons.arrow_forward_ios_rounded,
            color: colorBlack5,
            size: 18,
          ),
          horizontalTitleGap: 0,
        ),
        ListTile(
          title: Text(
            "Delivered",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: colorBlack5),
          ),
          trailing: isDeli
              ? Container(
                  margin: EdgeInsets.only(right: 14),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100)),
                  child: Text(
                    "Done",
                    style: TextStyle(fontSize: 14, color: white),
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(right: 14),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(100)),
                  child: Text(
                    "Pending",
                    style: TextStyle(fontSize: 14, color: white),
                  ),
                ),
          leading: Icon(
            Icons.arrow_forward_ios_rounded,
            color: colorBlack5,
            size: 18,
          ),
          minVerticalPadding: 0,
          horizontalTitleGap: 0,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18, left: 18),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Delivery Location",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorBlack5),
            ),
          ),
        ),
        ListTile(
          title: Text(
            "${userAddress[currentDetails]} ${userPincode[currentDetails]}",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: colorBlack5),
          ),
          subtitle: Text(
            " ${userCity[currentDetails]} ${userState[currentDetails]}",
            style: TextStyle(fontSize: 16, color: grey),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            color: colorBlack5,
            size: 18,
          ),
          leading: Container(
            // margin: EdgeInsets.only(right: 14),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: colorDark, borderRadius: BorderRadius.circular(8)),
            child: Icon(
              Icons.location_on_rounded,
              color: white,
              size: 28,
            ),
          ),
          minVerticalPadding: 0,
          horizontalTitleGap: 6,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18, left: 18),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Payment Method",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorBlack5),
            ),
          ),
        ),
        ListTile(
          title: Text(
            "COD",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: colorBlack5),
          ),
          subtitle: Text(
            "Cash on delivery",
            style: TextStyle(fontSize: 16, color: grey),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            color: colorBlack5,
            size: 18,
          ),
          leading: Container(
            // margin: EdgeInsets.only(right: 14),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: colorDark, borderRadius: BorderRadius.circular(8)),
            child: Icon(
              Icons.payment,
              color: white,
              size: 28,
            ),
          ),
          // minVerticalPadding: 0,
          horizontalTitleGap: 6,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18, left: 18, bottom: 18),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Order Info",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorBlack5),
            ),
          ),
        ),
        buildProfileText1("Quantity", qnt[currentDetails].toString()),
        SizedBox(
          height: 8,
        ),
        buildProfileText1("Total Amount", qntPrice[currentDetails] + rupees),
        // SizedBox(
        //   height: 33,
        // ),
        // ButtonWidget(
        //     context, "Enter product dimension", productDimensionFunction),
        SizedBox(
          height: 66,
        ),
      ],
    );
  }

  pendingFun() {}

  productDimensionFunction() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: SizedBox(
          height: 266,
          child: SingleChildScrollView(
            child: Column(
              children: [
                titleTextField(
                    "Weight", weightController, true, TextInputType.number),
                SizedBox(
                  height: 12,
                ),
                titleTextField(
                    "Height", heightController, true, TextInputType.number),
                SizedBox(
                  height: 12,
                ),
                titleTextField(
                    "Breath", breathController, true, TextInputType.number),
                SizedBox(
                  height: 12,
                ),
                titleTextField(
                    "Length", lengthController, true, TextInputType.number),
                SizedBox(
                  height: 22,
                ),
                ButtonWidget(context, "Submit", submitFunction),
              ],
            ),
          ),
        ),
      ),
    );
  }

  submitFunction() {
    Navigator.pop(context);
    DateTime time = DateTime.now();
    String phoneNumber = userNumber[currentDetails].toString().substring(3, 13);
    print("phoneNumber :: $phoneNumber");
    // final token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjE5NjQ2NDksIml"
    //     "zcyI6Imh0dHBzOi8vYXBpdjIuc2hpcHJvY2tldC5pbi92MS9leHRlcm5hbC9hdXRoL2xvZ"
    //     "2luIiwiaWF0IjoxNjM0MDU3MTY2LCJleHAiOjE2MzQ5MjExNjYsIm5iZiI6MTYzNDA1NzE"
    //     "2NiwianRpIjoiZkpEYTdtM2FvNTJ0SndYQyJ9.6f6sfSOZl4oCaSwB1-HEZ3aABuQCTPi"
    //     "zRjk1Aarqj3Q";
    final token = prefs.getString('token');
    final header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
    final body = {
      "order_id": "${time.microsecondsSinceEpoch}",
      "order_date": "$time",
      "pickup_location": "Home",
      "billing_customer_name": "${userName[currentDetails]}",
      "billing_last_name": "",
      "billing_address": "${userAddress[currentDetails]}",
      "billing_city": "${userCity[currentDetails]}",
      "billing_pincode": "${userPincode[currentDetails]}",
      "billing_state": "${userState[currentDetails]}",
      "billing_country": "India",
      "billing_email": "${userEmail[currentDetails]}",
      "billing_phone": "$phoneNumber",
      // "name": "${productName[currentDetails]}",
      // "sku": "${productCode[currentDetails]}",
      // "units": "${qnt[currentDetails]}",
      // "selling_price": "${productPrice[currentDetails]}",
      "payment_method": "COD",
      "order_items": [
        {
          "name": "${productName[currentDetails]}",
          "sku": "0000",
          "units": int.parse(qnt[currentDetails].toString().split(" ")[0]),
          "selling_price": "${productPrice[currentDetails]}",
          "discount": "",
          "tax": "",
          "hsn": "${productCode[currentDetails]}"
        }
      ],
      "shipping_is_billing": true,
      "sub_total": "${qntPrice[currentDetails]}",
      "length": "${lengthController.text}",
      "breadth": "${breathController.text}",
      "height": "${heightController.text}",
      "weight": "${weightController.text}",
    };

    final body1 = {
      "order_id": "224-447",
      "order_date": "2021-10-24 11:11",
      "pickup_location": "Home",
      "channel_id": "",
      "comment": "Reseller: M/s Goku",
      "billing_customer_name": "Naruto",
      "billing_last_name": "Uzumaki",
      "billing_address": "House 221B, Leaf Village",
      "billing_address_2": "Near Hokage House",
      "billing_city": "New Delhi",
      "billing_pincode": "110002",
      "billing_state": "Delhi",
      "billing_country": "India",
      "billing_email": "naruto@uzumaki.com",
      "billing_phone": "9876543210",
      "shipping_is_billing": true,
      "shipping_customer_name": "",
      "shipping_last_name": "",
      "shipping_address": "",
      "shipping_address_2": "",
      "shipping_city": "",
      "shipping_pincode": "",
      "shipping_country": "",
      "shipping_state": "",
      "shipping_email": "",
      "shipping_phone": "",
      "order_items": [
        {
          "name": "Kunai",
          "sku": "chakra123",
          "units": 10,
          "selling_price": "900",
          "discount": "",
          "tax": "",
          "hsn": 441122
        }
      ],
      "payment_method": "Prepaid",
      "shipping_charges": 0,
      "giftwrap_charges": 0,
      "transaction_charges": 0,
      "total_discount": 0,
      "sub_total": 9000,
      "length": 10,
      "breadth": 15,
      "height": 20,
      "weight": 2.5
    };

    post(Config.placeOrderShipRocket, body: jsonEncode(body), headers: header)
        .then((value) {
      print("Pickup :: ${value.body}");
    });

    setState(() {
      isShip = true;
    });
  }

  Future<void> generateToken() async {
    final time = DateTime.now();
    prefs = await SharedPreferences.getInstance();
    if (prefs.getString('dateWeather') == null) {
      await prefs.setString('dateWeather', "time.day.toString()");
    }
    print("Store Date :: ${prefs.getString('dateWeather')}");
    String _date = prefs.getString('dateWeather');
    String _date1 = time.day.toString();
    // ignore: unrelated_type_equality_checks
    // if (true) {
    if (_date1 != _date) {
      String email = "rahul24681357@gmail.com";
      String pass = "setupdev@1998";
      //create token
      post("https://apiv2.shiprocket.in/v1/external/auth/login?email=$email&password=$pass")
          .then((value) async {
        final json = jsonDecode(value.body.toString().replaceAll("\n", ""));
        String token = json['token'].toString();
        await prefs.setString('token', token);
        print("Token :: ${json['token']}");
      });

      await prefs.setString('dateWeather', time.day.toString());
    } else {
      print("Token :: ${prefs.getString('token')}");
    }
  }
}
