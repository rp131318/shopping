import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping/globalVariable.dart';
import 'package:shopping/globalVariable.dart' as global;
import 'homePage.dart';

// ignore: camel_case_types
class storeListing extends StatefulWidget {
  @override
  _storeListingState createState() => _storeListingState();
}

class _storeListingState extends State<storeListing> {
  File _image;
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final sGstController = TextEditingController();
  final cGstController = TextEditingController();
  final gstController = TextEditingController();
  final cateController = TextEditingController();
  final expController = TextEditingController();
  final hsnCodeController = TextEditingController();
  final locController = TextEditingController();
  final popPriceController = TextEditingController();
  final popQntController = TextEditingController();
  final productDisController = TextEditingController();
  final picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String link;
  String _unit = "Gram";
  String dropdownValueCate = "Click to Select";
  String dropdownValueMeas = "Kg";
  String milli = DateTime.now().millisecondsSinceEpoch.toString();
  bool tax = true;
  bool cusPriceV = false;
  List<String> catList = ["Click to Select", "Pizza", "Burger", "Snacks"];
  List<String> measList = ["Kg", "Piece", "Litre"];
  int id = 1;
  String radioButtonItem = "Standard";
  int idMeas = 1;
  String radioButtonItemMeas = "KG Kilogram";
  var qntGm = ["250", "500", "750", "1000"];
  var qntGmCus = [];
  var qntPrice = [];

