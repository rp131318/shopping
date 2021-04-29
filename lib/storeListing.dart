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
import 'globalVariable.dart' as global;
import 'homePage.dart';

class storeListing extends StatefulWidget {
  @override
  _storeListingState createState() => _storeListingState();
}

class _storeListingState extends State<storeListing> {
  File _image;
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final cateController = TextEditingController();
  final expController = TextEditingController();
  final locController = TextEditingController();
  final picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String link;
  String milli = DateTime.now().millisecondsSinceEpoch.toString();

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
            Hero(tag: "stList", child: Image.asset("images/store.jpg")),
            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Food Details",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: global.colorBlack1),
                ),
              ),
            ),
            Container(
              height: 46,
              decoration: BoxDecoration(
                  color: global.colorLight,
                  border: Border.all(color: global.colorBlack3, width: 2),
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.only(left: 14, right: 14, top: 22),
              child: TextField(
                style: TextStyle(color: global.colorBlack2, fontSize: 18),
                controller: nameController,
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText: "Food Name",
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            Container(
              height: 46,
              decoration: BoxDecoration(
                  color: global.colorLight,
                  border: Border.all(color: global.colorBlack3, width: 2),
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.only(left: 14, right: 14, top: 6),
              child: TextField(
                style: TextStyle(color: global.colorBlack2, fontSize: 18),
                controller: priceController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText: "Food Price",
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            Container(
              height: 46,
              decoration: BoxDecoration(
                  color: global.colorLight,
                  border: Border.all(color: global.colorBlack3, width: 2),
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.only(left: 14, right: 14, top: 6),
              child: TextField(
                style: TextStyle(color: global.colorBlack2, fontSize: 18),
                controller: cateController,
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText: "Food Category ",
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            InkWell(
              onTap: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime.now(),
                    maxTime: DateTime.now().add(const Duration(days: 100)),
                    theme: DatePickerTheme(
                        // headerColor: global,
                        backgroundColor: Colors.white,
                        itemStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        cancelStyle:
                            TextStyle(color: Colors.black, fontSize: 16),
                        doneStyle:
                            TextStyle(color: global.colorDark, fontSize: 16)),
                    onChanged: (date) {
                  print('change $date in time zone ' +
                      date.timeZoneOffset.inHours.toString());
                  setState(() {
                    expController.text =
                        date.toString().split(" ")[0].toString();
                  });
                }, onConfirm: (date) {
                  print('confirm $date');
                  setState(() {
                    expController.text =
                        date.toString().split(" ")[0].toString();
                  });
                }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                    color: global.colorLight,
                    border: Border.all(color: global.colorBlack3, width: 2),
                    borderRadius: BorderRadius.circular(8)),
                margin: EdgeInsets.only(left: 14, right: 14, top: 6),
                child: TextField(
                  enabled: false,
                  style: TextStyle(color: global.colorBlack2, fontSize: 18),
                  controller: expController,
                  textAlign: TextAlign.center,
                  decoration: new InputDecoration(
                      border: InputBorder.none,
                      hintText: "Food Expiration",
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
            ),
            Container(
              height: 46,
              decoration: BoxDecoration(
                  color: global.colorLight,
                  border: Border.all(color: global.colorBlack3, width: 2),
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.only(left: 14, right: 14, top: 6),
              child: TextField(
                style: TextStyle(color: global.colorBlack2, fontSize: 18),
                controller: locController,
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText: "Location",
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            InkWell(
              onTap: () {
                chooseImage();
              },
              child: _image == null
                  ? Container(
                      height: 111,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: global.colorLight,
                          border:
                              Border.all(color: global.colorBlack3, width: 2),
                          borderRadius: BorderRadius.circular(8)),
                      margin: EdgeInsets.only(left: 14, right: 14, top: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 66,
                            width: 88,
                            child: Icon(
                              Icons.image,
                              color: global.colorDark,
                              size: 66,
                            ),
                          ),
                          Text(
                            "Choose Food Image",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          )
                        ],
                      ),
                    )
                  : Container(
                      height: 222,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: global.colorLight,
                          border:
                              Border.all(color: global.colorBlack3, width: 2),
                          borderRadius: BorderRadius.circular(8)),
                      margin: EdgeInsets.only(left: 14, right: 14, top: 6),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.file(
                            _image,
                            height: 156,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              _image.path,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14, color: global.colorBlack1),
                            ),
                          )
                        ],
                      ),
                    ),
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
                      EdgeInsets.only(left: 14, right: 14, top: 6, bottom: 33),
                  child: Center(
                      child: Text(
                    "List Food Now",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ))),
            ),
          ],
        ),
      ),
    );
  }

  void listFoodNow() {
    if (nameController.text.length > 0 &&
        priceController.text.length > 0 &&
        cateController.text.length > 0 &&
        expController.text.length > 0 &&
        locController.text.length > 0 &&
        _image.path.toString().length > 0) {
      final snackBar = SnackBar(
          backgroundColor: Colors.green,
          content: Text("Food listing complete"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => homePage()));
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
      "c": cateController.text,
      "e": expController.text,
      "l": locController.text,
      "i": link.toString()
    });
  }
}
