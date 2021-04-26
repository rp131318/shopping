import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final address1Controller = TextEditingController();
  final foodTagsController = TextEditingController();
  final _smsController = TextEditingController();
  final address2Controller = TextEditingController();
  final pinCodeController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final customTagController = TextEditingController();
  final dobController = TextEditingController();
  final favController = TextEditingController();
  bool loading = false;
  bool otpLoading = false;
  bool isRegister = false; //  false
  StateSetter _setState;
  bool dialog = true;
  double popHeight;
  String foodTag = "Food Tags";
  bool merchant = false;
  String radioButtonItem = "Male";
  String userString = "User";

  // Group Value for Radio Button.
  int id = 1;

  var foodTagesList = ["Pizza", "Burger", "Cold Drinks", "Chinese", "Other"];
  var foodTagesSelected = [];

  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    checkUserData();
    foodTag = "";
    checkMerchant();
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
      body: isRegister
          ? SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 28,
                  ),
                  Center(
                    child: Image.asset(
                      "images/profile.png",
                      height: 188,
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
                          hintText: "Phone Number (10 digits only)",
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
                      controller: address1Controller,
                      textAlign: TextAlign.center,
                      cursorColor: Colors.white,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: "Address Line 1 (Required)",
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
                      controller: address2Controller,
                      textAlign: TextAlign.center,
                      cursorColor: Colors.white,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: "Address Line 2 (Optional)",
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
                      keyboardType: TextInputType.number,
                      controller: pinCodeController,
                      textAlign: TextAlign.center,
                      cursorColor: Colors.white,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: "Pin Code (6 digits only)",
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
                      controller: cityController,
                      textAlign: TextAlign.center,
                      cursorColor: Colors.white,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: "City (Can be change)",
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
                      controller: stateController,
                      textAlign: TextAlign.center,
                      cursorColor: Colors.white,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: "State (Can be change)",
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  Visibility(
                    visible: merchant,
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: global.colorBlack3, width: 2),
                          borderRadius: BorderRadius.circular(8)),
                      margin: EdgeInsets.only(left: 14, right: 14, top: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text(
                                foodTag,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: global.colorBlack1,
                                  fontSize: 18,
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: IconButton(
                                onPressed: () {
                                  _showDialog();
                                },
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.add_box_rounded,
                                  color: global.colorBlack1,
                                  size: 34,
                                ),
                              )),
                        ],
                      ),
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
                      style: TextStyle(color: global.colorBlack2, fontSize: 18),
                      controller: favController,
                      textAlign: TextAlign.center,
                      cursorColor: Colors.white,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: "Favourite Food",
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1900, 3, 5),
                          maxTime: DateTime.now(),
                          theme: DatePickerTheme(
                              // headerColor: global,
                              backgroundColor: Colors.white,
                              itemStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              cancelStyle:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              doneStyle: TextStyle(
                                  color: global.colorDark,
                                  fontSize: 16)), onChanged: (date) {
                        print('change $date in time zone ' +
                            date.timeZoneOffset.inHours.toString());
                        setState(() {
                          dobController.text =
                              date.toString().split(" ")[0].toString();
                        });
                      }, onConfirm: (date) {
                        print('confirm $date');
                        setState(() {
                          dobController.text =
                              date.toString().split(" ")[0].toString();
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: global.colorBlack3, width: 2),
                          borderRadius: BorderRadius.circular(8)),
                      margin: EdgeInsets.only(left: 14, right: 14, top: 8),
                      child: TextFormField(
                        enabled: false,
                        style:
                            TextStyle(color: global.colorBlack2, fontSize: 18),
                        controller: dobController,
                        textAlign: TextAlign.center,
                        cursorColor: Colors.white,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            hintText: "Date of Birth",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),
                  Container(
                      height: 46,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: global.colorBlack3, width: 2),
                          borderRadius: BorderRadius.circular(8)),
                      margin: EdgeInsets.only(left: 14, right: 14, top: 8),
                      child: Row(
                        children: [
                          Radio(
                            activeColor: global.colorBlack1,
                            value: 1,
                            groupValue: id,
                            onChanged: (val) {
                              setState(() {
                                radioButtonItem = 'Male';
                                id = 1;
                              });
                            },
                          ),
                          Text(
                            'Male',
                            style: new TextStyle(
                                fontSize: 17.0, color: global.colorBlack1),
                          ),
                          Radio(
                            activeColor: global.colorBlack1,
                            value: 2,
                            groupValue: id,
                            onChanged: (val) {
                              setState(() {
                                radioButtonItem = 'Female';
                                id = 2;
                              });
                            },
                          ),
                          Text(
                            'Female',
                            style: new TextStyle(
                                fontSize: 17.0, color: global.colorBlack1),
                          ),
                        ],
                      )),
                  Row(
                    children: [
                      Container(
                        height: 46,
                        width: 222,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: global.colorBlack3, width: 2),
                            borderRadius: BorderRadius.circular(8)),
                        margin: EdgeInsets.only(left: 14, right: 4, top: 8),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: global.colorBlack2, fontSize: 18),
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
                            if (nameController.text.length > 0 &&
                                phoneController.text.length > 0 &&
                                address1Controller.text.length > 0 &&
                                pinCodeController.text.length > 0 &&
                                cityController.text.length > 0 &&
                                stateController.text.length > 0 &&
                                dobController.text.length > 0) {
                              verifyPhoneNumber();
                            } else {
                              global.showSnackbar(
                                  context,
                                  "Please provide correct details",
                                  Colors.grey);
                            }
                          } else {
                            // _showSnackbar();
                            showSnackbar(context, "Phone number can't be empty",
                                Colors.grey);
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
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Colors.white),
                                    ),
                                    height: 26,
                                    width: 26,
                                  )
                                : Text(
                                    "Get OTP",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
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
                      if (nameController.text.length > 0 &&
                          phoneController.text.length > 0 &&
                          address1Controller.text.length > 0 &&
                          pinCodeController.text.length > 0 &&
                          cityController.text.length > 0 &&
                          stateController.text.length > 0 &&
                          dobController.text.length > 0) {
                        signInWithPhoneNumber();
                      } else {
                        global.showSnackbar(context,
                            "Please provide correct details", Colors.grey);
                      }
                    },
                    child: Container(
                        width: double.infinity,
                        height: 46,
                        decoration: BoxDecoration(
                            color: global.colorBlack1,
                            // border: Border.all(color: global.colorBlack3, width: 2),
                            borderRadius: BorderRadius.circular(8)),
                        margin: EdgeInsets.only(
                            left: 14, right: 14, top: 22, bottom: 33),
                        child: Center(
                            child: loading
                                ? SizedBox(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Colors.white),
                                    ),
                                    height: 26,
                                    width: 26,
                                  )
                                : Text(
                                    "Continue",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ))),
                  ),
                ],
              ),
            )
          : Center(
              child: FlutterLogo(
                size: 166,
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
      if (merchant) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => homePage()));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => userHomePage()));
      }

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
      if (merchant) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => homePage()));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => userHomePage()));
      }
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

  void _showDialog() {
    dialog = true;
    popHeight = 300;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            title: Text("Select Food Category Tags"),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                _setState = setState;
                return setupAlertDialoadContainer();
              },
            ),
          );
        });
  }

  void sendUserData() {
    final User user = FirebaseAuth.instance.currentUser;
    final uid = user.uid.toString();
    FirebaseDatabase.instance.reference().child("Users").child(uid).update({
      "name": _auth.currentUser.displayName,
      "email": _auth.currentUser.email,
      "phone": phoneController.text,
      "address": address1Controller.text +
          " " +
          address2Controller.text +
          " " +
          pinCodeController.text,
      "city": cityController.text,
      "state": stateController.text,
      "food": foodTag,
      "fav": favController.text,
      "dob": dobController.text,
      "gender": radioButtonItem,
      "type": userString,
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
      } else {
        setState(() {
          isRegister = true;
        });
      }
    });
  }

  setupAlertDialoadContainer() {
    return Container(
      height: popHeight,
      child: Column(
        children: [
          Visibility(
            visible: dialog,
            child: Flexible(
              child: ListView.builder(
                  itemCount: foodTagesList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        if (foodTagesList[index] == "Other") {
                          _setState(() {
                            dialog = false;
                            popHeight = 160;
                          });
                        } else {
                          if (foodTagesSelected
                              .toString()
                              .contains(index.toString())) {
                            foodTag = foodTag.replaceAll(
                                " | " + foodTagesList[index], "");
                            foodTagesSelected.remove(index);
                          } else {
                            foodTagesSelected.add(index);
                            foodTag = foodTag + " | " + foodTagesList[index];
                          }
                          _setState(() {
                            print("foodTagesSelected :: $foodTagesSelected");
                            print("foodTag :: $foodTag");
                          });
                        }
                      },
                      title: Text(
                        foodTagesList[index],
                        style: TextStyle(
                            color: foodTagesSelected
                                    .toString()
                                    .contains(index.toString())
                                ? global.colorDark
                                : global.colorBlack2,
                            fontSize: 18,
                            fontWeight: foodTagesSelected
                                    .toString()
                                    .contains(index.toString())
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                      leading: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: global.colorBlack1,
                      ),
                    );
                  }),
            ),
          ),
          Visibility(
            visible: !dialog,
            child: Container(
              height: 46,
              width: 222,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: global.colorBlack3, width: 2),
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.only(left: 14, right: 4, top: 8, bottom: 33),
              child: TextField(
                style: TextStyle(color: global.colorBlack2, fontSize: 18),
                controller: customTagController,
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText: "Custom Food Tags",
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                setState(() {
                  if (customTagController.text.length > 0) {
                    foodTag = foodTag + " | " + customTagController.text;
                  }
                  customTagController.clear();
                  Navigator.pop(context);
                });
              },
              child: Chip(
                shape: StadiumBorder(side: BorderSide(color: global.colorDark)),
                elevation: 1,
                backgroundColor: Colors.white,
                label: Text(
                  "Done",
                  style: TextStyle(
                      color: global.colorDark,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> checkMerchant() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    merchant = prefs.getBool('merchant');
    if (merchant) {
      userString = "Merchant";
    }
    setState(() {});
  }

  // void _showSnackbar() {
  //   final snackBar = SnackBar(
  //       backgroundColor: Colors.redAccent,
  //       content: Text("Fields can't be empty"));
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }
}
