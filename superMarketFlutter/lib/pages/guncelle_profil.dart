import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:supermarketproject/pages/anasayfa.dart';
import 'package:supermarketproject/pages/bilgilerim.dart';

class GuncelleProfil extends StatefulWidget {

  var username;

  GuncelleProfil({required this.username});

  @override
  State<GuncelleProfil> createState() => _GuncelleProfilState();
}

class _GuncelleProfilState extends State<GuncelleProfil> {

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

  Future<Map<String,dynamic>> bilgileriGuncelle(var adKontrol, var telefonNo , var adres) async {

    final accessTokenPrefs = await SharedPreferences.getInstance();
    final accessToken = accessTokenPrefs.getString("accessToken");
    
    final url = Uri.parse("http://10.0.2.2:8088/kullanici/guncelle/${widget.username}");

    final response = await http.put(

      url,
      headers:
              {
                "Content-Type" : "application/json",
                "Authorization" : "Bearer $accessToken"
              },
      body: jsonEncode
                      (
                        {
                          "kullaniciAd" : adKontrol,
                          "telefonNo" : telefonNo,
                          "adres" : adres
                        }
                      )
          );

    if(response.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Bilgileriniz Güncellendi"),
        ),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => Bilgilerim(username: widget.username)));
      return jsonDecode(response.body);
    }else{
      throw Exception("Sistemsel bir hata oluştu !");
    }

  }

  var adKontrol = TextEditingController();
  var telefonNoKontrol = TextEditingController();
  var adresKontrol = TextEditingController();

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
        title: Text("Profil Güncelle" , style: TextStyle(color: Colors.white , fontFamily: "BebasNeue"),),
      ),
      body: SingleChildScrollView(
        child: Center(
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
                      var kullaniciBilgileri = snapshot.data;
                      return Center(
                        child: Column(
                          children: [
                            Text("Kullanıcı Ad" ,style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold, fontSize: 15),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.black,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),
                                    controller: adKontrol,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText : kullaniciBilgileri?["kullaniciAd"],
                                      hintStyle: TextStyle(color: Colors.white),
                                      contentPadding: EdgeInsets.only(top: 12),
                                      suffixIcon: Icon(Icons.account_circle , color: Colors.white,),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white)
                                      ),
                                      disabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white)
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white)
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text("Telefon Numarası" ,style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold, fontSize: 15),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.black,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),
                                    controller: telefonNoKontrol,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText : kullaniciBilgileri?["telefonNo"],
                                      hintStyle: TextStyle(color: Colors.white),
                                      contentPadding: EdgeInsets.only(top: 12),
                                      suffixIcon: Icon(Icons.phone , color: Colors.white,),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white)
                                      ),
                                      disabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white)
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white)
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text("Adres(Mevcut)" ,style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold, fontSize: 15),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.black,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),
                                    controller: adresKontrol,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText : kullaniciBilgileri?["adres"],
                                      hintStyle: TextStyle(color: Colors.white),
                                      contentPadding: EdgeInsets.only(top: 12),
                                      suffixIcon: Icon(Icons.home_work_rounded , color: Colors.white,),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white)
                                      ),
                                      disabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white)
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white)
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),onPressed: (){
                                      if(adKontrol.text.isEmpty){
                                        adKontrol.text = kullaniciBilgileri?["kullaniciAd"];
                                      }
                                      if(telefonNoKontrol.text.isEmpty){
                                        telefonNoKontrol.text = kullaniciBilgileri?["telefonNo"];
                                      }
                                      if(adresKontrol.text.isEmpty){
                                        adresKontrol.text = kullaniciBilgileri?["adres"];
                                      }
                                       bilgileriGuncelle(adKontrol.text, telefonNoKontrol.text, adresKontrol.text);
                              }, child: Text("Güncelle",style: TextStyle(color: Colors.white),)),
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
      ),
    );
  }
}
