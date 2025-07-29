import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Supermarket extends StatefulWidget {

  var username;

  Supermarket({required this.username});

  @override
  State<Supermarket> createState() => _SupermarketState();
}

class _SupermarketState extends State<Supermarket> {

  Set<int> begendiklerim = {};

  var aramaKontrol = TextEditingController();

  int indeks = 1;

  Future<List<dynamic>> urunlerGetir(indeks) async{

    final accessTokenPref = await SharedPreferences.getInstance();
    final accessToken = accessTokenPref.getString("accessToken");

    final url = Uri.parse("http://10.0.2.2:8088/urun/${indeks}");

    final response = await http.get(

        url,
        headers: {
          "Content-Type" : "application/json",
          "Authorization" : "Bearer $accessToken"
        }
    );

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw Exception("Bilgiler Gelmedi");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new_rounded , color: Colors.white,)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text("Super Market" , style: TextStyle(color: Colors.white , fontFamily: "BebasNeue"),),
      ),
      body: Center(
        child: Column(
          children: [
              SizedBox(
                height: 70,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(onPressed: (){
                                setState(() {
                                  indeks = 1;
                                });
                            }, child: Text("Kahvaltılıklar" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),
                              style: ElevatedButton.styleFrom(backgroundColor: indeks == 1 ? Colors.black : Colors.blueAccent),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(onPressed: (){
                              setState(() {
                                indeks = 2;
                              });
                            }, child: Text("Kişisel Bakım" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),
                              style: ElevatedButton.styleFrom(backgroundColor: indeks == 2 ? Colors.black : Colors.blueAccent),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(onPressed: (){
                              setState(() {
                                indeks = 3;
                              });
                            }, child: Text("Et ve Tavuk" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),
                              style: ElevatedButton.styleFrom(backgroundColor: indeks == 3 ? Colors.black : Colors.blueAccent),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(onPressed: (){
                              setState(() {
                                indeks = 4;
                              });
                            }, child: Text("Ev Bakımı" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),
                              style: ElevatedButton.styleFrom(backgroundColor: indeks == 4 ? Colors.black : Colors.blueAccent),),
                          ),
                        ],
                      );
                    },
                    ),
              ),
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
            Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: FutureBuilder<List<dynamic>>(
                        future: urunlerGetir(indeks),
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            var urunlerListesi = snapshot.data;
                            return GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                              itemCount: urunlerListesi!.length,
                              itemBuilder: (context, index) {
                                var urun = urunlerListesi[index];
                                return Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Card(
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                onPressed: () async {
                                                  int urunId = urun["urunId"];
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
                                                },
                                                icon: Icon(
                                                  Icons.favorite,
                                                  size: 33,
                                                  color: begendiklerim.contains(urun["urunId"]) ? Colors.red : Colors.grey,
                                                ),
                                              ),
                                              IconButton(onPressed: (){

                                              }, icon: Icon(Icons.add_shopping_cart,size: 33,color: Colors.black,))
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Image.asset("resimler/${urun["urunResmi"]}" , width: 200, height: 130,),
                                              Row(mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(urun["urunAdi"] + " " , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                                                  Text(urun["urunFiyati"].toString() + " ₺" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
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
                  ),
          ],
        ),
      ),
    );
  }
}
