library my_prj.globals;

import 'dart:math';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// String colorAccent = "32a4f4";
// String colorDark = "0976d2";

const Color colorAccent = Color(0xFFf898a2);
const Color colorLight = Color(0xFFf8ecee);
const Color colorDark1 = Color(0xFFf67280);
const Color colorDark = Color(0xFFED3946);
const Color colorCard = Color(0xfff3f3f3);
const Color colorDarkTrans = Color(0xccED3946);
const Color colorBlack1 = Color(0xFF5d5047);
const Color colorBlack2 = Color(0xFF1f1b18);
const Color colorBlack3 = Color(0xFF958787);
const Color colorBlack4 = Color(0xFF4a4b50);
const Color colorBlack5 = Color(0xFF404145);
final grey = Colors.grey;
final white = Colors.white;
final rupees = ' \u{20B9}';
String global_cat_id = "";
String global_shop_id = "";
String milli = DateTime.now().millisecondsSinceEpoch.toString();

final User user = FirebaseAuth.instance.currentUser;
final uid = user.uid.toString();
String name, email;

class ImageLink {
  static String orderManagementImage =
      "https://i0.wp.com/miamibeef.com/wp-content/uploads/2019/09/Food-Delivery-Apps-Restaurant-Management-Tips-Miami-Beef.jpg?fit=1200%2C772&ssl=1";
  static String storeListingImage =
      "https://images.unsplash.com/photo-1534723452862-4c874018d66d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8c3RvcmV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60";
  static String listedFoodImage =
      "https://media.istockphoto.com/photos/table-top-view-of-indian-food-picture-id1212329362?k=6&m=1212329362&s=170667a&w=0&h=9XGLawVk3hCURarU72cwMDUc0hNFf9OmK-eqMUAckMo=";
  static String dailyRevenueImage =
      "https://images.pexels.com/photos/53621/calculator-calculation-insurance-finance-53621.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  static String discountOfferSchemeImage =
      "https://img.freepik.com/free-vector/special-offer-sale-discount-banner_180786-46.jpg?size=626&ext=jpg";
  static String gstComplianceImage =
      "https://i1.wp.com/www.a2ztaxcorp.com/wp-content/uploads/2019/08/GST-Compliance-Rating.jpg";
  static String merchantAgreementImage =
      "https://images.pexels.com/photos/327540/pexels-photo-327540.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  static String holidayManagementImage =
      "https://images.unsplash.com/photo-1475503572774-15a45e5d60b9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&w=1000&q=80";
  static String suggestionBoxImage =
      "https://media.istockphoto.com/photos/hand-inserting-suggestion-into-suggestion-box-picture-id496792842?k=6&m=496792842&s=612x612&w=0&h=tjpiINzHztG4e-YxCUly2vui-QosVGfoVxNQj4Tu9F8=";
}

// const _chars = '1234567890';
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString([int len = 28]) =>
    String.fromCharCodes(Iterable.generate(
        len, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

bool validateField(context, TextEditingController controller,
    [int validateLength = 0,
    String fieldType = "default",
    String errorMsg = "Field Can't be empty..."]) {
  if (controller.text.length > validateLength) {
    switch (fieldType) {
      case "default":
        return true;
        break;
      case "phone":
        if (controller.text.length == 10) {
          return true;
        }
        showSnackbar(context, "Phone number should be 10 digits", Colors.red);

        break;
      case "email":
        if (controller.text.contains(RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
          return true;
        }
        showSnackbar(context, "Provide correct email address", Colors.red);
        break;
      case "password":
        if (controller.text.length > 8) {
          return true;
        }
        showSnackbar(context, "Password should be 8 digits", Colors.red);
        break;
    }
  } else {
    showSnackbar(context, errorMsg, Colors.red);
    return false;
  }
}

int getJsonLength(jsonText) {
  int len = 0;
  try {
    while (jsonText[len] != null) {
      len++;
    }
    // print("Len :: $len");
  } catch (e) {
    print("Len Catch :: $len");
    return len;
  }
}

class Config {
  static String mainUrl = "https://swajan.online/api/";
  static String updateUrl = "update.php";
  static String checkProfileUrl = "check_profile.php";
  static String userInsertUrl = "user_insert.php";
  static String profileCompletedUrl = "profile_completed.php";
  static String categoryInsertUrl = "category_Insert.php";
  static String shopDetailsInsert = "shop_details_Insert.php";
  static String getCat = "getCategoryId.php";
  static String insertProducts = "products_Insert.php";
  static String afterShipping = "merchant_panel/after_shipping.php";
  static String merchantProductsUrl = "merchant_product.php";
  static String changeMerchantProducts = "merchant_panel/product_update.php";
  static String getMerchantDetails = "area_details.php";
  static String changeMerchantDetails = "merchant_panel/updateshop_details.php";
  static String getActiveOrder = "merchant_panel/active_orders.php";
  static String getUserDetails = "user_panel/get_userdetails.php";
  static String getProductDetailsById = "merchant_panel/get_productsbyID.php";
  static String setPickupLocation =
      "https://apiv2.shiprocket.in/v1/external/settings/company/addpickup";
  static String placeOrderShipRocket =
      "https://apiv2.shiprocket.in/v1/external/orders/create/adhoc";
}

void showSnackbar(context, String message, MaterialColor color) {
  final snackBar = SnackBar(
    backgroundColor: color,
    content: Text(message),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Widget titleTextField(String s, TextEditingController nameController,
    [bool enable = true, final keyBoard = TextInputType.text, int i = 0]) {
  return Column(
    children: [
      Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            s,
            style: TextStyle(
                fontSize: 18, color: colorDark, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Container(
        height: 46,
        decoration: BoxDecoration(
            // color: global.colorLight,
            border: Border.all(color: grey, width: 1),
            borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.only(left: 18, right: 18, top: 6),
        padding: EdgeInsets.only(left: 18),
        child: TextField(
          enabled: enable,
          style: TextStyle(color: colorBlack2, fontSize: 18),
          controller: nameController,
          keyboardType: keyBoard,
          textAlign: TextAlign.left,
          cursorColor: colorBlack2,
          decoration: new InputDecoration(
              border: InputBorder.none,
              hintText: " ",
              hintStyle: TextStyle(color: Colors.grey)),
        ),
      ),
    ],
  );
}

Widget showLoading([text = "Loading..."]) {
  return Center(
      child: Card(
    elevation: 10,
    color: white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
    margin: EdgeInsets.only(top: 222),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(colorDark),
          ),
          SizedBox(
            height: 12,
          ),
          Text(text),
        ],
      ),
    ),
  ));
}

var productCategory = ["Penda", 'Barfi', 'Halwa', 'Mava Mithai'];

Widget loadingWidget([String msg = "No details were found."]) {
  return Center(
    child: FutureBuilder(
        future: Future.delayed(Duration(seconds: 3)),
        builder: (c, s) => s.connectionState == ConnectionState.done
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    "https://cdn-icons-png.flaticon.com/512/2345/2345152.png",
                    width: 155,
                    height: 155,
                    color: colorDark,
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Text(
                    msg,
                    style: TextStyle(fontSize: 18),
                  )
                ],
              )
            : CircularProgressIndicator()),
  );
}

// void showSnackbarWithButton(
//     context, String message, MaterialColor color, btnText, function) {
//   final snackBar = SnackBar(
//     backgroundColor: color,
//     content: Text(message),
//     action: SnackBarAction(
//       label: btnText,
//       onPressed: function,
//     ),
//   );
//   ScaffoldMessenger.of(context).showSnackBar(snackBar);
// }
