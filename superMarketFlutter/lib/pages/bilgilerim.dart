import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:supermarketproject/pages/anasayfa.dart';
import 'package:supermarketproject/pages/guncelle_profil.dart';

class Bilgilerim extends StatefulWidget {

  var username;

  Bilgilerim({required this.username});

  @override
  State<Bilgilerim> createState() => _BilgilerimState();
}

class _BilgilerimState extends State<Bilgilerim> {

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
        title: Text("Profil Bilgilerim" , style: TextStyle(color: Colors.white , fontFamily: "BebasNeue"),),
      ),
      body: Center(
        child: Column(
          children: [
            Lottie.asset("asset/SecuritySystem.json" , width: 320 ,height: 320),
            FutureBuilder<Map<String,dynamic>>(
                future: bilgileriGetir(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const CircularProgressIndicator();
                  }
                  if(snapshot.hasData){
                      var kullaniciBilgileri = snapshot.data!;
                      return Center(
                        child: Column(
                          children: [
                            Text("E-Mail" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontSize: 18),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(kullaniciBilgileri["username"],style: TextStyle(fontSize: 18),),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 220),
                                        child: Icon(Icons.mail),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text("Kullanıcı Ad" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontSize: 18),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(kullaniciBilgileri["kullaniciAd"],style: TextStyle(fontSize: 18),),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 200),
                                        child: Icon(Icons.account_circle),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text("Telefon No" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontSize: 18),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(kullaniciBilgileri["telefonNo"],style: TextStyle(fontSize: 18),),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 220),
                                        child: Icon(Icons.call),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text("Adres" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontSize: 18),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(kullaniciBilgileri["adres"],style: TextStyle(fontSize: 18),),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 180),
                                        child: Icon(Icons.home_work_rounded),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 35),
                              child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => GuncelleProfil(username: widget.username)));
                              }, child: Text("Güncelle",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),)),
                            )
                          ],
                        ),
                      );
                  }else{
                    return const CircularProgressIndicator();
                  }
                },
            )
          ],
        ),
      ),
    );
  }
}
