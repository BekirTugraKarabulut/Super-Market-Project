import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:supermarketproject/pages/giris.dart';

class Kayit extends StatefulWidget {
  const Kayit({super.key});

  @override
  State<Kayit> createState() => _KayitState();
}

class _KayitState extends State<Kayit> {

  var usernameKontrol = TextEditingController();
  var adKontrol = TextEditingController();
  var passwordKontrol = TextEditingController();
  var adresKontrol = TextEditingController();
  var telefonNoKontrol = TextEditingController();

  Future<void> register() async{

    final url = Uri.parse("http://10.0.2.2:8088/register");

    final response = await http.post(
      url,
      headers: {"Content-Type" : "application/json"},
      body: jsonEncode
        (
          {
            "username" : usernameKontrol.text,
            "kullaniciAd" : adKontrol.text,
            "password" : passwordKontrol.text,
            "telefonNo" : telefonNoKontrol.text,
            "adres" : adresKontrol.text
          }
        )
    );

    if(usernameKontrol.text.isEmpty ||
       adresKontrol.text.isEmpty ||
       passwordKontrol.text.isEmpty ||
       telefonNoKontrol.text.isEmpty ||
       adresKontrol.text.isEmpty
    ){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Tüm alanları doldurunuz !"),
          action: SnackBarAction(label: "Tamam", onPressed: (){}),
          )
      );
      return;
    }

    if(response.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Kayıt İşlemi Başarılı !"))
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => Giris()));
    }
    if(response.statusCode == 401){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Email veya telefon numaranızı kontrol ediniz !"),
          action: SnackBarAction(label: "Tamam", onPressed: (){}),
          )
      );
      return;
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Kayıt Başarısız !"),
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
        title: Text("Kayit", style: TextStyle(fontFamily: "BebasNeue" , fontSize: 25),),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Lottie.asset("asset/Kayit.json" , height: 250 , width: 250),
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
                      controller: adKontrol,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 5 , bottom: 4),
                          child: Icon(Icons.account_circle , color: Colors.white70,),
                        ),
                        hintText: "Adınız",
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
                      controller: telefonNoKontrol,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 5 , bottom: 4),
                          child: Icon(Icons.phone , color: Colors.white70,),
                        ),
                        hintText: "Telefon No",
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
                      obscureText: true,
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
                      controller: adresKontrol,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 5 , bottom: 4),
                          child: Icon(Icons.maps_home_work_rounded , color: Colors.white70,),
                        ),
                        hintText: "Adres",
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
                          register();
                }, child: Text("Kayıt Ol" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Giris())),
                    child: Text("Zaten bir hesabım var ?", style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
