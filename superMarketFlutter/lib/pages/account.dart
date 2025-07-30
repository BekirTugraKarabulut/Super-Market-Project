import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supermarketproject/pages/anasayfa.dart';
import 'package:supermarketproject/pages/begenilenler.dart';
import 'package:supermarketproject/pages/bilgilerim.dart';
import 'package:http/http.dart' as http;

class Account extends StatefulWidget {

  var username;

  Account({required this.username});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {

  Future<Map<String,dynamic>> bilgileriGetir() async {

    final accessTokenPrefs = await SharedPreferences.getInstance();
    final accessToken = accessTokenPrefs.getString("accessToken");

    final url = Uri.parse("http://10.0.2.2:8088/kullanici/${widget.username}");

    final response = await http.get(

      url,
      headers:
              {
                "Content-Type" : "application/json",
                "Authorization" : "Bearer $accessToken"
              }
    );

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw Exception("Sistemsel bir hata oluştu !");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa(username: widget.username)));
            }, icon: Icon(Icons.home , color: Colors.white, size: 29,)),
          )
        ],
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new_rounded , color: Colors.white,)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text("Hesap" , style: TextStyle(color: Colors.white , fontFamily: "BebasNeue"),),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              FutureBuilder<Map<String,dynamic>>(
                  future: bilgileriGetir(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return CircularProgressIndicator();
                    }

                    if(snapshot.hasData){
                      var bilgi = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Text(bilgi["kullaniciAd"] , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontSize: 20),),
                      );

                    }

                    else{
                      return const CircularProgressIndicator();
                    }
                  },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Lottie.asset("asset/UserAccount.json" , width: 200 , height: 200),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Begenilenler(username: widget.username))),
                  child: Container(
                    width: 250,
                    height: 70,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Beğendiklerim" , style: TextStyle(fontSize: 25),),
                        Icon(Icons.favorite ,color: Colors.red, size: 30,)
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Bilgilerim(username: widget.username))),
                  child: Container(
                    width: 250,
                    height: 70,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 60),
                          child: Text("Bilgilerim" , style: TextStyle(fontSize: 25),),
                        ),
                        Icon(Icons.account_circle ,color: Colors.black, size: 30,)
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 320),
                child: Text("2003'den beri sizlerle" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
