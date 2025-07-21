import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Anasayfa extends StatefulWidget {

  final username;

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
                          width: 500,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: PageView.builder(
                                controller: _pageController,
                                itemCount: bilgiler!.length,
                                itemBuilder: (context, index) {
                                  var bilgilerList = bilgiler[index];
                                  return Column(
                                    children: [
                                      Image.asset("resimler/${bilgilerList["resimAdi"]}" , width: 200, height: 200,),
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
              Row(
                children: [
                  Column(
                    children: [
                      ElevatedButton(onPressed: (){}, child: Image.asset("resimler/et.jpeg",height: 50 , width: 50)),
                      ElevatedButton(onPressed: (){}, child: Text("data")),
                    ],
                  ),
                  ElevatedButton(onPressed: (){}, child: Text("data"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
