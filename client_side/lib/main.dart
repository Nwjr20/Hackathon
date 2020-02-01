import 'package:flutter/material.dart';
import "custom_widgets.dart" as customWidgets;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hackathon Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => MyHomePage(title: 'Hackathon Project'),
        '/form': (context) => FormPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String content = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome! Please Check-In!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                
              ),
            ),
            SizedBox(
              height: 200
            ),
            Text(
              content,
            ),
            customWidgets.RoundedButton(
              "Check-In",
              (){
                Navigator.pushNamed(context, '/form');
              },
              20,
              250,
              70,
              Colors.lightBlue,
            ),
          ],
        ),
      ),
    );
  }
}


class FormPage extends StatefulWidget {
  @override
  FormPageState createState() => FormPageState();
}

class FormPageState extends State<FormPage>{
  int _painScale = 0;
  TextEditingController _symptomController = TextEditingController();
  TextEditingController _medicationsController = TextEditingController();
  //  String text = _symptomController.text;
  //TextEditingController _paincontroller = TextEditingController();
  Future<void> _onClick() async {
    // Get the text from the entry
    // Check to make sure that the message is not empty
    /*if (text == '' || text == ' '){
      message = "Please enter your message";
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      return 1;
    } else {
      // Check if the value of _last message is text, this prevents unnesssiary requests
      // from going to the web server
      if (_lastMessage == text && _lastPick == _selectedMirror){
        print("Did not send message ");
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        return 1;
      } else {
        _lastMessage = text;
        _lastPick = _selectedMirror;
      }
    }*/
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50,),
            Text("Enter your information Below!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              ),
            ),
            // DropDown Button
            SizedBox(height: 50,),
            Row(
              children: <Widget>[
                SizedBox(width: 20,),
                Text(
                  "Select your pain from 1-10! \nWith 10 being the most pain",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 50,),
                DropdownButton<int>(
                  items: <int>[1,2,3,4,5,6,7,8,9,10].map((int value) {
                  return new DropdownMenuItem<int>(
                    value: value,
                    child: new Text(value.toString()),
                    );
                  }).toList(),
                  hint: Text(_painScale.toString()),
                  onChanged: (value) {
                    _painScale = value;
                    this.setState(() {});
                  },
                ),
              ],),
            SizedBox(
              height: 50
            ), 
            TextField(
              textAlign: TextAlign.center,
              autocorrect: true,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              controller: _symptomController,
              decoration: InputDecoration(
                hintText: 'Describe your symptoms here...',
              ),
            ),
            SizedBox(height: 30,),
            TextField(
              textAlign: TextAlign.center,
              autocorrect: false,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.multiline,
              maxLines: 1,
              controller: _medicationsController,
              decoration: InputDecoration(
                hintText: 'What medications do you take?',
              ),
            ),
          ],
          )
        )
    );
  }
}


//NDEFMessage message = await NFC.readNDEF(once: true).first;
//print(message.payload);