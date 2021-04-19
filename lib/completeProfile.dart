import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping/userHomePage.dart';
import 'globalVariable.dart' as global;
import 'package:firebase_core/firebase_core.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'globalVariable.dart';
import 'homePage.dart';

class completeProfile extends StatefulWidget {
  @override
  _completeProfileState createState() => _completeProfileState();
}

class _completeProfileState extends State<completeProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId;
  final SmsAutoFill _autoFill = SmsAutoFill();

  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final foodTagsController = TextEditingController();
  final _smsController = TextEditingController();
  bool loading = false;
  bool otpLoading = false;

  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    checkUserData();
    setState(() {
      nameController.text = auth.currentUser.displayName.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 28,
            ),
            Center(
              child: Image.asset(
                "images/profile.png",
                height: 200,
                width: 200,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, top: 22),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Lets's Complete Registration",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: global.colorBlack1),
                ),
              ),
            ),
            Container(
              height: 46,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: global.colorBlack3, width: 2),
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.only(left: 14, right: 14, top: 22),
              child: TextFormField(
                style: TextStyle(color: global.colorBlack2, fontSize: 18),
                controller: nameController,
                textAlign: TextAlign.center,
                cursorColor: global.colorBlack2,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText: "Name",
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            Container(
              height: 46,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: global.colorBlack3, width: 2),
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.only(left: 14, right: 14, top: 8),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: global.colorBlack2, fontSize: 18),
                controller: phoneController,
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText: "Phone Number",
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            Container(
              height: 46,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: global.colorBlack3, width: 2),
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.only(left: 14, right: 14, top: 8),
              child: TextField(
                style: TextStyle(color: global.colorBlack2, fontSize: 18),
                controller: addressController,
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText: "Address",
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            Container(
              height: 46,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: global.colorBlack3, width: 2),
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.only(left: 14, right: 14, top: 8),
              child: TextField(
                style: TextStyle(color: global.colorBlack2, fontSize: 18),
                controller: foodTagsController,
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText: "Food Category Tags",
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            Row(
              children: [
                Container(
                  height: 46,
                  width: 222,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: global.colorBlack3, width: 2),
                      borderRadius: BorderRadius.circular(8)),
                  margin: EdgeInsets.only(left: 14, right: 4, top: 8),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: global.colorBlack2, fontSize: 18),
                    controller: _smsController,
                    textAlign: TextAlign.center,
                    cursorColor: Colors.white,
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        hintText: "OTP",
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (phoneController.text.length == 10) {
                      setState(() {
                        otpLoading = true;
                      });
                      verifyPhoneNumber();
                    } else {
                      // _showSnackbar();
                      showSnackbar(
                          context, "Phone number can't be empty", Colors.grey);
                    }
                  },
                  child: Container(
                    height: 46,
                    width: 100,
                    decoration: BoxDecoration(
                        color: global.colorBlack1,
                        // border: Border.all(color: global.colorBlack3, width: 2),
                        borderRadius: BorderRadius.circular(8)),
                    margin: EdgeInsets.only(left: 4, right: 14, top: 8),
                    child: Center(
                      child: otpLoading
                          ? SizedBox(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              ),
                              height: 26,
                              width: 26,
                            )
                          : Text(
                              "Get OTP",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                setState(() {
                  loading = true;
                });
                signInWithPhoneNumber();
              },
              child: Container(
                  width: double.infinity,
                  height: 46,
                  decoration: BoxDecoration(
                      color: global.colorBlack1,
                      // border: Border.all(color: global.colorBlack3, width: 2),
                      borderRadius: BorderRadius.circular(8)),
                  margin:
                      EdgeInsets.only(left: 14, right: 14, top: 22, bottom: 33),
                  child: Center(
                      child: loading
                          ? SizedBox(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              ),
                              height: 26,
                              width: 26,
                            )
                          : Text(
                              "Continue",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ))),
            ),
          ],
        ),
      ),
    );
  }

  void verifyPhoneNumber() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    print("User ::" + user.toString());
    final uid = user.uid;

    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await auth.currentUser
          .linkWithCredential(phoneAuthCredential)
          .then((user) {
        print(uid);
      }).catchError((error) {
        print(error.toString());
      });

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => homePage()));
      sendUserData();
      setState(() {
        loading = false;
      });
    };

    //Listens for errors with verification, such as too many attempts
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      showSnackbar(
          context,
          'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}',
          Colors.grey);
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      // showSnackbar(
      //     'Please check your phone for the verification code.', Colors.grey);
      _verificationId = verificationId;
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: "+91" + phoneController.text,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackbar(context, "Failed to Verify Phone Number: ${e}", Colors.grey);
    }
  }

  // void showSnackbar(context,String message, MaterialColor red) {
  //   final snackBar = SnackBar(backgroundColor: red, content: Text(message));
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }

  void signInWithPhoneNumber() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    print("User ::" + user.toString());
    final uid = user.uid;
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _smsController.text,
      );
      await auth.currentUser.linkWithCredential(credential).then((user) {
        print(uid);
      }).catchError((error) {
        print(error.toString());
      });
      // final User user = (await _auth.signInWithCredential(credential)).user;
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => homePage()));
      sendUserData();
      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  void sendUserData() {
    final User user = FirebaseAuth.instance.currentUser;
    final uid = user.uid.toString();
    FirebaseDatabase.instance.reference().child("Users").child(uid).update({
      "name": _auth.currentUser.displayName,
      "email": _auth.currentUser.email,
      "phone": phoneController.text,
      "address": addressController.text,
      "food": foodTagsController.text,
    });
  }

  void checkUserData() {
    FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(_auth.currentUser.uid)
        .once()
        .then((DataSnapshot snap) {
      if (snap.value["type"].toString() == "Merchant") {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => homePage()));
      } else if (snap.value["type"].toString() == "User") {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => userHomePage()));
      }
    });
  }

  // void _showSnackbar() {
  //   final snackBar = SnackBar(
  //       backgroundColor: Colors.redAccent,
  //       content: Text("Fields can't be empty"));
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }
}
