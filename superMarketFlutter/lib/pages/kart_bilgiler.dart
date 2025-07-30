import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:supermarketproject/pages/anasayfa.dart';

class KartBilgiler extends StatefulWidget {

  var username;

  KartBilgiler({required this.username});

  @override
  State<KartBilgiler> createState() => _KartBilgilerState();
}

class _KartBilgilerState extends State<KartBilgiler> {

  var kartNumarasiKontrol = TextEditingController();
  var cvvKontrol = TextEditingController();
  var dogumYiliKontrol = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa(username: widget.username)));
            }, icon: Icon(Icons.home , color: Colors.white, size: 29,)),
          )
        ],
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new_rounded , color: Colors.white,)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text("Satın Al" , style: TextStyle(color: Colors.white , fontFamily: "BebasNeue"),),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Lottie.asset("asset/Credit Card.json"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: TextField(
                    controller: kartNumarasiKontrol,
                    style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Icon(Icons.credit_card , color: Colors.white,),
                      ),
                      contentPadding: EdgeInsets.only(left: 8 , top: 12),
                      hintText: "Kart Numarası",
                      hintStyle: TextStyle(color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
