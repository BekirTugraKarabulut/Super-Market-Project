import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:marketflutter/pages/Kayit.dart';
import 'package:marketflutter/pages/anasayfa.dart';

class Giris extends StatefulWidget {
  const Giris({super.key});

  @override
  State<Giris> createState() => _GirisState();
}

class _GirisState extends State<Giris> {

  var emailKontrol = TextEditingController();
  var passwordKontrol = TextEditingController();
  
  Future<void> authenticate() async{
    
    final url = Uri.parse("http://10.0.2.2:8099/authenticate");

    final response = await http.post(

      url,
      headers: {"Content-Type" : "application/json"},
      body: jsonEncode
        (
          {
            "username" : emailKontrol.text,
            "password" : passwordKontrol.text
          }
        )
    );

    if(emailKontrol.text.isEmpty || passwordKontrol.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Tüm alanları doldurunuz !"),
            action: SnackBarAction(label: "Tamam", onPressed: (){}),
          )
      );
      return;
    }

    if(response.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Giriş Başarılı"))
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Lütfen bilgilerinizi kontrol ediniz !"),
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
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text("Giriş Sayfası",style: TextStyle(color: Colors.white),),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: IconButton(onPressed: (){
            Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined),color: Colors.white,),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: [
            Lottie.asset("asset/login.json" , height: 300 , width: 300),
            Padding(
              padding: const EdgeInsets.all(9),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: emailKontrol,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 13 , left: 4),
                        hintText: "E-Mail",
                        hintStyle: TextStyle(color: Colors.grey , fontWeight: FontWeight.bold),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(Icons.mail_outline , color: Colors.white,),
                        )
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 9 , left: 9 , top: 25),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: passwordKontrol,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 13 , left: 4),
                        hintText: "Parola",
                        hintStyle: TextStyle(color: Colors.grey , fontWeight: FontWeight.bold),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(Icons.key , color: Colors.white,),
                        )
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red),onPressed: (){
                authenticate();
              }, child: Text("Giriş Yap" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Kayit())),
                  child: Text("Hesabınız yok mu ?" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),)),
            ),
          ],
        ),
      ),
    );
  }
}
