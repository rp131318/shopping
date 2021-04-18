library my_prj.globals;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'globalVariable.dart' as global;
import 'auth.dart';
import 'dart:math';
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

String milli = DateTime.now().millisecondsSinceEpoch.toString();

final User user = FirebaseAuth.instance.currentUser;
final uid = user.uid.toString();
String name, email;

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
    email = values["email"].toString();
    return name;
    // print("Return Data :: " + values[key].toString());
  });
}

void showSnackbar(context, String message, MaterialColor color) {
  final snackBar = SnackBar(backgroundColor: color, content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
