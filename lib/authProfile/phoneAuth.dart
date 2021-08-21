import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping/globalVariable.dart';
import 'package:shopping/pages/homePage.dart';

class phoneAuth extends StatefulWidget {
  @override
  _phoneAuthState createState() => _phoneAuthState();
}

class _phoneAuthState extends State<phoneAuth> {
  final phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final otpController = TextEditingController();
  bool otp = false;
  bool merchant = false;
  String _verificationId;
  String userString = "User";

  @override
  void initState() {
    checkMerchant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Visibility(
            visible: !otp,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 111, left: 18, right: 18),
                    child: Text(
                      "Sign up to keep ordering amazing and delicious food!",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 22, left: 18, right: 18),
                    child: Text(
                      "Add your phone number. We'll send you a verification code so we know you're real.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  titleTextField("Phone Number", phoneController, true),
                  InkWell(
                    onTap: () {
                      if (phoneController.text.length == 10) {
                        verifyPhoneNumber();
                      } else {
                        showSnackbar(context, "Please provide correct details",
                            Colors.grey);
                      }

                      setState(() {
                        otp = true;
                      });
                    },
                    child: Container(
                        width: double.infinity,
                        height: 46,
                        decoration: BoxDecoration(
                            color: colorDark,
                            // border: Border.all(color: global.colorBlack3, width: 2),
                            borderRadius: BorderRadius.circular(8)),
                        margin: EdgeInsets.only(
                            left: 14, right: 14, top: 22, bottom: 22),
                        child: Center(
                            child: Text(
                          "SEND OTP",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "By creating an account, you are agreeing to our Terms of Service",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: colorBlack1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: otp,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 111, left: 18, right: 18),
                      child: Text(
                        "Verify your \nPhone number",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 22, left: 18, right: 18),
                    child: Text(
                      "Enter your OTP code here",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  titleTextField("OTP", otpController, false),
                  InkWell(
                    onTap: () {
                      setState(() {
                        otp = true;
                      });
                    },
                    child: Container(
                        width: double.infinity,
                        height: 46,
                        decoration: BoxDecoration(
                            color: colorDark,
                            // border: Border.all(color: global.colorBlack3, width: 2),
                            borderRadius: BorderRadius.circular(8)),
                        margin: EdgeInsets.only(
                            left: 14, right: 14, top: 22, bottom: 22),
                        child: Center(
                            child: Text(
                          "SEND OTP",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ))),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 22, left: 18, right: 18),
                    child: Text(
                      "Good food never fail in bringing people together.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget titleTextField(
      String s, TextEditingController nameController, bool imageV) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Text(
              s,
              style: TextStyle(
                  fontSize: 18, color: grey, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          height: 46,
          decoration: BoxDecoration(
              // color: global.colorLight,
              border: Border.all(color: grey, width: 2),
              borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.only(left: 18, right: 18, top: 6),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Visibility(
                  visible: imageV,
                  child: Image.asset(
                    "images/flag.png",
                    height: 22,
                    width: 28,
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: TextField(
                  style: TextStyle(color: colorBlack2, fontSize: 18),
                  controller: nameController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  cursorColor: colorBlack2,
                  decoration: new InputDecoration(
                      border: InputBorder.none,
                      hintText: " ",
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void signInWithPhoneNumber() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    print("User ::" + user.toString());
    final uid = user.uid;
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otpController.text,
      );
      await auth.currentUser.linkWithCredential(credential).then((user) {
        print(uid);
      }).catchError((error) {
        print(error.toString());
      });
      // final User user = (await _auth.signInWithCredential(credential)).user;
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => homePage()));

      sendData();
    } catch (e) {}
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
      sendData();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => homePage()));
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

  Future<void> checkMerchant() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    merchant = prefs.getBool('merchant');
    if (merchant) {
      userString = "Merchant";
    }
    setState(() {});
  }

  void sendData() {
    final User user = FirebaseAuth.instance.currentUser;
    final uid = user.uid.toString();
    FirebaseDatabase.instance.reference().child("Users").child(uid).update({
      "name": _auth.currentUser.displayName,
      "email": _auth.currentUser.email,
      "phone": phoneController.text,
      "type": userString,
      "con": 0
    });
  }
}
