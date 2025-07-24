import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Supermarket extends StatefulWidget {
  const Supermarket({super.key});

  @override
  State<Supermarket> createState() => _SupermarketState();
}

class _SupermarketState extends State<Supermarket> {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Container(
              height: 80,
              child: Expanded(
                  child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10 , left: 7),
                          child: ElevatedButton(onPressed: (){
                            setState(() {
                              indeks = 0;
                            });
                          }, child: Text("Tümü" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),style: ElevatedButton.styleFrom(backgroundColor: indeks == 0 ? Colors.orange : Colors.blueAccent),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(onPressed: (){
                              setState(() {
                                indeks = 1;
                              });
                          }, child: Text("Kahvaltılıklar" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),style: ElevatedButton.styleFrom(backgroundColor: indeks == 1 ? Colors.orange : Colors.blueAccent),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(onPressed: (){
                            setState(() {
                              indeks = 2;
                            });
                          }, child: Text("Kişisel Bakım" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),style: ElevatedButton.styleFrom(backgroundColor: indeks == 2 ? Colors.orange : Colors.blueAccent),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(onPressed: (){
                            setState(() {
                              indeks = 3;
                            });
                          }, child: Text("Et ve Tavuk" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),style: ElevatedButton.styleFrom(backgroundColor: indeks == 3 ? Colors.orange : Colors.blueAccent),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(onPressed: (){
                            setState(() {
                              indeks = 4;
                            });
                          }, child: Text("Ev Bakımı" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),style: ElevatedButton.styleFrom(backgroundColor: indeks == 4 ? Colors.orange : Colors.blueAccent),),
                        ),
                      ],
                    );
                  },
                  ),
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
                        borderSide: BorderSide(color: Colors.white)
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                      ),
                      suffixIcon: Icon(Icons.search , size: 25, color: Colors.black,)
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                  future: urunlerGetir(indeks),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      var urunlerListesi = snapshot.data;
                      return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                          itemCount: urunlerListesi!.length,
                          itemBuilder: (context, index) {
                            var urun = urunlerListesi[index];
                            return Card(
                              child: Column(
                                children: [
                                  Text(urun["urunAdi"]),
                                  Text(urun["urunFiyati"].toString() + " ₺")
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
            )
          ],
        ),
      ),
    );
  }
}
