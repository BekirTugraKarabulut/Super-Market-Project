import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supermarketproject/pages/anasayfa.dart';
import 'package:http/http.dart' as http;

class KartBilgiler extends StatefulWidget {

  var username;

  KartBilgiler({required this.username});

  @override
  State<KartBilgiler> createState() => _KartBilgilerState();
}

class _KartBilgilerState extends State<KartBilgiler> {

  var kartNumarasiKontrol = TextEditingController();
  var cvvKontrol = TextEditingController();
  var kartYiliKontrol = TextEditingController();

  Future<void> kartEkle(String kartNo, String yil , String cvv) async {

    final accessTokenPrefs = await SharedPreferences.getInstance();
    final accessToken = accessTokenPrefs.getString("accessToken");

    final url = Uri.parse("http://10.0.2.2:8088/kartEkle");

    final response = await http.post(

      url,
      headers:
              {
                "Content-Type" : "application/json",
                "Authorization" : "Bearer $accessToken"
              },
      body: jsonEncode
                (
                  {
                    "kartNumarasi" : kartNo,
                    "gecerlilikTarihi" : yil,
                    "cvv" : cvv,
                    "kullanici" :
                        {
                          "username" : widget.username
                        }
                  }
                )
      );

      if(kartNo.isEmpty && yil.isEmpty && cvv.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Lütfen Tüm Alanları Doldurunuz !"),
          action: SnackBarAction(label: "Tamam", onPressed: (){}),
          )
        );
        return;
      }

      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else{
        throw Exception("Sistemsel bir hata oluştu !");
      }

  }

  Future<void> satinAlinanlarEkle(String username) async {

    final accessTokenPrefs = await SharedPreferences.getInstance();
    final accessToken = accessTokenPrefs.getString("accessToken");
    
    final url = Uri.parse("http://10.0.2.2:8088/satin-alinanlar/$username");

    final response = await http.post(

      url,
      headers:
              {
                "Content-Type" : "application/json",
                "Authorization" : "Bearer $accessToken"
              }
      );

      if(response.statusCode == 200){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Satın Alındı."),
          action: SnackBarAction(label: "Tamam", onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa(username: widget.username)));
          }),
          )
        );
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
        title: Text("Satın Al" , style: TextStyle(color: Colors.white , fontFamily: "BebasNeue"),),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Lottie.asset("asset/Credit Card.json"),
              Padding(
                padding: const EdgeInsets.only(top: 35),
                child: Text("Kart Numarası",style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: TextField(
                    controller: kartNumarasiKontrol,
                    style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Icon(Icons.credit_card , color: Colors.white,),
                      ),
                      contentPadding: EdgeInsets.only(left: 8 , top: 12),
                      hintText: "Kart Numarası",
                      hintStyle: TextStyle(color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                      Column(
                        children: [
                          Text("Kart Yılı" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontSize: 15),),
                          SizedBox(
                            width: 200,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              child: TextField(
                                controller: kartYiliKontrol,
                                style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Icon(Icons.date_range , color: Colors.white,),
                                  ),
                                  contentPadding: EdgeInsets.only(left: 8 , top: 12),
                                  hintText: "aa/yy",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)
                                  ),
                                  disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    Column(
                      children: [
                        Text("CVV" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontSize: 15),),
                        SizedBox(
                          width: 200,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: TextField(
                              obscureText: true,
                              controller: cvvKontrol,
                              style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Icon(Icons.security , color: Colors.white,),
                                ),
                                contentPadding: EdgeInsets.only(left: 8 , top: 12),
                                hintText: "***",
                                hintStyle: TextStyle(color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)
                                ),
                                disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35),
                child: SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green),onPressed: (){
                        kartEkle(kartNumarasiKontrol.text,kartYiliKontrol.text, cvvKontrol.text);
                        satinAlinanlarEkle(widget.username);
                  }, child: Text("Satın Al",style: TextStyle(color: Colors.white),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
