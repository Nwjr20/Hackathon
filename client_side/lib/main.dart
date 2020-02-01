import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "custom_widgets.dart" as customWidgets;
import "globals.dart" as globals;
import 'package:http/http.dart' as http;
import 'package:random_string/random_string.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: globals.banner,
      title: 'Hackathon Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => MyHomePage(title: 'Hackathon Project'),
        '/form': (context) => FormPage(),
        '/thankyou': (context) => ThankYou(),
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
  TextEditingController _medicationsController = TextEditingController();
  
  //  String text = _symptomController.text;
  //TextEditingController _paincontroller = TextEditingController();

  // Add a symptom to the symptoms list
  void _addSymptom(){
    //customWidgets.InputBox();
    setState(() {});
    showDialog(context: context, builder: (context) => customWidgets.InputBox("Add your symptom"), barrierDismissible: false);
  }

  String fromArrayToString(List<String> array){
    String content = ",";
    for(int i; i<array.length;i++){
      content = content + array[i] + ",";
    }
    return content;
  }


  Future<void> _onClick() async {
    String rand_strign = randomString(15);
    DateTime now = new DateTime.now();
    DateTime time = new DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
    print("The pain scale is set at: $_painScale");
    print("The time is set at: $time");
    print("The medications listed are: $_medicationsController.text");
    print(globals.symptoms);
    print("Random user string is: $rand_strign")
    //globals.symptoms is a list of strings
     var response = await http.post(
      "http://3.215.200.88/", 
      body: {}
      );
     

    if (response.statusCode == 200){
      print("We good...");
      // Clear out the text field when finished
      _medicationsController.clear();
      globals.symp = [];
      globals.symptoms = [];
      // Dismiss the keyboard
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    } else {
      // The message did not send
      print("Error, the message did NOT SEND");
    }
    // Then change the menu screen out to the main view
    Navigator.pushNamed(context, '/thankyou');
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
            // const RoundedButton(this.title, this.onPressed, this.fontSize, this.width, this.height, this.color);
            customWidgets.RoundedButton("Add Symptom", _addSymptom, 15, 25, 25, Colors.lightBlue),
            CustomScrollView(
              shrinkWrap: true,
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.all(20.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      globals.symp,
                    ),
                  ),
                ),
              ],
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
            SizedBox(height: 50,), 
            // Submit button
            customWidgets.RoundedButton("Submit", _onClick, 20, 50, 50, Colors.lightBlue),
          ],
          )
        )
    );
  }
}

class ThankYou extends StatefulWidget{
  @override
  ThankYouState createState() => ThankYouState();
}

class ThankYouState extends State<ThankYou>{
  String waittime = "";
  Future<void> _getwaittime() async {
    var request = await http.get("http://3.215.200.88/h/get_wait_time.php");
    if (request.statusCode == 200){
      setState(() {
        waittime = request.body;
      });
    } else if (request.statusCode == 404){
      setState(() {
        waittime = "Server error -- not found";
      });
    }
    
  }

  @override
  Widget build (BuildContext context){
    _getwaittime();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50,),
            Text(
              "You are signed in! Please wait for further instructions... \n\n\nYour estimated wait time is: $waittime",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ], 
        ),
      ),
    );
  }
}


//NDEFMessage message = await NFC.readNDEF(once: true).first;
//print(message.payload);