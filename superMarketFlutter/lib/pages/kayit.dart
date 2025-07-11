import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:marketflutter/pages/giris.dart';

class Kayit extends StatefulWidget {
  const Kayit({super.key});

  @override
  State<Kayit> createState() => _KayitState();
}

class _KayitState extends State<Kayit> {

  var emailKontrol = TextEditingController();
  var adKontrol = TextEditingController();
  var soyadKontrol = TextEditingController();
  var passwordKontrol = TextEditingController();
  var telefonKontrol = TextEditingController();
  var adresKontrol = TextEditingController();
  
  Future<void> kayitOl() async{
    
    final url = Uri.parse("http://10.0.2.2:8099/register");

    final response = await http.post(

      url,
      headers: {"Content-Type" : "application/json"},
      body: jsonEncode
        (
          {
            "username" : emailKontrol.text,
            "ad" : adKontrol.text,
            "soyad" : soyadKontrol.text,
            "password" : passwordKontrol.text,
            "telefonNo" : telefonKontrol.text,
            "adres" : adresKontrol.text
          }
        )
    );

    if(emailKontrol.text.isEmpty ||
        adKontrol.text.isEmpty ||
        soyadKontrol.text.isEmpty ||
        passwordKontrol.text.isEmpty ||
        telefonKontrol.text.isEmpty ||
        adresKontrol.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tüm alanları doldurunuz !"),
        action: SnackBarAction(label: "Tamam", onPressed: (){}),
        )
      );
      return;
    }

    if(response.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Kayıt Başarılı"))
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => Giris()));
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
          child: Text("Kayıt Sayfası",style: TextStyle(color: Colors.white),),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Icon(Icons.free_breakfast , color: Colors.white,),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Lottie.asset("asset/kayit.json",width: 200 , height: 200),
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
                      controller: adKontrol,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 13 , left: 4),
                          hintText: "Ad",
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
                            child: Icon(Icons.account_circle , color: Colors.white,),
                          )
                      ),
                    ),
                  ),
                ),
              ),
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
                      controller: soyadKontrol,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 13 , left: 4),
                          hintText: "Soyad",
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
                            child: Icon(Icons.account_circle , color: Colors.white,),
                          )
                      ),
                    ),
                  ),
                ),
              ),
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
                      controller: passwordKontrol,
                      obscureText: true,
                      keyboardType: TextInputType.text,
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
                      controller: telefonKontrol,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 13 , left: 4),
                          hintText: "Telefon No",
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
                            child: Icon(Icons.phone , color: Colors.white,),
                          )
                      ),
                    ),
                  ),
                ),
              ),
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
                      controller: adresKontrol,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 13 , left: 4),
                          hintText: "Adres",
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
                            child: Icon(Icons.home_work_rounded , color: Colors.white,),
                          )
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red),onPressed: (){
                  kayitOl();
                }, child: Text("Kayıt Ol" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Giris())),
                    child: Text("Zaten bir hesabım var ?" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
