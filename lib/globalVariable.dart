library my_prj.globals;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

// String colorAccent = "32a4f4";
// String colorDark = "0976d2";

const Color colorAccent = Color(0xFFf898a2);
const Color colorLight = Color(0xFFf8ecee);
const Color colorDark1 = Color(0xFFf67280);
const Color colorDark = Color(0xFFED3946);
const Color colorDarkTrans = Color(0xccED3946);
const Color colorBlack1 = Color(0xFF5d5047);
const Color colorBlack2 = Color(0xFF1f1b18);
const Color colorBlack3 = Color(0xFF958787);
const Color colorBlack4 = Color(0xFF4a4b50);
const Color colorBlack5 = Color(0xFF404145);
final grey = Colors.grey;
final white = Colors.white;
final rupees = ' \u{20B9}';

String milli = DateTime.now().millisecondsSinceEpoch.toString();

final User user = FirebaseAuth.instance.currentUser;
final uid = user.uid.toString();
String name, email;

class ImageLink {
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

void test() {
  print("Getting Data");
}

Future<String> appCurrentUser(String key) async {
  final User user = FirebaseAuth.instance.currentUser;
  final uid = user.uid.toString();
  await FirebaseDatabase.instance
      .reference()
      .child("Users")
      .child(uid)
      .once()
      .then((DataSnapshot snap) {
    Map<dynamic, dynamic> values = snap.value;
    name = values["name"].toString();
    // email = values["email"].toString();
    return Future.value(name);
    // print("Return Data :: " + values[key].toString());
  });
}

void showSnackbar(context, String message, MaterialColor color) {
  final snackBar = SnackBar(
    backgroundColor: color,
    content: Text(message),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSnackbarWithButton(
    context, String message, MaterialColor color, btnText, function()) {
  final snackBar = SnackBar(
    backgroundColor: color,
    content: Text(message),
    action: SnackBarAction(
      label: btnText,
      onPressed: function(),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
