import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:login/SecondPage.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login",
      home: abc(),
    );
  }
}
class abc extends StatefulWidget {
  const abc({Key? key}) : super(key: key);

  @override
  _abcState createState() => _abcState();
}

class _abcState extends State<abc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image(image: NetworkImage("https://c4.wallpaperflare.com/wallpaper/1013/65/282/abstract-cube-cyan-purple-wallpaper-preview.jpg"),
            fit: BoxFit.cover,
            color: Colors.black45,
            colorBlendMode: BlendMode.darken,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                child: Theme(
                  data: ThemeData(
                      brightness: Brightness.light,
                      primarySwatch: Colors.cyan,
                      inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(
                              color: Colors.cyanAccent
                          )
                      )
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20
                          ),
                          decoration: InputDecoration(
                            labelText: "Enter Email",
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        TextField(
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20
                          ),
                          decoration: InputDecoration(
                              labelText: "Enter Password"
                          ),
                          obscureText: true,
                          keyboardType: TextInputType.text,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(9.0),
                    child: ElevatedButton(
                      child: Text("Login"),
                      onPressed: ()=>{},
                    ),
                  ),
                  ElevatedButton(
                    child: Text("Register"),
                    onPressed: ()
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondP()),
                      );
                    },
                  ),
                ],
              )
            ],
          )
        ],
      )
    );
  }
}
