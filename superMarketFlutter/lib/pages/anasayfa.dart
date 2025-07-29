import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:supermarketproject/pages/account.dart';
import 'package:supermarketproject/pages/superAburcubur.dart';
import 'package:supermarketproject/pages/superManav.dart';
import 'package:supermarketproject/pages/superMarket.dart';

class Anasayfa extends StatefulWidget {

  var username;

  Anasayfa({required this.username});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  
  final PageController _pageController = PageController();
  
  Future<List<dynamic>> smoothList() async{
    
    final accessTokenPref = await SharedPreferences.getInstance();
    final accessToken = accessTokenPref.getString("accessToken");
    
    final url = Uri.parse("http://10.0.2.2:8088/all-smooth");

    final response = await http.get(

      url,
      headers: {
                 "Content-Type" : "application/json",
                 "Authorization" : "Bearer $accessToken"
              }
    );

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
    else{
      throw Exception("Bilgiler Gelmedi!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Account(username: widget.username)));
            }, icon: Icon(Icons.account_circle , size: 35, color: Colors.white,)),
          )
        ],
        leading: Icon(Icons.free_breakfast , color: Colors.white, size: 25,),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text("Anasayfa" , style: TextStyle(color: Colors.white , fontFamily: "BebasNeue"),),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text("Fırsat Ürünleri" , style: TextStyle(color: Colors.black , fontFamily: "BebasNeue" , fontSize: 25),),
              ),
              FutureBuilder<List<dynamic>>(
                    future: smoothList(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        var bilgiler = snapshot.data;
                        return SizedBox(
                          height: 300,
                          width: 800,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: PageView.builder(
                                controller: _pageController,
                                itemCount: bilgiler!.length,
                                itemBuilder: (context, index) {
                                  var bilgilerList = bilgiler[index];
                                  return Column(
                                    children: [
                                      Container(
                                      color: Colors.purple
                                      ,child: Image.asset("resimler/${bilgilerList["resimAdi"]}" , width: 450, height: 250,)),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: SmoothPageIndicator(
                                            controller: _pageController,
                                            count: bilgiler.length,
                                            effect: WormEffect(
                                              dotHeight: 8,
                                              dotWidth: 8,
                                              activeDotColor: Colors.red
                                            ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                            ),
                          ),
                        );
                      }else{
                        return const CircularProgressIndicator();
                      }
                      },
                ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15 , left: 15),
                    child: GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Supermarket(username: widget.username))),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: Colors.black
                          ),
                          color: Colors.white
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset("resimler/market.jpeg" , width: 200, height: 150,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: SizedBox(
                                  width: 165,
                                  child: Text("Aradığın her şey burada. İndirimli ve uygun fiyatlar seni bekliyor !" , style: TextStyle(color: Colors.black ,fontWeight: FontWeight.bold), textAlign: TextAlign.start,))
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 290),
                              child: Text("Süper-Market" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Supermanav(username: widget.username))),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(
                                        color: Colors.black
                                    ),
                                    color: Colors.white
                                ),
                                child: Column(
                                  children: [
                                    Image.asset("resimler/meyvelerim.jpeg" , width: 200, height: 150,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 90),
                                      child: Text("Super-Manav" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Superaburcubur(username: widget.username))),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(
                                        color: Colors.black
                                    ),
                                    color: Colors.white
                                ),
                                child: Column(
                                  children: [
                                    Image.asset("resimler/aburcubur.jpeg" , width: 200, height: 150,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 80),
                                      child: Text("Super-Aburcubur" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
