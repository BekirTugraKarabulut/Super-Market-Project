import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:supermarketproject/pages/anasayfa.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SatinAldiklarim extends StatefulWidget {

  var username;

  SatinAldiklarim({required this.username});

  @override
  State<SatinAldiklarim> createState() => _SatinAldiklarimState();
}

class _SatinAldiklarimState extends State<SatinAldiklarim> {

  Future<List<dynamic>> katlarimiGetir(String username) async {

    final accessTokenPrefs = await SharedPreferences.getInstance();
    final accessToken = accessTokenPrefs.getString("accessToken");
    
    final url = Uri.parse("http://10.0.2.2:8088/kartlariGetir/$username");

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

  Future<List<dynamic>> satinAldiklarim(String username) async {

    final accessTokenPrefs = await SharedPreferences.getInstance();
    final accessToken = accessTokenPrefs.getString("accessToken");

    final url = Uri.parse("http://10.0.2.2:8088/satin-alinanlar/getir/$username");

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
        title: Text("Kart ve Alınanlar" , style: TextStyle(color: Colors.white , fontFamily: "BebasNeue"),),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text("Kartlarım",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold , fontSize: 16),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: FutureBuilder<List<dynamic>>(
                    future: katlarimiGetir(widget.username),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const CircularProgressIndicator();
                      }
                      if(snapshot.hasData){
                        var kartlarimListesi = snapshot.data;
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: kartlarimListesi!.length,
                            itemBuilder: (context, index) {
                              var kartlarim = kartlarimListesi[index];
                              return Card(
                                child: Row(
                                  children: [
                                    Image.asset("resimler/visa-logo.jpeg",width: 100,height: 100,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 50),
                                      child: Column(
                                        children: [
                                          Text(" Kart No : " + kartlarim["kartNumarasi"],style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold , fontSize: 16),),
                                          Text("Kart Yılı : " + kartlarim["gecerlilikTarihi"],style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold , fontSize: 16),),
                                          Text("CVV : " + kartlarim["cvv"],style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold , fontSize: 16),)
                                        ],
                                      ),
                                    ),
        
                                  ],
                                ),
                              );
                            },
                        );
                      }else{
                        return const CircularProgressIndicator();
                      }
                    },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text("Satın Aldıklarım",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold , fontSize: 16),),
              ),
              FutureBuilder<List<dynamic>>(
                  future: satinAldiklarim(widget.username),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const CircularProgressIndicator();
                    }
                    if(snapshot.hasData){
                      var aldigimUrunlerList = snapshot.data;
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: aldigimUrunlerList!.length,
                          itemBuilder: (context, index) {
                            var urunler = aldigimUrunlerList[index];
                            var urun = urunler["urunler"];
                            return Card(
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset("resimler/${urun["urunResmi"]}",height: 150,width: 150,),
                                  Text(" " + urun["urunAdi"],style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                                  Text(" " + urun["urunFiyati"].toString() + " ₺" ,style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),)
                                ],
                              ),
                            );
                          },
                      );
                    }else{
                     return Padding(
                       padding: const EdgeInsets.only(top: 150),
                       child: Column(
                         children: [
                           Icon(Icons.search,size: 35,color: Colors.black,),
                           Text("Henüz ürün almadınız.",style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),)
                         ],
                       ),
                     );
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