  @override
  void initState() {}

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
                        "Food Details",
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
                        "We need food details to list your food.",
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
            SizedBox(
              height: 22,
            ),
            titleTextField("Product Name", nameController),
            SizedBox(
              height: 12,
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Text(
                      "Measurement",
                      style: TextStyle(
                          fontSize: 18,
                          color: colorDark,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                radioButtonOfMeasurement()
              ],
            ),
            SizedBox(
              height: 12,
            ),
            titleTextField(
                "GST Rate %", gstController, true, TextInputType.number),
            SizedBox(
              height: 12,
            ),
            titleTextField("HSN Code/SAC Code", hsnCodeController),
            SizedBox(
              height: 12,
            ),
            titleTextField("Product Price", priceController, true,
                TextInputType.number, 1),
            SizedBox(
              height: 12,
            ),
            radioButton(),
            SizedBox(
              height: 12,
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Text(
                      "Quantity Details",
                      style: TextStyle(
                          fontSize: 18,
                          color: colorDark,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  // height: 156,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // color: global.colorLight,
                      border: Border.all(color: grey, width: 1),
                      borderRadius: BorderRadius.circular(8)),
                  margin: EdgeInsets.only(left: 18, right: 18, top: 6),
                  child: measDetails(),
                ),
              ],
            ),
            Visibility(
              visible: cusPriceV,
              child: Padding(
                padding: const EdgeInsets.only(left: 18, top: 6),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                    "Food pricing can't be set more than 10 % of actual rate."),
                                content: setupAlertDialoadUnits(),
                              );
                            });
                      },
                      child: Icon(
                        Icons.add_circle_outline_rounded,
                        color: colorDark,
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text("Add customize pricing and quantity"),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            titleTextField(
                "Product Instruction/Description", productDisController),
            SizedBox(
              height: 12,
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Row(
                      children: [
                        Text(
                          "Product Category",
                          style: TextStyle(
                              fontSize: 18,
                              color: colorDark,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 46,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // color: global.colorLight,
                      border: Border.all(color: grey, width: 1),
                      borderRadius: BorderRadius.circular(8)),
                  margin: EdgeInsets.only(left: 18, right: 18, top: 6),
                  child: buildDropdownButtonCate(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                      value: tax,
                      activeColor: global.colorDark,
                      onChanged: (value) {
                        setState(() {
                          tax = value;
                          if (!tax &&
                              priceController.text.length > 0 &&
                              gstController.text.length > 0) {
                            double _tax = 0;
                            _tax = (double.parse(priceController.text) *
                                    double.parse(gstController.text)) /
                                100;
                            cGstController.text =
                                (_tax / 2).toString() + rupees;
                            sGstController.text =
                                (_tax / 2).toString() + rupees;
                          }
                        });
                        print("value :: $value");
                      }),
                  Text("Including all tax"),
                ],
              ),
            ),
            Visibility(
              visible: !tax,
              child: titleTextField("SGST", sGstController, false),
            ),
            Visibility(
              visible: !tax,
              child: SizedBox(
                height: 12,
              ),
            ),
            Visibility(
              visible: !tax,
              child: titleTextField("CGST", cGstController, false),
            ),
            SizedBox(
              height: 12,
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Text(
                      "Upload Image",
                      style: TextStyle(
                          fontSize: 18,
                          color: colorDark,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    chooseImage();
                  },
                  child: Card(
                    margin: EdgeInsets.only(left: 18, right: 18, top: 6),
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: _image == null
                        ? Image.asset(
                            "images/foodim2.jpg",
                          )
                        : Image.file(_image),
                  ),
                )
              ],
            ),
            InkWell(
              onTap: () {
                listFoodNow();
              },
              child: Container(
                  width: double.infinity,
                  height: 46,
                  decoration: BoxDecoration(
                      color: global.colorDark,
                      // border: Border.all(color: global.colorBlack3, width: 2),
                      borderRadius: BorderRadius.circular(8)),
                  margin:
                      EdgeInsets.only(left: 14, right: 14, top: 44, bottom: 22),
                  child: Center(
                      child: Text(
                    "List Food Now",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ))),
            )
          ],
        ),
      ),
    );
  }

  Widget buildDropdownButtonMeas() {
    return Center(
      child: DropdownButton<String>(
        value: dropdownValueMeas,
        elevation: 0,
        underline: Container(),
        icon: Container(),
        style: const TextStyle(color: global.colorBlack2),
        onChanged: (String newValue) {
          setState(() {
            dropdownValueMeas = newValue;

            if (dropdownValueMeas == "Kg") {
              _unit = "Gram";
              qntGm = ["250", "500", "750", "1000"];
            } else if (dropdownValueMeas == "Piece") {
              _unit = dropdownValueMeas;
              qntGm = ["1", "3", "5", "10"];
            } else if (dropdownValueMeas == "Litre") {
              _unit = dropdownValueMeas;
              qntGm = ["1", "3", "5", "10"];
            }
            print("qntGm :: $qntGm");
          });
        },
        items: measList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(fontSize: 18),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildDropdownButtonCate() {
    return Center(
      child: DropdownButton<String>(
        value: dropdownValueCate,
        elevation: 0,
        underline: Container(),
        icon: Icon(
          Icons.arrow_drop_down_rounded,
          size: 36,
        ),
        style: const TextStyle(color: global.colorBlack2),
        onChanged: (String newValue) {
          setState(() {
            dropdownValueCate = newValue;
          });
        },
        items: catList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(fontSize: 18),
            ),
          );
        }).toList(),
      ),
    );
  }

  void listFoodNow() {
    if (nameController.text.length > 0 &&
        priceController.text.length > 0 &&
        hsnCodeController.text.length > 0 &&
        hsnCodeController.text.length > 0 &&
        dropdownValueCate != "Click to Select" &&
        _image.path.toString().length > 0) {
      final snackBar = SnackBar(
          backgroundColor: Colors.green,
          content: Text("Food listing complete"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      uploadImage();
    } else {
      final snackBar = SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Fields can't be empty"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        print(pickedFile.path);
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> uploadImage() async {
    StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('Food Images/' + _auth.currentUser.uid + "/" + milli);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    link = await taskSnapshot.ref.getDownloadURL().toString();
    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    link = dowurl.toString();
    print("Link Top :: $link");
    sendInfo(link);
    // taskSnapshot.ref.getDownloadURL().then((value) {
    //   sendInfo(link);
    // });
  }

  void sendInfo(String link) {
    print("Link :: $link");
    FirebaseDatabase.instance
        .reference()
        .child("Listed Food")
        .child(_auth.currentUser.uid)
        .child(milli)
        .update({
      "n": nameController.text,
      "p": priceController.text,
      "unit": dropdownValueMeas,
      "sgst": sGstController.text,
      "cgst": cGstController.text,
      "gst": gstController.text,
      "cat": dropdownValueCate,
      "i": link.toString()
    });
    if (id == 2) {
      FirebaseDatabase.instance
          .reference()
          .child("Listed Food")
          .child(_auth.currentUser.uid)
          .child(milli)
          .update({
        "qnt": removeLastAndFirst(qntGmCus.toString()),
        "qntPrice": removeLastAndFirst(qntPrice.toString()),
      });
    }
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => homePage()));
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
            onSubmitted: (text) {
              setState(() {
                if (i == 1) {
                  priceController.clear();
                  priceController.text = text;
                }
              });
            },
            onChanged: (text) {
              setState(() {});
            },
            enabled: enable,
            style: TextStyle(color: global.colorBlack2, fontSize: 18),
            controller: nameController,
            keyboardType: keyBoard,
            textAlign: TextAlign.left,
            cursorColor: global.colorBlack2,
            decoration: new InputDecoration(
                border: InputBorder.none,
                hintText: " ",
                hintStyle: TextStyle(color: Colors.grey)),
          ),
        ),
      ],
    );
  }

  setupAlertDialoadUnits() {
    return Container(
      height: 244,
      child: SingleChildScrollView(
        child: Column(
          children: [
            titleTextField("Quantity (" + _unit + ")", popQntController, true,
                TextInputType.number),
            SizedBox(
              height: 12,
            ),
            titleTextField("Price" + rupees, popPriceController, true,
                TextInputType.number),
            InkWell(
              onTap: () {
                if (popPriceController.text.length > 0 &&
                    popQntController.text.length > 0) {
                  qntGmCus.add(popQntController.text);
                  qntPrice.add(popPriceController.text);
                  popPriceController.clear();
                  popQntController.clear();
                  Navigator.pop(context);
                  removeLastAndFirst(qntGmCus.toString());
                  String tr = qntGmCus
                      .toString()
                      .substring(1, qntGmCus.toString().length - 1);
                  print("qntGmCus :: $qntGmCus" + tr);
                  print("qntPrice :: $qntPrice");
                  setState(() {});
                }
              },
              child: Container(
                  width: double.infinity,
                  height: 46,
                  decoration: BoxDecoration(
                      color: global.colorDark,
                      // border: Border.all(color: global.colorBlack3, width: 2),
                      borderRadius: BorderRadius.circular(8)),
                  margin:
                      EdgeInsets.only(left: 18, right: 18, top: 22, bottom: 8),
                  child: Center(
                      child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ))),
            )
          ],
        ),
      ),
    );
  }

  ListTile popUpUnits(String unit, String initials) {
    return ListTile(
      title: Text(unit,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
      onTap: () {
        if (unit == "Kg") {
          setState(() {
            _unit = initials;
          });
        } else {
          setState(() {
            _unit = unit;
          });
        }
        Navigator.pop(context);
      },
      leading: CircleAvatar(
        backgroundColor: global.colorDark,
        child: Text(initials, style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Padding buildProfileText(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 22, right: 22),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              )),
          Expanded(
              flex: 7,
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 16, color: global.colorBlack2),
              )),
        ],
      ),
    );
  }

  Divider buildDivider() {
    return Divider(
      indent: 22,
      endIndent: 22,
      // height: 44,
      thickness: 1,
    );
  }

  measDetails() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: 40 * qntGm.length.toDouble(),
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: id == 2 ? qntGmCus.length : qntGm.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildProfileText(
                      id == 2
                          ? qntGmCus[index] + " " + _unit
                          : qntGm[index] + " " + _unit,
                      id == 2
                          ? qntPrice[index].toString() + rupees
                          : quantityPrice(qntGm[index]) + rupees),
                  (id == 2 && index == qntGmCus.length - 1) ||
                          (id == 1 && index == qntGm.length - 1)
                      ? Container()
                      : buildDivider(),
                ],
              );
            }),
      ),
    );
  }

  String quantityPrice(String quant) {
    if (priceController.text.length > 0 &&
        priceController.text != "." &&
        !priceController.text.toString().contains(",") &&
        !priceController.text.toString().contains("-") &&
        !priceController.text.toString().contains("..")) {
      double qntPrice = 0;
      switch (_unit) {
        case "Gram":
          qntPrice =
              (int.parse(quant) * double.parse(priceController.text)) / 1000;
          break;
        case "Litre":
          qntPrice = int.parse(quant) * double.parse(priceController.text);
          break;
        case "Piece":
          qntPrice = int.parse(quant) * double.parse(priceController.text);
          break;
      }

      return qntPrice.toString();
    } else {
      return "0";
    }
  }

  radioButton() {
    return Container(
      height: 46,
      decoration: BoxDecoration(
          // color: global.colorLight,
          border: Border.all(color: grey, width: 1),
          borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.only(left: 18, right: 18, top: 6),
      child: Row(
        children: [
          Radio(
            activeColor: colorDark,
            value: 1,
            groupValue: id,
            onChanged: (val) {
              setState(() {
                radioButtonItem = 'Standard';
                id = 1;
                cusPriceV = false;
              });
            },
          ),
          Text(
            'Standard',
            style: new TextStyle(fontSize: 17.0, color: global.colorBlack1),
          ),
          Radio(
            activeColor: colorDark,
            value: 2,
            groupValue: id,
            onChanged: (val) {
              setState(() {
                radioButtonItem = 'Customize';
                id = 2;
                cusPriceV = true;
              });
            },
          ),
          Text(
            'Customize',
            style: new TextStyle(fontSize: 17.0, color: global.colorBlack1),
          ),
        ],
      ),
    );
  }

  radioButtonOfMeasurement() {
    return Container(
      // height: 46,
      decoration: BoxDecoration(
          // color: global.colorLight,
          border: Border.all(color: grey, width: 1),
          borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.only(left: 18, right: 18, top: 6),
      child: Column(
        children: [
          Row(
            children: [
              Radio(
                activeColor: colorDark,
                value: 1,
                groupValue: idMeas,
                onChanged: (val) {
                  setState(() {
                    radioButtonItemMeas = 'KG Kilogram';
                    idMeas = 1;
                    _unit = "Gram";
                    qntGm = ["250", "500", "750", "1000"];
                  });
                },
              ),
              Text(
                'KG Kilogram',
                style: new TextStyle(fontSize: 17.0, color: global.colorBlack1),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                activeColor: colorDark,
                value: 2,
                groupValue: idMeas,
                onChanged: (val) {
                  setState(() {
                    radioButtonItemMeas = 'Piece';
                    idMeas = 2;
                    _unit = radioButtonItemMeas;
                    qntGm = ["1", "3", "5", "10"];
                  });
                },
              ),
              Text(
                'Piece',
                style: new TextStyle(fontSize: 17.0, color: global.colorBlack1),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                activeColor: colorDark,
                value: 3,
                groupValue: idMeas,
                onChanged: (val) {
                  setState(() {
                    radioButtonItemMeas = 'Litre';
                    idMeas = 3;
                    _unit = radioButtonItemMeas;
                    qntGm = ["1", "3", "5", "10"];
                  });
                },
              ),
              Text(
                'Litre',
                style: new TextStyle(fontSize: 17.0, color: global.colorBlack1),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String removeLastAndFirst(String string) {
    return string.toString().substring(1, string.length - 1);
  }
}
