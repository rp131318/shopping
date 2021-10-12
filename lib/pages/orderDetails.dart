import 'package:flutter/material.dart';
import 'package:shopping/widget/button_widget.dart';

import '../globalVariable.dart';

// ignore: camel_case_types
class orderDetails extends StatefulWidget {
  @override
  _orderDetailsState createState() => _orderDetailsState();
}

// ignore: camel_case_types
class _orderDetailsState extends State<orderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 33, left: 18),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Active Order",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: colorDark),
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
                      ImageLink.storeListingImage,
                      width: 88,
                      height: 88,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "productName",
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "246" + rupees,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
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
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: colorDark),
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Order Shipped",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            trailing: ButtonWidget(
                context, "Pending", pendingFun, true, 14, 14, 86, 36),
            leading: Icon(Icons.arrow_forward_ios_rounded),
            horizontalTitleGap: 0,
          ),
          ListTile(
            title: Text(
              "Order Shipped",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            trailing: ButtonWidget(
                context, "Pending", pendingFun, true, 14, 14, 86, 36),
            leading: Icon(Icons.arrow_forward_ios_rounded),
            horizontalTitleGap: 0,
          ),
          ListTile(
            title: Text(
              "Order Shipped",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            trailing: ButtonWidget(
                context, "Pending", pendingFun, true, 14, 14, 86, 36),
            leading: Icon(Icons.arrow_forward_ios_rounded),
            horizontalTitleGap: 0,
          ),
          ListTile(
            title: Text(
              "Order Shipped",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            trailing: ButtonWidget(
                context, "Pending", pendingFun, true, 14, 14, 86, 36),
            leading: Icon(Icons.arrow_forward_ios_rounded),
            horizontalTitleGap: 0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18, left: 18),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Order Details",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: colorDark),
              ),
            ),
          ),
        ],
      ),
    );
  }

  pendingFun() {}
}
