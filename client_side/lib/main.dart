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
  TextEditingController _namecontroller = TextEditingController();
  //TextEditingController _paincontroller = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20,),
            Text("Enter your information Below!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              ),
            ),
            // DropDown Button
            Row(
              children: <Widget>[
                SizedBox(width: 50,),
                Text("Select your pain from 1-10"),
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
            

          ],
          )
          ,)
    );
  }
}


//NDEFMessage message = await NFC.readNDEF(once: true).first;
//print(message.payload);