import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supermarketproject/pages/anasayfa.dart';
import 'package:http/http.dart' as http;
import 'package:supermarketproject/pages/kart_bilgiler.dart';

class Sepet extends StatefulWidget {

  var username;

  Sepet({required this.username});

  @override
  State<Sepet> createState() => _SepetState();
}

class _SepetState extends State<Sepet> {

  Set<int> sepettekiler = {};

  Future<List<dynamic>> sepettekiUrunler() async {
    
    final accessTokenPrefs = await SharedPreferences.getInstance();
    final accessToken = accessTokenPrefs.getString("accessToken");
    
    final url = Uri.parse("http://10.0.2.2:8088/sepet/${widget.username}");

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
  
  Future<double> sepetTutari(String username) async {
    
    final accessTokenPrefs = await SharedPreferences.getInstance();
    final accessToken = accessTokenPrefs.getString("accessToken");
    
    final url = Uri.parse("http://10.0.2.2:8088/sepet/toplamtutar/$username");

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
      throw Exception("Sistemsel hata oluştu !");
    }
  }
  
  Future<bool> deleteSepetUrun(String username , int urunId) async {
    
    final accessTokenPrefs = await SharedPreferences.getInstance();
    final accessToken = accessTokenPrefs.getString("accessToken");
    
    final url = Uri.parse("http://10.0.2.2:8088/sepet/sil/$username/$urunId");

    final response = await http.delete(

      url,
      headers:
              {
                "Content-Type" : "application/json",
                "Authorization" : "Bearer $accessToken"
              }
    );

    if(response.statusCode == 200){
      return true;
    }else{
      return false;
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
        title: Text("Sepetim" , style: TextStyle(color: Colors.white , fontFamily: "BebasNeue"),),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              FutureBuilder<List<dynamic>>(
                  future: sepettekiUrunler(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const CircularProgressIndicator();
                    }
                    if(snapshot.hasData){
                      var sepettekiUrunler = snapshot.data;
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: sepettekiUrunler!.length,
                          itemBuilder: (context, index) {
                            var sepettekiUrun = sepettekiUrunler[index];
                            var urun = sepettekiUrun["urunler"];
                            return Card(
                              child: Column(
                                children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset("resimler/${urun["urunResmi"]}",width: 100,height: 100,),
                                      Text("Ürün Adi : " + urun["urunAdi"],style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                                      Text("Fiyatı : " + urun["urunFiyati"].toString() + " ₺" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                                      IconButton(onPressed: () async {
                                          int urunId = urun["urunId"];
                                          bool result = await deleteSepetUrun(widget.username, urunId);
                                          if(result){
                                            setState(() {
                                              sepettekiUrunler.removeAt(index);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text("Ürün Sepetten Kaldırıldı !"),
                                                    action: SnackBarAction(label: "Tamam", onPressed: (){}),
                                                  )
                                              );
                                            });
                                          }
                                      }, icon: Icon(Icons.clear , color: Colors.red,))
                                    ],
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
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: FutureBuilder<double>(
                    future: sepetTutari(widget.username),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const CircularProgressIndicator();
                      }
                      if(snapshot.hasData){
                        var tutar = snapshot.data;
                        String hesap = tutar!.toStringAsFixed(2).toString();
                        return Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(8))
                            ),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Toplam Tutar : " , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold ),),
                                Column(
                                  children: [
                                    Text(hesap + " ₺" , style: TextStyle(color: Colors.blueAccent , fontWeight: FontWeight.bold , fontSize: 20),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }else{
                        return const CircularProgressIndicator();
                      }
                    },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green,),onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => KartBilgiler(username: widget.username)));
                  }, child: Text("Satın Al",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
