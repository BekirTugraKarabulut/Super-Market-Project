import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:supermarketproject/pages/anasayfa.dart';
import 'package:supermarketproject/pages/kayit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Giris extends StatefulWidget {
  const Giris({super.key});

  @override
  State<Giris> createState() => _GirisState();
}

class _GirisState extends State<Giris> {

  var usernameKontrol = TextEditingController();
  var passwordKontrol = TextEditingController();

  Future<void> authenticate() async{

    final url = Uri.parse("http://10.0.2.2:8088/authenticate");

    final response = await http.post(

        url,
        headers: {"Content-Type" : "application/json"},
        body: jsonEncode
          (
            {
              "username" : usernameKontrol.text,
              "password" : passwordKontrol.text
            }
          )
    );

    if(usernameKontrol.text.isEmpty || passwordKontrol.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(("Lütfen tüm alanları doldurunuz !")),
        action: SnackBarAction(label: "Tamam", onPressed: (){}),
        )
      );
      return;
    }

    if(response.statusCode == 200){

      final data = jsonDecode(response.body);
      final accessToken = data["accessToken"];
      final refreshToken = data["refreshToken"];
      
      final accessTokenPref = await SharedPreferences.getInstance();
      final refreshTokenPref = await SharedPreferences.getInstance();
      
      await accessTokenPref.setString("accessToken", accessToken);
      await refreshTokenPref.setString("refreshToken", refreshToken);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Giriş Başarılı"))
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa(username: usernameKontrol.text)));

    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hatalı deneme. Bilgilerini Kontrol Ediniz!"),
        action: SnackBarAction(label: "Tamam", onPressed: (){}),
        )
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_outlined , color: Colors.white,)),
        centerTitle: true,
        title: Text("Giriş", style: TextStyle(color: Colors.white , fontFamily: "BebasNeue" , fontSize: 25),),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          children: [
            Lottie.asset("asset/Login.json" , height: 250 , width: 250),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),
                    controller: usernameKontrol,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 5 , bottom: 4),
                        child: Icon(Icons.mail , color: Colors.white70,),
                      ),
                      hintText: "E-Mail",
                      contentPadding: EdgeInsets.only(left: 10 , top: 12),
                      hintStyle: TextStyle(color: Colors.white70 , fontWeight: FontWeight.bold),
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
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),
                    controller: passwordKontrol,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 5 , bottom: 4),
                        child: Icon(Icons.key , color: Colors.white70,),
                      ),
                      hintText: "Parola",
                      contentPadding: EdgeInsets.only(left: 10 , top: 12),
                      hintStyle: TextStyle(color: Colors.white70 , fontWeight: FontWeight.bold),
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
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),onPressed: (){
                    authenticate();
              }, child: Text("Giriş Yap" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Kayit())),
                  child: Text("Hesabın yok mu ?", style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),)),
            ),
          ],
        ),
      ),
    );
  }
}
