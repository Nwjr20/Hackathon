import "package:flutter/material.dart";

class RoundedButton extends StatelessWidget {
  // This class makes the standard type of button we use for the main page
  final String title;
  final Function onPressed;
  final double fontSize;
  final double height;
  final double width;
  final MaterialColor color;
  // Main constructor
  const RoundedButton(this.title, this.onPressed, this.fontSize, this.width, this.height, this.color);
  @override
  Widget build(BuildContext context){
    return ButtonTheme(
    minWidth: width,
    height: height,
    child:
      RaisedButton(
        child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          ),
        ),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
          side: BorderSide(color: color)
          ),
        )
    );
  }
}