import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Begenilenler extends StatefulWidget {

  var username;

  Begenilenler({required this.username});

  @override
  State<Begenilenler> createState() => _BegenilenlerState();
}

class _BegenilenlerState extends State<Begenilenler> {

  Set<int> begendiklerim = {};

  Future<List<dynamic>> begenilenleriGetir() async {

    final accessTokenPrefs = await SharedPreferences.getInstance();
    final accessToken = accessTokenPrefs.getString("accessToken");
    
    final url = Uri.parse("http://10.0.2.2:8088/begen/${widget.username}");

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

  Future<bool> begenDelete(int urunId , String username) async{

    final accessTokenPrefs = await SharedPreferences.getInstance();
    final accessToken = accessTokenPrefs.getString("accessToken");

    final url = Uri.parse("http://10.0.2.2:8088/begen/sil/$urunId/$username");

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
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new_rounded , color: Colors.white,)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text("Beğendiklerim" , style: TextStyle(color: Colors.white , fontFamily: "BebasNeue"),),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              FutureBuilder<List<dynamic>>(
                  future: begenilenleriGetir(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      var begenilerListesi = snapshot.data;
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: begenilerListesi!.length,
                            itemBuilder: (context, index) {
                              var begenilenUrunler = begenilerListesi[index];
                              var urun = begenilenUrunler["urunler"];
                              return Card(
                                child: Column(
                                  children: [
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset("resimler/${urun["urunResmi"]}",width: 180,height: 150,),
                                        Column(
                                          children: [
                                            Text("Ürün Adı : " + urun["urunAdi"] , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                                            Text("Ürün Fiyatı : " + urun["urunFiyati"].toString() + " ₺" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 30),
                                        child: IconButton(onPressed: () async {

                                         int urunId = urun["urunId"];

                                         bool response = await begenDelete(urunId, widget.username);
                                         if(response){
                                           setState(() {
                                             begenilerListesi.removeAt(index);
                                             ScaffoldMessenger.of(context).showSnackBar(
                                               SnackBar(content: Text("Ürünü favorilerden kaldırdınız."),
                                               action: SnackBarAction(label: "Tamam", onPressed: (){}),
                                               )
                                             );
                                           });
                                         }
                                        }, icon: Icon(Icons.clear,color: Colors.red,)),
                                      )
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
