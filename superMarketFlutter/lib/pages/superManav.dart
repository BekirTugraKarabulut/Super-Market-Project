import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Supermanav extends StatefulWidget {

  var username;

  Supermanav({required this.username});

  @override
  State<Supermanav> createState() => _SupermanavState();
}

class _SupermanavState extends State<Supermanav> {

  Set<int> begendiklerim = {};

  var aramaKontrol = TextEditingController();
  
  Future<List<dynamic>> meyvelerListesi(int indeks) async{

    final accessPrefs = await SharedPreferences.getInstance();
    final accessToken = accessPrefs.getString("accessToken");

    final url = Uri.parse("http://10.0.2.2:8088/urun/$indeks");

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
      throw Exception("Bilgiler Gelmedi !");
    }
  }

  Future<bool> begenEkle(int urunId) async {

    final accessTokenPref = await SharedPreferences.getInstance();
    final accessToken = accessTokenPref.getString("accessToken");

    final url = Uri.parse("http://10.0.2.2:8088/begen/ekle");

    final response = await http.post(

      url,
      headers:
      {
        "Content-Type" : "application/json",
        "Authorization" : "Bearer $accessToken"
      },
      body: jsonEncode(
          {
            "kullanici" :
            {
              "username" : widget.username
            },
            "urunler" :
            {
              "urunId" : urunId
            }

          }
      ),
    );

    if(response.statusCode == 200){
      return true;
    }
    return false;
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

  Future<bool> sepeteEkleme(String username , int urunId) async {

    final accessTokenPrefs = await SharedPreferences.getInstance();
    final accessToken = accessTokenPrefs.getString("accessToken");

    final url = Uri.parse("http://10.0.2.2:8088/sepet/ekle");

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
              "kullanici" :
              {
                "username" : username
              },
              "urunler" :
              {
                "urunId" : urunId
              }
            }
        )
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
        title: Text("Super Manav" , style: TextStyle(color: Colors.white , fontFamily: "BebasNeue"),),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: aramaKontrol,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: "İstediğiniz Ürün..",
                        hintStyle: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.only(left: 8 , top: 13),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)
                        ),
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)
                        ),
                        suffixIcon: Icon(Icons.search , size: 25, color: Colors.black,)
                    ),
                  ),
                ),
              ),
            ),
            FutureBuilder<List<dynamic>>(
                future: meyvelerListesi(5),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    var meyvelerListe = snapshot.data;
                    return Expanded(
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          itemCount: meyvelerListe!.length,
                          itemBuilder: (context, index) {
                            var meyveler = meyvelerListe[index];
                            return Card(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(onPressed: () async {
                                        int urunId = meyveler["urunId"];
                                        if(begendiklerim.contains(urunId)){
                                          bool response = await begenDelete(urunId, widget.username);
                                          if(response){
                                            setState(() {
                                              begendiklerim.remove(urunId);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text("Ürün Beğeniden Kaldırıldı!"),
                                                action: SnackBarAction(label: "Tamam", onPressed: (){}),
                                                )
                                              );
                                            });
                                          }
                                        }else{
                                          bool response = await begenEkle(urunId);
                                          if(response){
                                            setState(() {
                                              begendiklerim.add(urunId);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text("Ürün Beğenildi."),
                                                    action: SnackBarAction(label: "Tamam", onPressed: (){}),
                                                  )
                                              );
                                            });
                                          }
                                        }
                                      }, icon: Icon(
                                        Icons.favorite,
                                        size: 33,
                                        color: begendiklerim.contains(meyveler["urunId"]) ? Colors.red : Colors.grey
                                        ,)),
                                      IconButton(onPressed: (){
                                        sepeteEkleme(widget.username, meyveler["urunId"]);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("Sepetinze Eklendi."),
                                              action: SnackBarAction(label: "Tamam", onPressed: (){}),
                                            )
                                        );
                                      }, icon: Icon(Icons.add_shopping_cart,size: 33,color: Colors.black,))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Image.asset("resimler/${meyveler["urunResmi"]}" , width: 200, height: 130,),
                                      Row(mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(meyveler["urunAdi"] + " " , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                                          Text(meyveler["urunFiyati"].toString() + " ₺/kg" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
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
