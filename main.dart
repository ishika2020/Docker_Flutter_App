import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text("Docker Menu")),
          body: menuscreen(),
      ),
    );
  }
}

// ignore: camel_case_types
class menuscreen extends StatefulWidget{
  @override
  State<menuscreen> createState() => _menuscreen();
}

// ignore: camel_case_types
class _menuscreen extends State<menuscreen>{
  @override
  late String cm;
  late String data = "OUTPUT";
  void cgi() async {
    var r = await http.get(Uri.http("15.207.112.146","/cgi-bin/docker.py",{"x": cm}));
    data = r.body.toString();
    setState(() {
      data;
      print(data);
    });
  }

  Widget build(BuildContext context){

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[  
                ElevatedButton(
                  onPressed: (){
                    cm = "sudo docker ps -a";
                    cgi();
                  }, 
                  child: const Text("Container Info"),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                    backgroundColor: MaterialStateProperty.all(Colors.tealAccent),
                    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 22)),
                  )
                ),

                ElevatedButton(
                  onPressed: (){
                    cm = "sudo docker ps -a";
                    cgi();
                  }, 
                  child: const Text("Run Container"),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                    backgroundColor: MaterialStateProperty.all(Colors.tealAccent),
                    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 22)),
                  )
                ), 
                ElevatedButton(
                  onPressed: (){
                    cm = "Stop Container";
                    cgi();
                  }, 
                  child: const Text("Stop Container"),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                    backgroundColor: MaterialStateProperty.all(Colors.tealAccent),
                    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 22)),
                  )
                ),
              ]
            )
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 50,right: 50,top: 20, bottom: 20),
              width: 380,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.teal,
                boxShadow: [BoxShadow(
                  color: Colors.grey,
                  offset: const Offset(5.0, 5.0),
                  blurRadius: 11,
                  spreadRadius: 4)
                ]   
              ),
              child: Center(
                child: ListView(
                  children: [
                    Center(
                      child: Text(
                        "$data",
                        style: TextStyle(
                          fontSize: 18),
                      ),
                    )
                  ],
                ),
              )
            ),
          )
        ]              
      ) 
    );
  }
}
