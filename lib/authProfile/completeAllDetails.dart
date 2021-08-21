import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping/widget/button_widget.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../globalVariable.dart';
import 'package:shopping/globalVariable.dart' as global;

import 'login.dart';

class completeAllDetails extends StatefulWidget {
  @override
  _completeAllDetailsState createState() => _completeAllDetailsState();
}

class _completeAllDetailsState extends State<completeAllDetails> {
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final address1Controller = TextEditingController();
  final foodTagsController = TextEditingController();
  final pinCodeController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final customTagController = TextEditingController();
  final dobController = TextEditingController();
  final favController = TextEditingController();
  final emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  bool otpLoading = false;
  bool isRegister = true; //  false
  StateSetter _setState;
  bool dialog = true;
  double popHeight;
  String foodTag = "";
  bool merchant = false;
  String radioButtonItem = "Male";
  String userString = "User";
  bool profileCon = true;
  var listedFood = [];
  String stepVar = "Step 1 / 3";
  double _count = 0;

  // Group Value for Radio Button.
  int id = 1;

  var foodTagesList = [
    "Fast Food",
    "Snacks",
    "Sweets",
    "Cold Drinks",
    "Wafers",
    "Other"
  ];
  var foodTagesSelected = [];
  int step = 1;

  @override
  void initState() {
    setEmailPhone();
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
      body: WillPopScope(
        onWillPop: previousStep,
        child: Stack(
          children: [
            Container(
              color: colorDark,
              width: double.infinity,
              height: double.infinity,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 44,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 8),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        stepVar,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: StepProgressIndicator(
                      totalSteps: 3,
                      currentStep: step,
                      size: 10,
                      padding: 2,
                      selectedColor: Colors.yellow,
                      unselectedColor: Colors.white24,
                      roundedEdges: Radius.circular(100),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 488,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 4,
                      margin: EdgeInsets.only(top: 36, left: 18, right: 18),
                      child: Stack(
                        children: [
                          Visibility(
                            visible: step == 1 ? true : false,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 18, bottom: 8, top: 22),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Personal Details",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                titleTextField(
                                    "Full Name", nameController, true),
                                SizedBox(
                                  height: 8,
                                ),
                                titleTextField("Email", emailController, false),
                                SizedBox(
                                  height: 8,
                                ),
                                titleTextField("Phone", phoneController, false),
                                SizedBox(
                                  height: 8,
                                ),
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 18),
                                        child: Text(
                                          "Gender",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: colorDark,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 46,
                                      decoration: BoxDecoration(
                                          // color: global.colorLight,
                                          border: Border.all(
                                              color: colorDark, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      margin: EdgeInsets.only(
                                          left: 14, right: 14, top: 6),
                                      child: Row(
                                        children: [
                                          Radio(
                                            activeColor: colorDark,
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
                                                fontSize: 17.0,
                                                color: global.colorBlack1),
                                          ),
                                          Radio(
                                            activeColor: colorDark,
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
                                                fontSize: 17.0,
                                                color: global.colorBlack1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Visibility(
                            visible: step == 2 ? true : false,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 18, bottom: 8, top: 22),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Store Details",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                titleTextField(
                                    "Store Address",
                                    address1Controller,
                                    true,
                                    TextInputType.streetAddress),
                                SizedBox(
                                  height: 8,
                                ),
                                titleTextField("Pin Code", pinCodeController,
                                    true, TextInputType.number),
                                SizedBox(
                                  height: 8,
                                ),
                                titleTextField("City", cityController),
                                SizedBox(
                                  height: 8,
                                ),
                                titleTextField("State", stateController),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: step == 3 ? true : false,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 18, bottom: 8, top: 22),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Food Category Details",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 18),
                                        child: Text(
                                          "Available Food Category",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: colorDark,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: _count > 0
                                          ? _count > 12
                                              ? 266
                                              : _count > 1
                                                  ? 30 * (_count.toDouble())
                                                  : 46 * (_count.toDouble())
                                          : 46,
                                      // height: 266,
                                      decoration: BoxDecoration(
                                          // color: global.colorLight,
                                          border: Border.all(
                                              color: colorDark, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      margin: EdgeInsets.only(
                                          left: 18, right: 18, top: 6),
                                      padding: EdgeInsets.only(
                                          bottom: _count > 1 ? 8 : 0,
                                          top: _count > 1 ? 8 : 0),
                                      child: SingleChildScrollView(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                flex: 85,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 14),
                                                  child: Text(
                                                    setTextInNextLine(foodTag),
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: colorBlack1,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 15,
                                                child: IconButton(
                                                  onPressed: () {
                                                    _showDialog();
                                                  },
                                                  padding: EdgeInsets.zero,
                                                  icon: Icon(
                                                    Icons
                                                        .add_circle_outline_rounded,
                                                    color: colorDark,
                                                    size: 33,
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: nextFunction,
                              child: Container(
                                height: 44,
                                width: 144,
                                margin: EdgeInsets.only(top: 24),
                                decoration: BoxDecoration(
                                    color: colorDark,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(33),
                                        bottomRight: Radius.circular(12))),
                                child: Center(
                                  child: Text(
                                    "Next",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget titleTextField(String s, TextEditingController nameController,
      [bool enable = true, final keyBoard = TextInputType.text]) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
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
              border: Border.all(color: colorDark, width: 1),
              borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.only(left: 14, right: 14, top: 6),
          padding: EdgeInsets.only(left: 14),
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

  nextFunction() {
    setState(() {
      if (step == 1) {
        step++;
        stepVar = "Step " + step.toString() + " / 3";
      } else if (step == 2) {
        if (validateField(context, address1Controller, 15, "default",
                "Please provide correct store address.") &&
            validateField(context, pinCodeController, 5, "default",
                "Pin Code should be 6 digits.") &&
            validateField(context, cityController) &&
            validateField(context, stateController)) {
          print("All field correct...");
          step++;
          stepVar = "Step " + step.toString() + " / 3";
        }
        // pushData();
      } else if (step == 3) {
        print("step 3");
      }
    });
    // print("click");
  }

  void sendUserData() {
    final User user = FirebaseAuth.instance.currentUser;
    final uid = user.uid.toString();
    FirebaseDatabase.instance.reference().child("Users").child(uid).update({
      "name": _auth.currentUser.displayName,
      "email": _auth.currentUser.email,
      "phone": phoneController.text,
      "address": address1Controller.text,
      "pincode": pinCodeController.text,
      "city": cityController.text,
      "state": stateController.text,
      "food": foodTag,
      // "fav": favController.text,
      // "dob": dobController.text,
      "gender": radioButtonItem,
      "type": "Merchant",
      "con": 1,
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void _showDialog() {
    dialog = true;
    popHeight = 300;
    showDialog(
        barrierDismissible: false,
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

  setupAlertDialoadContainer() {
    return Container(
      height: popHeight,
      child: Column(
        children: [
          Divider(
            thickness: 1,
          ),
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
                            popHeight = 188;
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
                          setState(() {});
                        }
                      },
                      title: Text(
                        foodTagesList[index],
                        style: TextStyle(
                            color: foodTagesSelected
                                    .toString()
                                    .contains(index.toString())
                                ? colorDark
                                : colorBlack2,
                            fontSize: 18,
                            fontWeight: foodTagesSelected
                                    .toString()
                                    .contains(index.toString())
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                      leading: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: colorBlack1,
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
              padding: EdgeInsets.only(left: 14),
              child: TextField(
                style: TextStyle(color: global.colorBlack2, fontSize: 18),
                controller: customTagController,
                textAlign: TextAlign.left,
                cursorColor: Colors.white,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText: "Custom Food Tags",
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            thickness: 1,
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    foodTag = "";
                    foodTagesSelected.clear();
                    customTagController.clear();
                    Navigator.pop(context);
                    _count = 0;
                  });
                },
                child: Text(
                  "Clear All",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (customTagController.text.length > 0) {
                      foodTag = foodTag + " | " + customTagController.text;
                    }
                    customTagController.clear();
                    Navigator.pop(context);
                  });
                },
                child: Text(
                  "Done",
                  style: TextStyle(
                      color: global.colorDark,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<bool> previousStep() {
    if (step == 1) {
      return Future.value(true);
    } else {
      setState(() {
        step--;
        stepVar = "Step " + step.toString() + " / 3";
      });
      return Future.value(false);
    }
  }

  String setTextInNextLine(String text) {
    if (text.isNotEmpty) {
      int len = text.length;
      String data = text.toString().substring(3, len);
      data = data.replaceAll(" | ", "\n");
      _count = (text.length - text.replaceAll(" | ", "").length).toDouble();
      _count = _count / 3;
      setState(() {
        print("Length :: ${foodTagesSelected.length}");
        print("_count :: $_count");
      });

      // _count = String.countMatches(text, " | ");
      // data = data.replaceAll(" | ", "\n- ");
      if (foodTag == " ") {
        setState(() {
          _count = 0;
        });
      }
      return data;
    }
    _count = 0;
    return "";
  }

  void setEmailPhone() {
    phoneController.text = _auth.currentUser.phoneNumber;
    nameController.text = _auth.currentUser.displayName;
    emailController.text = _auth.currentUser.email;
    setState(() {});
  }
}
