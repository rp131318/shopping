import 'package:flutter/material.dart';
import '../globalVariable.dart';

class ButtonWidget extends StatelessWidget {
  final BuildContext context;
  final String buttonText;
  final double left;
  final double right;
  final double fontSize;
  final double width;
  final Function function;
  bool border = false;

  ButtonWidget(this.context, this.buttonText, this.function,
      [this.border = false,
      this.left = 14,
      this.right = 14,
      this.width = 46,
      this.fontSize = 18]);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => function(),
      child: Container(
          width: double.infinity,
          height: width,
          decoration: BoxDecoration(
              color: !border ? colorDark : Colors.transparent,
              border: Border.all(
                  color: border ? colorDark : Colors.transparent,
                  width: border ? 2 : 0),
              borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.only(left: left, right: right),
          child: Center(
              child: Text(
            buttonText,
            style: TextStyle(
                fontSize: fontSize, color: !border ? Colors.white : colorDark),
          ))),
    );
  }
}
