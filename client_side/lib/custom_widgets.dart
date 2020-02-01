import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "globals.dart" as globals;

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

class InputBox extends StatelessWidget{
  String title;
  List<Widget> array;
  TextEditingController _symptomController = TextEditingController();
  InputBox(String title){
    this.title = title;
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    return AlertDialog(
      title: TextField(
              textAlign: TextAlign.center,
              autocorrect: false,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.multiline,
              maxLines: 1,
              controller: _symptomController,
              decoration: InputDecoration(
                hintText: 'Add a symptom',
              ),
      ),
      actions: <Widget>[
        FlatButton(child: Text("Enter Symptom"),
        onPressed: (){
          Navigator.pop(context);
          // Make sure that the box is not empty 
          if (_symptomController.text.isEmpty){
            
          } else {
            if (globals.emergencies.contains(_symptomController.text.toLowerCase())){
              // Tell them to get immediate attention
              showDialog(context: context, builder: (context) => EmergencyDialog(), barrierDismissible: false);
            } else {
              globals.symp.add(Text(_symptomController.text));
              globals.symptoms.add(_symptomController.text);
            }
            
          }
        },
        ),
      ],
    );
  }
}


class EmergencyDialog extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    return AlertDialog(
      title: Text(
        "Emergency!! Get immediate medical attention right away!"
      ),
      actions: <Widget>[
        FlatButton(child: Text("I am going to get help right away from a staff member"),
        onPressed: (){
          Navigator.pop(context);
          // Make sure that the box is not empty 
        }
        ),
      ],
    );
  }
}

