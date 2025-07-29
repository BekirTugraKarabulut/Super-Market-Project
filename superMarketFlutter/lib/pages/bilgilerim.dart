import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Bilgilerim extends StatefulWidget {

  var username;

  Bilgilerim({required this.username});

  @override
  State<Bilgilerim> createState() => _BilgilerimState();
}

class _BilgilerimState extends State<Bilgilerim> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new_rounded , color: Colors.white,)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text("Profil Bilgilerim" , style: TextStyle(color: Colors.white , fontFamily: "BebasNeue"),),
      ),
    );
  }
}
